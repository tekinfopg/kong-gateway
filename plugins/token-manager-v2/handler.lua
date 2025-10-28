--[[
@module TokenManagerV2Plugin
@description A Kong plugin for managing access and refresh tokens with Redis storage (Version 2).

Key Features:
- Token storage and retrieval using Redis
- Automatic token refresh on 401 responses
- Support for JSON and form-urlencoded content types
- Support for query parameter authentication (no body required)
- Token placeholder substitution in headers
- Service-specific token management using prefixes

Configuration Fields:
- content_type: Content type for token refresh requests
- refresh_endpoint: URL endpoint for token refresh (can include query parameters)
- refresh_method: HTTP method for refresh requests
- refresh_body: Request body template for refresh (optional, leave empty for query param auth)
- ssl_verify: Boolean to enable/disable SSL verification
- header_key: Header key for token insertion
- header_value: Header value template with $access_token placeholder
- access_token: Initial access token
- refresh_token: Initial refresh token

Redis Configuration:
- Host: kong-redis (configurable via REDIS_HOST env var)
- Port: 6379 (configurable via REDIS_PORT env var)
- Timeout: 1000ms (configurable via REDIS_TIMEOUT env var)

Main Functions:
- access(conf): Handles token insertion in request phase
- response(conf): Manages token refresh on 401 responses
- refresh_token(conf, use_stored_token): Performs token refresh
- store_token_in_redis(key, value): Saves tokens to Redis
- get_token_from_redis(key): Retrieves tokens from Redis
- clear_redis_tokens(): Removes stored tokens
- substitute_value(header_value, new_value, placeholder): Replaces token placeholders

Plugin Properties:
- PRIORITY: 802
- VERSION: 2.0

Changes from v1:
- Fixed infinite loop issue in response handler
- Removed problematic is_refresh_endpoint function
- Improved handling of empty refresh_body for query param authentication
- Simplified retry logic - client handles retries instead of plugin
- Better error handling and logging

Note: This plugin requires Redis connection and proper configuration of refresh endpoints.
--]]
local http = require "resty.http"
local cjson = require "cjson"
local redis = require "resty.redis"
local redis_host = os.getenv("REDIS_HOST") or "kong-redis"
local redis_port = tonumber(os.getenv("REDIS_PORT")) or 6379
local redis_timeout = tonumber(os.getenv("REDIS_TIMEOUT")) or 1000

local TokenManagerV2Plugin = {
    PRIORITY = 802,
    VERSION = "2.0"
}

-- Get service prefix
local function get_service_prefix()
    local service = kong.router.get_service()
    if service and service.name then
        return service.name .. ":"
    end
    return "default:"
end

-- Connect to Redis
local function connect_to_redis()
    local red = redis:new()
    red:set_timeout(redis_timeout)

    kong.log.debug("[Redis] Attempting to connect to ", redis_host, ":", redis_port)
    local ok, err = red:connect(redis_host, redis_port)
    if not ok then
        kong.log.err("[Redis] FAILED to connect to ", redis_host, ":", redis_port, " - Error: ", err)
        return nil
    end
    kong.log.debug("[Redis] Successfully connected to ", redis_host, ":", redis_port)
    return red
end

-- Close Redis connection
local function close_redis(red)
    if not red then
        return
    end
    local ok, err = red:set_keepalive(60000, 100)
    if not ok then
        kong.log.err("[Redis] FAILED to set keepalive - Error: ", err)
    else
        kong.log.debug("[Redis] Connection returned to pool")
    end
end

-- Clear tokens from Redis
local function clear_redis_tokens()
    kong.log.info("[Clear Tokens] Starting token clearing process")
    local red = connect_to_redis()
    if not red then
        kong.log.err("[Clear Tokens] FAILED to connect to Redis while clearing tokens")
        return false
    end

    local service_prefix = get_service_prefix()
    kong.log.debug("[Clear Tokens] Using service prefix: ", service_prefix)
    local keys = {service_prefix .. "access_token", service_prefix .. "refresh_token"}

    -- Delete each key
    for _, key in ipairs(keys) do
        kong.log.debug("[Clear Tokens] Attempting to delete key: ", key)
        local ok, err = red:del(key)
        if not ok then
            kong.log.err("[Clear Tokens] FAILED to delete key: ", key, " - Error: ", err)
            close_redis(red)
            return false
        end
        kong.log.info("[Clear Tokens] Successfully deleted Redis key: ", key)
    end

    close_redis(red)
    kong.log.info("[Clear Tokens] All tokens cleared successfully")
    return true
end

-- Store token in Redis
local function store_token_in_redis(key, value)
    local red = connect_to_redis()
    if not red then
        kong.log.err("[Store Token] FAILED to connect to Redis")
        return
    end

    local service_prefix = get_service_prefix()
    local full_key = service_prefix .. key
    kong.log.info("[Store Token] Storing token with key: ", full_key)
    kong.log.debug("[Store Token] Token value length: ", string.len(value), " characters")
    
    local ok, err = red:set(full_key, value)
    if not ok then
        kong.log.err("[Store Token] FAILED to store token in Redis - Key: ", full_key, " - Error: ", err)
        close_redis(red)
        return
    end
    
    kong.log.info("[Store Token] Successfully stored token in Redis - Key: ", full_key)
    close_redis(red)
end

-- Get token from Redis
local function get_token_from_redis(key)
    local red = connect_to_redis()
    if not red then
        kong.log.err("[Get Token] FAILED to connect to Redis")
        return nil
    end

    local service_prefix = get_service_prefix()
    local full_key = service_prefix .. key
    kong.log.debug("[Get Token] Attempting to retrieve key: ", full_key)

    local res, err = red:get(full_key)
    if not res then
        kong.log.err("[Get Token] FAILED to get token from Redis - Key: ", full_key, " - Error: ", err)
        close_redis(red)
        return nil
    end

    -- Handle NULL values from Redis
    if res == ngx.null then
        kong.log.debug("[Get Token] Token not found in Redis for key: ", full_key)
        close_redis(red)
        return nil
    end

    kong.log.info("[Get Token] Successfully retrieved token from Redis - Key: ", full_key, " - Length: ", string.len(res), " chars")
    close_redis(red)
    return tostring(res)
end

-- Substitute value in header
local function substitute_value(header_value, new_value, placeholder)
    kong.log.debug("[Substitute] Input type: ", type(header_value), " - Placeholder: ", placeholder)
    
    -- Handle table (JSON) values
    if type(header_value) == "table" then
        local json_str = cjson.encode(header_value)
        kong.log.debug("[Substitute] Original JSON string: ", json_str)

        -- Escape special characters in placeholder
        local escaped_placeholder = placeholder:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")

        -- Replace placeholder in JSON string
        local new_json_str = json_str:gsub(escaped_placeholder, new_value)
        kong.log.debug("[Substitute] Modified JSON string: ", new_json_str)

        -- Decode back to table
        local success, result = pcall(cjson.decode, new_json_str)
        if not success then
            kong.log.err("[Substitute] FAILED to decode modified JSON - Error: ", result)
            return header_value
        end

        kong.log.info("[Substitute] Successfully substituted value in JSON table")
        return result
    end

    -- Handle string values (original behavior)
    if type(header_value) == "string" then
        local escaped_placeholder = placeholder:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
        local new_header_value, n = header_value:gsub(escaped_placeholder, new_value)

        kong.log.info("[Substitute] Substituted '", placeholder, "' in string (", n, " replacements)")
        kong.log.debug("[Substitute] Result: ", new_header_value)

        return new_header_value
    end

    -- Return original value for unsupported types
    kong.log.warn("[Substitute] Unsupported header_value type: ", type(header_value))
    return header_value
end

-- Refresh new `access_token` and `refresh_token`
local function refresh_token(conf, use_stored_token)
    kong.log.info("[Refresh Token] ========== Starting Token Refresh Process ==========")
    kong.log.info("[Refresh Token] Use stored token: ", use_stored_token)
    kong.log.debug("[Refresh Token] Refresh endpoint: ", conf.refresh_endpoint)
    kong.log.debug("[Refresh Token] Refresh method: ", conf.refresh_method)
    kong.log.debug("[Refresh Token] Content type: ", conf.content_type)
    
    local httpc = http.new()
    local headers = {
        ["Content-Type"] = conf.content_type
    }

    local body = nil -- Inisialisasi body sebagai nil

    -- Only process body if refresh_body is provided
    if conf.refresh_body and conf.refresh_body ~= "" then
        kong.log.info("[Refresh Token] Processing refresh body")
        local stored_refresh_token = get_token_from_redis("refresh_token") or conf.refresh_token
        local refresh_token_val = conf.refresh_token
        
        if use_stored_token then
            kong.log.debug("[Refresh Token] Using stored refresh token from Redis")
            refresh_token_val = stored_refresh_token
        else
            kong.log.debug("[Refresh Token] Using refresh token from config")
        end

        -- Handle JSON content type
        if conf.content_type == "application/json" then
            kong.log.debug("[Refresh Token] Processing JSON body")
            local parsed_body, err = cjson.decode(conf.refresh_body)
            if not parsed_body then
                kong.log.err("[Refresh Token] FAILED to decode JSON body - Error: ", err)
                return nil, nil, "Failed to decode JSON body: " .. tostring(err)
            end
            parsed_body = substitute_value(parsed_body, refresh_token_val, "$refresh_token")
            body, err = cjson.encode(parsed_body)
            if not body then
                kong.log.err("[Refresh Token] FAILED to encode JSON body - Error: ", err)
                return nil, nil, "Failed to encode JSON body: " .. tostring(err)
            end
            kong.log.debug("[Refresh Token] JSON body prepared: ", body)
        -- Handle form-urlencoded content type
        elseif conf.content_type == "application/x-www-form-urlencoded" then
            kong.log.debug("[Refresh Token] Processing form-urlencoded body")
            local body_table
            
            if type(conf.refresh_body) == "string" then
                body_table = {}
                for key, value in conf.refresh_body:gmatch("([^&=]+)=([^&=]+)") do
                    body_table[key] = value
                end
                -- Replace refresh token placeholder if exists
                if body_table.refresh_token == "$refresh_token" then
                    body_table.refresh_token = refresh_token_val
                end
            else
                body_table = conf.refresh_body
            end

            body = ngx.encode_args(body_table)
            kong.log.debug("[Refresh Token] Form-urlencoded body prepared: ", body)
        end
    else
        kong.log.info("[Refresh Token] No refresh_body provided - using query params or empty body")
    end

    -- Make HTTP request to refresh endpoint
    kong.log.info("[Refresh Token] Making HTTP request to: ", conf.refresh_endpoint)
    local res, err = httpc:request_uri(conf.refresh_endpoint, {
        method = conf.refresh_method,
        body = body,
        headers = headers,
        ssl_verify = conf.ssl_verify
    })

    if not res then
        kong.log.err("[Refresh Token] FAILED to make refresh request - Error: ", err)
        kong.log.info("[Refresh Token] Clearing stored tokens due to request failure")
        clear_redis_tokens()
        return nil, nil, "HTTP request failed: " .. tostring(err)
    end

    kong.log.info("[Refresh Token] Received response - Status: ", res.status)
    kong.log.debug("[Refresh Token] Response body: ", res.body)

    if res.status ~= 200 then
        kong.log.err("[Refresh Token] FAILED - Unexpected status code: ", res.status)
        kong.log.err("[Refresh Token] Response body: ", res.body)
        kong.log.info("[Refresh Token] Clearing stored tokens due to non-200 response")
        clear_redis_tokens()
        return nil, nil, "Refresh endpoint returned status " .. res.status
    end

    -- Parse response body
    kong.log.debug("[Refresh Token] Parsing JSON response")
    local parsed_body, err = cjson.decode(res.body)
    if not parsed_body then
        kong.log.err("[Refresh Token] FAILED to decode JSON response - Error: ", err)
        kong.log.err("[Refresh Token] Response body was: ", res.body)
        return nil, nil, "Failed to decode JSON response: " .. tostring(err)
    end

    local new_token = parsed_body.access_token
    local new_refresh_token = parsed_body.refresh_token

    -- Check if new token is present
    if not new_token then
        kong.log.err("[Refresh Token] FAILED - No 'access_token' field found in response")
        -- Log available fields for debugging
        local available_fields = {}
        for key, _ in pairs(parsed_body) do
            table.insert(available_fields, key)
        end
        kong.log.err("[Refresh Token] Available fields in response: ", table.concat(available_fields, ", "))
        return nil, nil, "No access_token found in refresh response"
    end

    kong.log.info("[Refresh Token] ✅ Successfully received new tokens")
    kong.log.debug("[Refresh Token] New access token length: ", string.len(new_token), " chars")
    if new_refresh_token then
        kong.log.debug("[Refresh Token] New refresh token length: ", string.len(new_refresh_token), " chars")
    end
    
    -- Store new tokens in Redis
    if new_token then
        store_token_in_redis("access_token", new_token)
    end
    if new_refresh_token then
        store_token_in_redis("refresh_token", new_refresh_token)
    end
    
    httpc:close()
    kong.log.info("[Refresh Token] ========== Token Refresh Complete ==========")
    return new_token, new_refresh_token, nil
end

function TokenManagerV2Plugin:access(conf)
    kong.log.info("[Access Phase] ========== Starting Access Phase ==========")
    
    -- Handle Clear-Redis-Token header for manual token clearing
    if kong.request.get_header("Clear-Redis-Token") == "clear" then
        kong.log.info("[Access Phase] Manual token clearing requested via header")
        if clear_redis_tokens() then
            kong.log.info("[Access Phase] Successfully cleared all tokens from Redis")
        else
            kong.log.err("[Access Phase] Failed to clear tokens from Redis")
        end
    end

    local service = kong.router.get_service()
    local service_name = service and service.name or "unknown"
    kong.log.info("[Access Phase] Service: ", service_name)
    
    -- Try to get token from Redis first, fallback to config
    kong.log.debug("[Access Phase] Checking for stored token in Redis")
    local stored_access_token = get_token_from_redis("access_token")
    local access_token = stored_access_token or conf.access_token

    if stored_access_token then
        kong.log.info("[Access Phase] Using access token from Redis")
    else
        kong.log.info("[Access Phase] Using access token from config (no token in Redis)")
    end

    if not access_token or access_token == "" then
        kong.log.err("[Access Phase] FAILED - No access token available!")
        return kong.response.exit(401, {
            message = "Access token not available"
        })
    end

    kong.log.info("[Access Phase] Setting header: ", conf.header_key)
    kong.log.debug("[Access Phase] Token length: ", string.len(access_token), " characters")
    
    -- Substitute token in header value and set header
    local token_value = substitute_value(conf.header_value, access_token, "$access_token")
    kong.service.request.set_header(conf.header_key, token_value)
    
    kong.log.info("[Access Phase] ✅ Access phase complete - Token injected")
    kong.log.info("[Access Phase] ========================================")
end

function TokenManagerV2Plugin:response(conf)
    kong.log.info("[Response Phase] ========== Starting Response Phase ==========")
    local status = kong.response.get_status()
    kong.log.info("[Response Phase] Upstream response status: ", status)

    -- Handle 401 Unauthorized - attempt to refresh token
    if status == 401 then
        kong.log.warn("[Response Phase] ⚠️  Detected 401 Unauthorized - Token may be expired")
        kong.log.info("[Response Phase] Attempting to refresh token...")

        -- Try to refresh token using stored token first, then config token
        kong.log.debug("[Response Phase] First attempt: Using stored token from Redis")
        local new_token, _, err = refresh_token(conf, true)
        
        if not new_token then
            kong.log.warn("[Response Phase] First attempt failed, trying with config token")
            new_token, _, err = refresh_token(conf, false)
        end

        if not new_token then
            kong.log.err("[Response Phase] ❌ FAILED to refresh token after all attempts")
            kong.log.err("[Response Phase] Error: ", err)
            kong.log.info("[Response Phase] Passing 401 response to client")
            -- Don't exit, let the 401 response pass through to client
            return
        end

        kong.log.info("[Response Phase] ✅ Token refreshed successfully")
        kong.log.info("[Response Phase] New token stored in Redis")
        kong.log.info("[Response Phase] Client should retry the request with new token")
        kong.log.info("[Response Phase] Passing 401 response to client to trigger retry")
        -- Let the 401 response pass through to client
        -- On client retry, :access handler will use the new token from Redis
    else
        kong.log.debug("[Response Phase] Status is not 401, no action needed")
    end
    
    kong.log.info("[Response Phase] ========================================")
end

return TokenManagerV2Plugin
