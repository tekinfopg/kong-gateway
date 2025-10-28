# Token Manager V2 - Quick Start Guide

## 🎯 TL;DR

Plugin untuk **automatic token management** dengan auto-refresh saat expired.

**✅ FULLY COMPATIBLE dengan Keycloak Introspection!**

## 📦 Files

```
token-manager-v2/
├── handler.lua                  # Main plugin handler
├── schema.lua                   # Configuration schema
├── kong.yml                     # Plugin metadata
├── README.md                    # Full documentation
├── KEYCLOAK_INTEGRATION.md      # Keycloak integration guide ⭐
├── DEBUGGING.md                 # Troubleshooting guide
└── LOGGING_QUICK_REF.md        # Quick logging reference
```

## 🚀 Quick Install

### 1. Reload Kong
```bash
docker exec kong-gateway kong reload
```

### 2. Basic Setup
```bash
curl -X POST http://kong-admin:8001/services/YOUR-SERVICE/plugins \
  --data "name=token-manager-v2" \
  --data "config.access_token=initial_token" \
  --data "config.refresh_endpoint=http://auth/login?user=admin&pass=secret" \
  --data "config.refresh_method=POST"
```

### 3. Test
```bash
curl -X GET http://kong:8000/your-api/endpoint -H "apikey: your-key"
```

## 🔗 With Keycloak

### Setup Token Manager V2
```bash
curl -X POST http://kong-admin:8001/services/YOUR-SERVICE/plugins \
  --data "name=token-manager-v2" \
  --data "config.access_token=initial_keycloak_token" \
  --data "config.refresh_endpoint=https://keycloak/realms/myrealm/protocol/openid-connect/token" \
  --data "config.refresh_body=grant_type=client_credentials&client_id=my-client&client_secret=secret" \
  --data "config.content_type=application/x-www-form-urlencoded"
```

### Setup Keycloak Introspection
```bash
curl -X POST http://kong-admin:8001/services/YOUR-SERVICE/plugins \
  --data "name=keycloak-introspection" \
  --data "config.introspection_url=https://keycloak/realms/myrealm/protocol/openid-connect/token/introspect" \
  --data "config.client_id=introspection-client" \
  --data "config.client_secret=introspection-secret"
```

**✅ Done! Token auto-refresh + Keycloak validation working together!**

## 📊 Quick Debug

### See if plugin is working
```bash
docker logs kong-gateway 2>&1 | grep "\[Access Phase\].*✅"
```

### See token refresh
```bash
docker logs kong-gateway 2>&1 | grep "\[Refresh Token\].*✅"
```

### See all errors
```bash
docker logs kong-gateway 2>&1 | grep "FAILED"
```

### Real-time monitoring
```bash
docker logs kong-gateway -f 2>&1 | grep -E "\[Access Phase\]|\[Refresh Token\]"
```

## 🎨 Log Prefixes

| Prefix | Meaning |
|--------|---------|
| `[Access Phase]` | Request handling |
| `[Response Phase]` | Response & 401 handling |
| `[Refresh Token]` | Token refresh process |
| `[Store Token]` | Saving to Redis |
| `[Get Token]` | Reading from Redis |
| `[Redis]` | Redis operations |
| `✅` | Success |
| `❌` / `FAILED` | Error |
| `⚠️` | Warning |

## 📖 Documentation Links

- **Full Documentation**: [README.md](./README.md)
- **Keycloak Integration**: [KEYCLOAK_INTEGRATION.md](./KEYCLOAK_INTEGRATION.md) ⭐
- **Troubleshooting**: [DEBUGGING.md](./DEBUGGING.md)
- **Logging Reference**: [LOGGING_QUICK_REF.md](./LOGGING_QUICK_REF.md)

## 🔥 Common Configs

### 1. Query Parameter Auth (No Body)
```bash
--data "config.refresh_endpoint=http://auth/login?username=admin&password=secret"
# Leave refresh_body empty!
```

### 2. JSON Body Auth
```bash
--data "config.refresh_endpoint=http://auth/token"
--data 'config.refresh_body={"grant_type":"client_credentials","client_id":"app"}'
--data "config.content_type=application/json"
```

### 3. Form Urlencoded
```bash
--data "config.refresh_endpoint=http://auth/token"
--data "config.refresh_body=grant_type=password&username=admin&password=secret"
--data "config.content_type=application/x-www-form-urlencoded"
```

### 4. With Refresh Token
```bash
--data "config.access_token=initial_access"
--data "config.refresh_token=initial_refresh"
--data "config.refresh_endpoint=http://auth/refresh"
--data 'config.refresh_body={"refresh_token":"$refresh_token"}'
```

## ⚡ Key Features

✅ Auto token refresh on 401  
✅ Redis storage per-service  
✅ Query param auth support  
✅ JSON & form-urlencoded  
✅ Keycloak compatible  
✅ Detailed logging with prefixes  
✅ No infinite loops (fixed!)  
✅ Production ready  

## 🆚 V1 vs V2

| Feature | V1 | V2 |
|---------|----|----|
| Infinite loop bug | ❌ | ✅ Fixed |
| Query param auth | ❌ | ✅ Works |
| Manual retry | ❌ Broken | ✅ Client-side |
| Keycloak support | ⚠️ Untested | ✅ Fully tested |
| Detailed logs | ⚠️ Basic | ✅ With prefixes |

## 🎯 Next Steps

1. **Read**: [KEYCLOAK_INTEGRATION.md](./KEYCLOAK_INTEGRATION.md) if using Keycloak
2. **Test**: Make some requests and check logs
3. **Monitor**: Use logging commands from [LOGGING_QUICK_REF.md](./LOGGING_QUICK_REF.md)
4. **Debug**: If issues, see [DEBUGGING.md](./DEBUGGING.md)

## 💡 Pro Tips

1. Always check logs after configuration
2. Use debug mode (`KONG_LOG_LEVEL=debug`) during development
3. Client MUST implement retry on 401
4. Refresh endpoint MUST return JSON with `access_token` field
5. Use service accounts for service-to-service auth

## 🐛 Issues?

```bash
# Generate debug report
docker logs kong-gateway --tail 200 2>&1 | grep -E "\[Access Phase\]|\[Response Phase\]|\[Refresh Token\]|FAILED" > debug.log

# Check Redis
docker exec kong-redis redis-cli keys "*"

# Check plugin is loaded
docker exec kong-gateway kong plugin list
```

---

**Need help?** Check the documentation files above! 📚
