# ✅ Kongloak Deployment Checklist

Quick checklist untuk deploy Kongloak dengan CI/CD.

## 📋 Pre-Deployment Checklist

### ☑️ GitHub Setup

- [ ] Repository sudah di-fork/clone
- [ ] Branch strategy sudah ada (main/develop/staging)
- [ ] GitHub Actions enabled di repository
- [ ] Workflow file ada di `.github/workflows/docker-build-push.yml`

### ☑️ GitHub Personal Access Token

- [ ] Token sudah dibuat di https://github.com/settings/tokens
- [ ] Scope `read:packages` dan `write:packages` sudah dicentang
- [ ] Token sudah disimpan dengan aman (dimulai dengan `ghp_...`)

### ☑️ Server Setup

- [ ] Docker Engine 20.10+ terinstall
- [ ] Docker Compose 2.0+ terinstall
- [ ] Port tersedia: 8000, 8443, 8001, 8444, 8080, 8002, 6379
- [ ] Network `proxy` sudah ada: `docker network create proxy`

### ☑️ Files Ready

- [ ] `.env` file sudah dibuat dari `.env.example`
- [ ] `deploy/Dockerfile.kong` exists
- [ ] `deploy/Dockerfile.keycloak` exists
- [ ] `plugins/token-manager-v2/` ready
- [ ] `plugins/keycloak-introspection/` ready

## 🔧 Configuration Checklist

### ☑️ .env File Configuration

```bash
# Copy example
cp .env.example .env
```

**Required values:**

```bash
# Database
KONG_PG_PASSWORD=✅ (must set)
KC_DB_PASSWORD=✅ (must set)

# Keycloak Admin
KEYCLOAK_ADMIN=✅ (must set)
KEYCLOAK_ADMIN_PASSWORD=✅ (must set)

# GHCR Credentials
GHCR_USERNAME=✅ (your GitHub username)
GHCR_TOKEN=✅ (ghp_xxx token)

# Redis (optional)
# REDIS_PASSWORD=your-redis-password

# Watchtower
WATCHTOWER_POLL_INTERVAL=60
```

Cek dengan command:
```bash
# Verify required values are set
grep -E "KONG_PG_PASSWORD|KC_DB_PASSWORD|KEYCLOAK_ADMIN|GHCR_" .env
```

- [ ] All passwords set
- [ ] GHCR credentials configured
- [ ] No syntax errors in .env

### ☑️ docker-compose.yml Verification

```bash
# Validate docker-compose.yml
docker-compose config

# Should show no errors
```

- [ ] Validation passed
- [ ] All services defined
- [ ] Watchtower service present
- [ ] Labels correct on kong & keycloak services

## 🚀 Deployment Steps

### Step 1: Initial Commit & CI Build

```bash
# 1. Check current branch
git branch

# 2. Stage all files
git add .github/workflows/ deploy/ plugins/token-manager-v2/ docker-compose.yml .env.example README.md

# 3. Commit
git commit -m "feat: add CI/CD pipeline with Watchtower for Kongloak"

# 4. Push to trigger build
git push origin feature/client-roll-base-auth  # or your branch
```

**Wait for build to complete:**
- [ ] GitHub Actions workflow triggered
- [ ] Go to: https://github.com/tekinfopg/kong-gateway/actions
- [ ] Build status: ✅ Success
- [ ] Images pushed to GHCR

**Verify images:**
```bash
docker pull ghcr.io/tekinfopg/kong-gateway/kong:latest
docker pull ghcr.io/tekinfopg/kong-gateway/keycloak:latest
```

- [ ] Kong image pulled successfully
- [ ] Keycloak image pulled successfully

### Step 2: Create Network

```bash
# Create proxy network
docker network create proxy

# Verify
docker network ls | grep proxy
```

- [ ] Network `proxy` exists

### Step 3: Start Services

```bash
# Start all services
docker-compose up -d

# Check status
docker-compose ps
```

**Expected output:**
```
NAME                    STATUS
konga                   Up (healthy)
kong-db                 Up (healthy)
kong-gateway            Up (healthy)
kongloak-watchtower     Up
keycloak                Up (healthy)
keycloak-db             Up (healthy)
redis                   Up (healthy)
```

- [ ] All containers running
- [ ] All healthchecks passing (wait ~2 minutes)

### Step 4: Verify Services

#### Kong Admin API
```bash
curl -i http://localhost:8001/
# Should return: HTTP/1.1 200 OK
```

- [ ] Kong Admin API accessible

#### Kong Proxy
```bash
curl -i http://localhost:8000/
# Should return: HTTP/1.1 404 Not Found (normal, no routes yet)
```

- [ ] Kong Proxy accessible

#### Keycloak Admin
```bash
# Open in browser:
# http://localhost:8080
# Login with KEYCLOAK_ADMIN and KEYCLOAK_ADMIN_PASSWORD
```

- [ ] Keycloak admin console accessible
- [ ] Login successful

#### Konga Dashboard
```bash
# Open in browser:
# http://localhost:8002
```

- [ ] Konga accessible
- [ ] Can connect to Kong Admin API (http://kong-gateway:8001)

### Step 5: Check Plugin Loading

```bash
# List enabled plugins
docker exec kong-gateway kong plugin list

# Should include:
# - token-manager-v2
# - keycloak-introspection
```

- [ ] `token-manager-v2` loaded
- [ ] `keycloak-introspection` loaded

### Step 6: Verify Watchtower

```bash
# Check Watchtower logs
docker logs kongloak-watchtower --tail 50

# Should show:
# - "Using scope: kongloak"
# - "Checking containers for updates"
```

- [ ] Watchtower running
- [ ] Checking GHCR for updates
- [ ] No authentication errors

## 🔄 Test Auto-Deployment

### Test Update Flow

```bash
# 1. Make a small change
echo "# Test auto-deploy" >> README.md

# 2. Commit and push
git add README.md
git commit -m "test: trigger auto-deployment"
git push origin main  # or your branch

# 3. Wait for GitHub Actions (~5-10 min)
# Check: https://github.com/tekinfopg/kong-gateway/actions

# 4. Watch Watchtower detect update (~1-2 min after build)
docker logs -f kongloak-watchtower

# Expected logs:
# - "Found new kong-gateway:latest image"
# - "Stopping /kong-gateway"
# - "Starting /kong-gateway"
# - "Session done"
```

- [ ] Build completed on GitHub
- [ ] Watchtower detected new image
- [ ] Container updated automatically
- [ ] Services still healthy after update

### Rollback Test (If Update Fails)

```bash
# Stop Watchtower
docker stop kongloak-watchtower

# Manually revert to previous image
docker-compose pull  # pulls old version if available
docker-compose up -d

# Or specify exact version
docker tag ghcr.io/tekinfopg/kong-gateway/kong:main-abc123 ghcr.io/tekinfopg/kong-gateway/kong:latest
docker-compose up -d

# Restart Watchtower
docker start kongloak-watchtower
```

- [ ] Can rollback if needed
- [ ] Services recovered

## 📊 Post-Deployment Verification

### Health Checks

```bash
# All services healthy
docker-compose ps

# Check logs for errors
docker-compose logs --tail 100 | grep -i error
```

- [ ] No critical errors in logs
- [ ] All containers running

### Plugin Testing

Create test service and route:

```bash
# Create test service
curl -i -X POST http://localhost:8001/services \
  --data "name=test-service" \
  --data "url=http://httpbin.org"

# Create route
curl -i -X POST http://localhost:8001/services/test-service/routes \
  --data "paths[]=/test"

# Test route
curl -i http://localhost:8000/test
# Should proxy to httpbin.org
```

- [ ] Can create services
- [ ] Can create routes
- [ ] Proxy working

### Token Manager V2 Testing

```bash
# Enable plugin on test route
curl -i -X POST http://localhost:8001/routes/{route-id}/plugins \
  --data "name=token-manager-v2" \
  --data "config.access_token=test-token" \
  --data "config.refresh_endpoint=http://keycloak:8080/realms/master/protocol/openid-connect/token"

# Test request (should inject token)
curl -i http://localhost:8000/test -H "X-Debug: true"
```

- [ ] Plugin enabled successfully
- [ ] Token injection working

### Keycloak Integration Testing

See `KEYCLOAK_INTEGRATION.md` for full setup.

- [ ] Client created in Keycloak
- [ ] Token introspection working
- [ ] Full OAuth2 flow tested

## 🐛 Troubleshooting

### Issue: Build Fails on GitHub Actions

**Check:**
```bash
# Test local build
docker build -f deploy/Dockerfile.kong -t test-kong .
docker build -f deploy/Dockerfile.keycloak -t test-keycloak .
```

**Common fixes:**
- Check Dockerfile syntax
- Verify plugin files exist
- Check build context

### Issue: Watchtower Not Pulling

**Check credentials:**
```bash
# Test GHCR login
echo $GHCR_TOKEN | docker login ghcr.io -u $GHCR_USERNAME --password-stdin

# Should see: Login Succeeded
```

**Check labels:**
```bash
docker inspect kong-gateway | jq '.[0].Config.Labels'
```

### Issue: Container Won't Start

**Check logs:**
```bash
docker logs kong-gateway --tail 100
docker logs keycloak --tail 100
```

**Common issues:**
- Database not ready (wait for healthcheck)
- Port conflict (change ports in docker-compose.yml)
- Plugin error (check plugin syntax)

### Issue: Plugin Not Loading

**Verify installation:**
```bash
# Check plugin files in container
docker exec kong-gateway ls -la /usr/local/share/lua/5.1/kong/plugins/token-manager-v2/

# Check Kong configuration
docker exec kong-gateway kong config db_export /dev/stdout | grep plugin
```

## 📝 Maintenance Checklist

### Daily

- [ ] Check Watchtower logs for updates
- [ ] Monitor container health
- [ ] Check disk space

### Weekly

- [ ] Review GitHub Actions logs
- [ ] Clean old Docker images: `docker image prune -a`
- [ ] Check Kong error logs

### Monthly

- [ ] Rotate GHCR token
- [ ] Update base images (kong, keycloak)
- [ ] Review and update dependencies
- [ ] Backup Kong configuration
- [ ] Backup Keycloak realm

## 🎉 Success Criteria

**Deployment is successful when:**

- ✅ All containers running and healthy
- ✅ Kong Admin API accessible (8001)
- ✅ Kong Proxy accessible (8000)
- ✅ Keycloak admin accessible (8080)
- ✅ Konga accessible (8002)
- ✅ Plugins loaded (token-manager-v2, keycloak-introspection)
- ✅ Watchtower monitoring GHCR
- ✅ Auto-deployment tested and working
- ✅ No critical errors in logs

**Time to deployment:**
- Initial: ~30 minutes (including build)
- Updates: ~7-13 minutes (automated)

---

## 🆘 Need Help?

1. **Check documentation:**
   - `README.md` - Overview
   - `deploy/CI-CD-GUIDE.md` - Detailed CI/CD setup
   - `plugins/token-manager-v2/DEBUGGING.md` - Plugin debugging

2. **Check logs:**
   ```bash
   docker-compose logs -f
   ```

3. **GitHub Issues:**
   https://github.com/tekinfopg/kong-gateway/issues

4. **Community:**
   - Kong Discussions: https://discuss.konghq.com
   - Keycloak Discussions: https://github.com/keycloak/keycloak/discussions

---

**🦍🔐 Kongloak** - Kong Gateway + Keycloak Integration
