--[[
    KeycloakIntrospectionHandler - Kong plugin for Keycloak token introspection

    This plugin validates OAuth2 access tokens by introspecting them against a Keycloak server.
    It checks if the token is active and adds user information to request headers.

    @module KeycloakIntrospectionHandler
    @version 1.0.0
    @priority 1200

    Configuration parameters:
    - introspection_url: URL of the Keycloak introspection endpoint
    - client_id: OAuth2 client ID for introspection
    - client_secret: OAuth2 client secret for introspection
    - authorized_clients: List of authorized client IDs
    - authorized_client_roles: List of authorized client roles

    Functionality:
    1. Extracts access token from Authorization header
    2. Makes introspection request to Keycloak server
    3. Validates token status and activity
    4. Validates authorized clients and client roles

    Error responses:
    - 401 Unauthorized: Missing or invalid token
    - 500 Internal Server Error: Introspection request failed

    @usage
    Configure the plugin in Kong with Keycloak credentials and introspection URL
--]]
-- keycloak-introspection/handler.lua

local http = require("resty.http")
local cjson = require("cjson")

local KeycloakIntrospectionHandler = {
    VERSION  = "1.0.0",
    PRIORITY = 1200,
}

function KeycloakIntrospectionHandler:access(config)
    -- Get the access token from the request headers
    local access_token = ngx.var.http_authorization

    if not access_token then
        ngx.log(ngx.ERR, "Access token not found in request headers")
        return ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end
    -- Introspect the access token with Keycloak

    local introspection_url = config.introspection_url
    --local access_token = ngx.var.http_authorization
    local httpc = http.new()


    local headers = {
        ["Content-Type"] = "application/x-www-form-urlencoded",
        ["Authorization"] = "Basic " .. ngx.encode_base64(config.client_id .. ":" .. config.client_secret),
    }

    local body = "token=" .. access_token

    local request_options = {
        method = "POST",
        body = body,
        headers = headers,
    }

    local res, err = httpc:request_uri(introspection_url, request_options)

    ngx.log(ngx.NOTICE, "Entering access function")
    ngx.log(ngx.NOTICE, "body ", cjson.encode(request_options))
    ngx.log(ngx.NOTICE, "Plugin Configuration :", cjson.encode(config))

    if not res then
        ngx.log(ngx.ERR, "Failed to introspect token: ", err)
        return ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
    end

    if res.status ~= 200 then
        ngx.log(ngx.ERR, "Token introspection failed with status: ", res.status)
        return ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end

    -- Parse the introspection response
    local introspection_result = cjson.decode(res.body)
    local azp = introspection_result.azp
    ngx.log(ngx.NOTICE, "Introspection result: ", res.body)

    -- Check if the token is active
    if not introspection_result.active then
        ngx.log(ngx.ERR, "Access token is not active")
        return ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end

    -- Check if the token is from an authorized client
    if (#config.authorized_clients > 0) then
        local authorized_client = false

        for _, client_id in ipairs(config.authorized_clients) do
            if azp == client_id then
                authorized_client = true
                break
            end
        end

        if not authorized_client then
            ngx.log(ngx.ERR, "Access token is not from an authorized client")
            return ngx.exit(ngx.HTTP_UNAUTHORIZED)
        end
    end

    -- Check if the token has the required roles
    if (#config.authorized_client_roles > 0) then
        local authorized_roles = false

        local client_roles = introspection_result.resource_access[azp].roles
        local client_roles_hash = {}

        for _, role in ipairs(config.authorized_client_roles) do
            local client_id, extracted_role = role:match("([^:]+):(.*)")
            if not client_roles_hash[client_id] then
                client_roles_hash[client_id] = {}
            end
            client_roles_hash[client_id][extracted_role] = true
        end

        if client_roles then
            for _, client_role in ipairs(client_roles) do
                if client_roles_hash[azp] and client_roles_hash[azp][client_role] then
                    authorized_roles = true
                    break
                end
            end
        end

        if not authorized_roles then
            ngx.log(ngx.ERR, "Access token does not have the required roles")
            return ngx.exit(ngx.HTTP_UNAUTHORIZED)
        end
    end

    -- Log if the token introspection was successful
    ngx.log(ngx.INFO, "Token introspection successful")

    -- Close the HTTP connection
    httpc:close()
end

return KeycloakIntrospectionHandler
