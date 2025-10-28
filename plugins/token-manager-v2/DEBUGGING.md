# Debugging Guide - Token Manager V2

## 📊 Log Levels & Prefixes

Plugin ini menggunakan prefix yang jelas untuk setiap komponen:

| Prefix | Komponen | Level | Deskripsi |
|--------|----------|-------|-----------|
| `[Redis]` | Redis Operations | debug/err | Koneksi, store, retrieve Redis |
| `[Store Token]` | Token Storage | info/err | Penyimpanan token ke Redis |
| `[Get Token]` | Token Retrieval | debug/info/err | Pengambilan token dari Redis |
| `[Clear Tokens]` | Token Clearing | info/err | Penghapusan token |
| `[Substitute]` | Token Substitution | debug/info/warn | Penggantian placeholder |
| `[Refresh Token]` | Token Refresh | info/debug/err | Proses refresh token |
| `[Access Phase]` | Access Handler | info/debug/err | Request phase |
| `[Response Phase]` | Response Handler | info/debug/warn/err | Response phase |

## 🔍 Cara Melihat Logs

### 1. Real-time Logs (Semua)
```bash
docker logs kong-gateway -f
```

### 2. Filter Plugin V2 Saja
```bash
docker logs kong-gateway -f 2>&1 | grep "token-manager-v2\|TokenManagerV2"
```

### 3. Filter per Komponen

#### Hanya Redis Operations
```bash
docker logs kong-gateway 2>&1 | grep "\[Redis\]"
```

#### Hanya Token Refresh
```bash
docker logs kong-gateway 2>&1 | grep "\[Refresh Token\]"
```

#### Hanya Access Phase
```bash
docker logs kong-gateway 2>&1 | grep "\[Access Phase\]"
```

#### Hanya Response Phase
```bash
docker logs kong-gateway 2>&1 | grep "\[Response Phase\]"
```

#### Hanya Errors
```bash
docker logs kong-gateway 2>&1 | grep "FAILED\|❌\|ERROR"
```

#### Hanya Success
```bash
docker logs kong-gateway 2>&1 | grep "✅\|Successfully"
```

### 4. Filter per Service
```bash
docker logs kong-gateway 2>&1 | grep "Service: procurement-service"
```

## 📝 Log Format Examples

### Normal Flow (Success)
```
[Access Phase] ========== Starting Access Phase ==========
[Access Phase] Service: procurement-service
[Get Token] Attempting to retrieve key: procurement-service:access_token
[Redis] Attempting to connect to kong-redis:6379
[Redis] Successfully connected to kong-redis:6379
[Get Token] Successfully retrieved token from Redis - Key: procurement-service:access_token - Length: 856 chars
[Access Phase] Using access token from Redis
[Access Phase] Setting header: Authorization
[Substitute] Input type: string - Placeholder: $access_token
[Substitute] Substituted '$access_token' in string (1 replacements)
[Access Phase] ✅ Access phase complete - Token injected
[Access Phase] ========================================
```

### Token Refresh Flow
```
[Response Phase] ========== Starting Response Phase ==========
[Response Phase] Upstream response status: 401
[Response Phase] ⚠️  Detected 401 Unauthorized - Token may be expired
[Response Phase] Attempting to refresh token...
[Refresh Token] ========== Starting Token Refresh Process ==========
[Refresh Token] Use stored token: true
[Refresh Token] Refresh endpoint: http://auth-service/login?username=user&password=pass
[Refresh Token] No refresh_body provided - using query params or empty body
[Refresh Token] Making HTTP request to: http://auth-service/login?username=user&password=pass
[Refresh Token] Received response - Status: 200
[Refresh Token] Parsing JSON response
[Refresh Token] ✅ Successfully received new tokens
[Refresh Token] New access token length: 864 chars
[Store Token] Storing token with key: procurement-service:access_token
[Redis] Attempting to connect to kong-redis:6379
[Redis] Successfully connected to kong-redis:6379
[Store Token] Successfully stored token in Redis - Key: procurement-service:access_token
[Refresh Token] ========== Token Refresh Complete ==========
[Response Phase] ✅ Token refreshed successfully
[Response Phase] New token stored in Redis
[Response Phase] Client should retry the request with new token
```

### Error Scenarios

#### Redis Connection Failed
```
[Get Token] FAILED to connect to Redis
[Redis] FAILED to connect to kong-redis:6379 - Error: connection refused
```

#### Refresh Endpoint Failed
```
[Refresh Token] FAILED to make refresh request - Error: connection timeout
[Clear Tokens] Starting token clearing process
[Clear Tokens] All tokens cleared successfully
```

#### Invalid Response Format
```
[Refresh Token] FAILED to decode JSON response - Error: Expected value but found invalid token
[Refresh Token] Response body was: <html>Error 500</html>
```

#### Missing Access Token in Response
```
[Refresh Token] FAILED - No 'access_token' field found in response
[Refresh Token] Available fields in response: token, expires_in, user_id
```

## 🐛 Common Issues & Solutions

### Issue 1: Token tidak tersimpan di Redis

**Gejala:**
```
[Access Phase] Using access token from config (no token in Redis)
```

**Debugging:**
1. Cek koneksi Redis:
```bash
docker exec kong-gateway redis-cli -h kong-redis ping
```

2. Cek logs Redis connection:
```bash
docker logs kong-gateway 2>&1 | grep "\[Redis\].*FAILED"
```

3. Cek stored keys:
```bash
docker exec kong-redis redis-cli keys "*"
```

**Solusi:**
- Pastikan Redis container running
- Cek REDIS_HOST dan REDIS_PORT env vars
- Cek network connectivity

---

### Issue 2: Token refresh gagal

**Gejala:**
```
[Refresh Token] FAILED - Unexpected status code: 401
```

**Debugging:**
1. Cek endpoint bisa diakses:
```bash
docker exec kong-gateway curl -v http://auth-service/login?username=user&password=pass
```

2. Cek response format:
```bash
docker logs kong-gateway 2>&1 | grep "\[Refresh Token\] Response body"
```

3. Verifikasi credentials:
```bash
docker logs kong-gateway 2>&1 | grep "\[Refresh Token\] Refresh endpoint:"
```

**Solusi:**
- Pastikan refresh_endpoint accessible dari Kong
- Verifikasi format response (harus JSON dengan field `access_token`)
- Cek credentials di query params atau body

---

### Issue 3: Infinite loop atau terlalu banyak requests

**Gejala:**
```
[Access Phase] ========== Starting Access Phase ==========
[Access Phase] ========== Starting Access Phase ==========
[Access Phase] ========== Starting Access Phase ==========
```

**Debugging:**
```bash
docker logs kong-gateway 2>&1 | grep "\[Access Phase\]" | wc -l
```

**Solusi:**
- V2 sudah menghilangkan infinite loop, pastikan menggunakan `token-manager-v2`
- Jika masih terjadi, cek apakah ada plugin lain yang conflict

---

### Issue 4: Client tidak retry setelah 401

**Gejala:**
Token sudah di-refresh tapi client langsung terima 401

**Debugging:**
```bash
docker logs kong-gateway 2>&1 | grep "\[Response Phase\] ✅ Token refreshed"
```

**Solusi:**
- Plugin V2 **tidak** auto-retry, client harus implement retry logic
- Pastikan client retry request saat terima 401
- Token baru sudah tersimpan di Redis untuk request berikutnya

---

## 🔧 Enable Debug Logging

Untuk mendapat detail maksimal, enable debug logs di Kong:

### Via Environment Variable
```yaml
# docker-compose.yml
environment:
  - KONG_LOG_LEVEL=debug
```

### Via kong.conf
```
log_level = debug
```

### Reload Kong
```bash
docker exec kong-gateway kong reload
```

## 📊 Performance Monitoring

### Count Successful Token Refreshes
```bash
docker logs kong-gateway 2>&1 | grep "\[Refresh Token\] ✅" | wc -l
```

### Count Failed Refreshes
```bash
docker logs kong-gateway 2>&1 | grep "\[Refresh Token\] FAILED" | wc -l
```

### Average Token Length
```bash
docker logs kong-gateway 2>&1 | grep "Token value length:" | awk '{print $7}' | awk '{sum+=$1; count++} END {print sum/count}'
```

### Check Redis Keys per Service
```bash
docker exec kong-redis redis-cli --scan --pattern "*:access_token"
```

## 🎯 Testing Checklist

- [ ] Token injection di access phase berhasil
- [ ] Token dari Redis digunakan jika ada
- [ ] Token dari config digunakan jika Redis kosong
- [ ] 401 response trigger token refresh
- [ ] Token baru tersimpan di Redis
- [ ] Client retry berhasil dengan token baru
- [ ] Manual token clearing works (`Clear-Redis-Token: clear`)
- [ ] Multiple services menggunakan service prefix yang berbeda
- [ ] Error logs jelas menunjukkan letak masalah

## 📞 Support

Jika masih ada masalah setelah mengikuti guide ini:

1. Export full logs:
```bash
docker logs kong-gateway > kong-debug.log 2>&1
```

2. Filter logs untuk request tertentu (gunakan request ID jika ada)

3. Share logs dengan informasi:
   - Service name
   - Request endpoint
   - Expected behavior vs actual behavior
   - Plugin configuration yang digunakan
