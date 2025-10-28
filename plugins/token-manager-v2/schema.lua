--[[
Schema configuration for the Token Manager V2 Kong plugin.

This plugin manages access tokens and token refresh operations for API authentication.

Version 2 Changes:
- Fixed infinite loop issues
- Better support for query parameter authentication
- Improved error handling
- Simplified retry logic

Fields:
- consumer: No consumer configuration required
- protocols: HTTP protocol configuration

Config fields:
- access_token (string, required): Access token used for authentication
- refresh_token (string, optional): Token used to refresh the access token
- refresh_endpoint (string, required): Endpoint URL for refreshing access token
                                       Can include query parameters (e.g., ?username=user&password=pass)
- refresh_method (string, default="POST"): HTTP method for refresh token request
                                         Allowed: GET, POST, PUT, DELETE
- refresh_body (string, optional): Request body for refresh token
                                   Leave empty if using query parameters in refresh_endpoint
- content_type (string, default="application/json"): Content-Type header for refresh request
                                                    Allowed: application/json, 
                                                            application/x-www-form-urlencoded
- header_key (string, required, default="Authorization"): Header key for access token
- header_value (string, required, default="Bearer $access_token"): Header value format
                                                                   Use $access_token placeholder
- ssl_verify (boolean, required, default=false): Enable/disable SSL verification

@module token-manager-v2
@version 2.0
@author edoaurahman@gmail.com
]] --
local typedefs = require "kong.db.schema.typedefs"

return {
    name = "token-manager-v2",
    fields = {{
        consumer = typedefs.no_consumer
    }, {
        protocols = typedefs.protocols_http
    }, {
        config = {
            type = "record",
            fields = {{
                access_token = {
                    type = "string",
                    required = true
                }
            }, {
                refresh_token = {
                    type = "string",
                    required = false
                }
            }, {
                refresh_endpoint = {
                    type = "string",
                    required = true
                }
            }, {
                refresh_method = {
                    type = "string",
                    default = "POST",
                    one_of = {"GET", "POST", "PUT", "DELETE"}
                }
            }, {
                refresh_body = {
                    type = "string",
                    required = false
                }
            }, {
                content_type = {
                    type = "string",
                    default = "application/json",
                    one_of = {"application/json", "application/x-www-form-urlencoded"}
                }
            }, {
                header_key = {
                    type = "string",
                    required = true,
                    default = "Authorization"
                }
            }, {
                header_value = {
                    type = "string",
                    required = true,
                    default = "Bearer $access_token"
                }
            }, {
                ssl_verify = {
                    type = "boolean",
                    required = true,
                    default = false
                }
            }}
        }
    }}
}
