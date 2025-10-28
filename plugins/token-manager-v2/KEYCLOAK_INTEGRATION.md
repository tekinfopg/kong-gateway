# Token Manager V2 + Keycloak Introspection Integration

## ✅ Ya, FULLY COMPATIBLE!

Plugin **token-manager-v2** MENDUKUNG dan KOMPATIBEL dengan **keycloak-introspection** plugin!

## 🔗 Bagaimana Cara Kerjanya?

### Plugin Priority Order
```
1. key-auth          (Priority: ~1000) - API Key validation
2. keycloak-introspection (Priority: 1200) - Token introspection
3. token-manager-v2  (Priority: 802)  - Token injection & refresh
```

### Flow Diagram

```
Client Request
    ↓
┌─────────────────────────────────────────┐
│ 1. key-auth Plugin                      │
│    - Validate API Key                   │
└─────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────┐
│ 2. token-manager-v2 Plugin (Access)     │
│    - Get access token from Redis/Config │
│    - Inject Authorization header        │
│    - Header: "Bearer <access_token>"    │
└─────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────┐
│ 3. keycloak-introspection Plugin        │
│    - Read Authorization header          │
│    - Introspect token dengan Keycloak   │
│    - Validate token active status       │
│    - Check authorized clients           │
│    - Check client roles                 │
└─────────────────────────────────────────┘
    ↓
    ├─ Token Valid ─────→ Forward to Upstream
    │
    └─ Token Invalid/Expired (401)
           ↓
    ┌─────────────────────────────────────────┐
    │ 4. token-manager-v2 (Response)          │
    │    - Detect 401 status                  │
    │    - Call refresh endpoint              │
    │    - Get new access token               │
    │    - Store in Redis                     │
    │    - Return 401 to client               │
    └─────────────────────────────────────────┘
           ↓
    Client Retry Request (with same API key)
           ↓
    Gunakan NEW TOKEN dari Redis → SUCCESS ✅
```

## 🎯 Kenapa Kompatibel?

### 1. **Priority yang Tepat**
- `token-manager-v2` (802) berjalan SEBELUM `keycloak-introspection` (1200)
- Token di-inject dulu, baru kemudian di-introspect
- Tidak ada konflik eksekusi

### 2. **Header Authorization**
- `token-manager-v2` SET header: `Authorization: Bearer <token>`
- `keycloak-introspection` READ header: `Authorization`
- Keduanya menggunakan standard header yang sama

### 3. **Response Handling**
- `keycloak-introspection` return 401 jika token invalid
- `token-manager-v2` detect 401 dan auto-refresh token
- Client retry dengan token baru

### 4. **Redis Storage**
- Token disimpan per-service (dengan prefix)
- Tidak ada konflik antar service
- Token persisten across requests

## 📋 Konfigurasi Lengkap

### Step 1: Setup Token Manager V2

```bash
curl -X POST http://kong-admin:8001/services/your-service/plugins \
  --data "name=token-manager-v2" \
  --data "config.access_token=initial_keycloak_token" \
  --data "config.refresh_endpoint=https://keycloak.example.com/realms/your-realm/protocol/openid-connect/token" \
  --data "config.refresh_method=POST" \
  --data "config.refresh_body=grant_type=password&client_id=your-client&client_secret=your-secret&username=service-account&password=service-password" \
  --data "config.content_type=application/x-www-form-urlencoded" \
  --data "config.header_key=Authorization" \
  --data "config.header_value=Bearer \$access_token" \
  --data "config.ssl_verify=false"
```

### Step 2: Setup Keycloak Introspection

```bash
curl -X POST http://kong-admin:8001/services/your-service/plugins \
  --data "name=keycloak-introspection" \
  --data "config.introspection_url=https://keycloak.example.com/realms/your-realm/protocol/openid-connect/token/introspect" \
  --data "config.client_id=your-introspect-client" \
  --data "config.client_secret=your-introspect-secret" \
  --data "config.authorized_clients[]=client-app-1" \
  --data "config.authorized_clients[]=client-app-2" \
  --data "config.authorized_client_roles[]=client-app-1:admin" \
  --data "config.authorized_client_roles[]=client-app-1:user"
```

### Step 3: (Optional) Setup Key Auth

```bash
curl -X POST http://kong-admin:8001/services/your-service/plugins \
  --data "name=key-auth" \
  --data "config.key_names=apikey"
```

## 🔐 Use Cases

### Use Case 1: Service-to-Service dengan Keycloak

**Scenario:** Microservice perlu akses ke API lain dengan Keycloak token

**Setup:**
- Service Account di Keycloak untuk mendapat token
- Token Manager V2 auto-refresh token
- Keycloak Introspection validate token sebelum forward ke upstream

**Config:**
```bash
# Token Manager V2 - Get token via client credentials
config.refresh_endpoint=https://keycloak/realms/myrealm/protocol/openid-connect/token
config.refresh_body=grant_type=client_credentials&client_id=service-a&client_secret=secret123
config.content_type=application/x-www-form-urlencoded

# Keycloak Introspection - Validate token
config.introspection_url=https://keycloak/realms/myrealm/protocol/openid-connect/token/introspect
config.client_id=introspection-client
config.authorized_clients[]=service-a
```

### Use Case 2: API Gateway dengan User Authentication

**Scenario:** User login via Keycloak, token di-validate setiap request

**Setup:**
- User dapat token dari Keycloak login
- Kong validate token via introspection
- Token auto-refresh jika expired

**Config:**
```bash
# Token Manager V2 - Refresh user token
config.refresh_endpoint=https://keycloak/realms/myrealm/protocol/openid-connect/token
config.refresh_body=grant_type=refresh_token&client_id=mobile-app&refresh_token=$refresh_token
config.access_token=<user_initial_token>
config.refresh_token=<user_refresh_token>

# Keycloak Introspection - Validate user token
config.introspection_url=https://keycloak/realms/myrealm/protocol/openid-connect/token/introspect
config.authorized_clients[]=mobile-app
config.authorized_client_roles[]=mobile-app:user
```

### Use Case 3: Procurement Service (Your Case)

**Scenario:** Procurement service perlu akses dengan username/password via query param

**Setup:**
```bash
# Token Manager V2
curl -X POST http://kong-admin:8001/services/procurement-service/plugins \
  --data "name=token-manager-v2" \
  --data "config.access_token=initial_token" \
  --data "config.refresh_endpoint=http://auth-service/login?username=procurement&password=secret123" \
  --data "config.refresh_method=POST" \
  --data "config.content_type=application/json" \
  --data "config.header_key=Authorization" \
  --data "config.header_value=Bearer \$access_token"

# Keycloak Introspection
curl -X POST http://kong-admin:8001/services/procurement-service/plugins \
  --data "name=keycloak-introspection" \
  --data "config.introspection_url=https://keycloak/realms/procurement/protocol/openid-connect/token/introspect" \
  --data "config.client_id=procurement-client" \
  --data "config.client_secret=client-secret" \
  --data "config.authorized_clients[]=procurement-app"
```

## 🔍 Monitoring & Debugging

### Check Both Plugins Working

```bash
# Check token injection (token-manager-v2)
docker logs kong-gateway 2>&1 | grep "\[Access Phase\].*✅"

# Check introspection (keycloak-introspection)
docker logs kong-gateway 2>&1 | grep "Token introspection successful"

# Check token refresh when expired
docker logs kong-gateway 2>&1 | grep "\[Refresh Token\].*✅"
```

### Debug Flow

```bash
# See complete flow
docker logs kong-gateway -f 2>&1 | grep -E "\[Access Phase\]|Token introspection|keycloak-introspection"
```

### Expected Log Pattern

**Successful Request:**
```
[Access Phase] ========== Starting Access Phase ==========
[Access Phase] Service: procurement-service
[Get Token] Successfully retrieved token from Redis
[Access Phase] ✅ Access phase complete - Token injected
keycloak-introspection: Token introspection successful
```

**Token Expired & Refresh:**
```
[Access Phase] Using access token from Redis
keycloak-introspection: Access token is not active
[Response Phase] ⚠️  Detected 401 Unauthorized - Token may be expired
[Refresh Token] ========== Starting Token Refresh Process ==========
[Refresh Token] ✅ Successfully received new tokens
[Store Token] Successfully stored token in Redis
```

**Client Retry with New Token:**
```
[Access Phase] Using access token from Redis  <-- NEW TOKEN
keycloak-introspection: Token introspection successful  <-- ✅
```

## ⚠️ Penting!

### 1. **Priority HARUS Benar**
Pastikan token-manager-v2 priority (802) LEBIH KECIL dari keycloak-introspection (1200)

### 2. **Same Authorization Header**
Keduanya menggunakan header `Authorization`, jangan ubah `config.header_key`

### 3. **Client Harus Retry**
Plugin tidak auto-retry, client harus implement retry logic saat terima 401

### 4. **Keycloak Response Format**
Token refresh endpoint HARUS return JSON dengan field `access_token`:
```json
{
  "access_token": "eyJhbGciOiJSUzI1NiIs...",
  "expires_in": 300,
  "refresh_expires_in": 1800,
  "refresh_token": "eyJhbGciOiJIUzI1NiIs...",
  "token_type": "Bearer"
}
```

### 5. **Introspection Client Credentials**
Client credentials untuk introspection BERBEDA dengan credentials untuk get token

## 🚀 Benefits Kombinasi Ini

✅ **Auto Token Refresh** - Tidak perlu manual refresh
✅ **Token Validation** - Setiap request di-validate dengan Keycloak
✅ **Centralized Token Management** - Token tersimpan di Redis
✅ **Service Isolation** - Token per-service dengan prefix
✅ **Role-Based Access Control** - Validate client roles via Keycloak
✅ **Audit Trail** - Detailed logging untuk compliance
✅ **Zero Downtime** - Token refresh transparent ke client (dengan retry)

## 🧪 Testing

### Test 1: Normal Flow
```bash
# Request dengan API key
curl -X GET http://kong:8000/api/procurement/orders \
  -H "apikey: your-api-key"

# Check logs
docker logs kong-gateway --since 10s 2>&1 | grep -E "\[Access Phase\]|introspection successful"
```

### Test 2: Token Expired
```bash
# Clear token untuk force refresh
curl -X GET http://kong:8000/api/procurement/orders \
  -H "apikey: your-api-key" \
  -H "Clear-Redis-Token: clear"

# Retry (will use new token)
curl -X GET http://kong:8000/api/procurement/orders \
  -H "apikey: your-api-key"
```

### Test 3: Unauthorized Client
```bash
# Use token from unauthorized client
# Should get 401 from keycloak-introspection

docker logs kong-gateway 2>&1 | grep "not from an authorized client"
```

## 📚 References

- [Keycloak Token Endpoint](https://www.keycloak.org/docs/latest/securing_apps/#_token-exchange)
- [Keycloak Introspection Endpoint](https://www.keycloak.org/docs/latest/securing_apps/#_token_introspection_endpoint)
- [OAuth 2.0 Token Introspection](https://tools.ietf.org/html/rfc7662)

## 💡 Tips

1. **Use Service Accounts** untuk service-to-service communication
2. **Set proper token expiry** di Keycloak untuk balance security vs performance
3. **Monitor Redis memory** untuk token storage
4. **Enable debug logs** saat development untuk troubleshooting
5. **Implement proper retry logic** di client application

## 🎯 Conclusion

**Token Manager V2** dan **Keycloak Introspection** adalah kombinasi yang POWERFUL dan PRODUCTION-READY untuk:
- Automatic token lifecycle management
- Token validation dan authorization
- Service-to-service authentication
- User authentication dengan Keycloak

Keduanya bekerja bersama dengan sempurna! 🚀
