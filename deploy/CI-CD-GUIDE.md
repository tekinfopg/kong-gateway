# 🚀 Kongloak CI/CD Guide

Complete guide for setting up continuous integration and deployment for Kongloak using GitHub Actions and Watchtower.

## 📋 Table of Contents

- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Setup GitHub Actions](#setup-github-actions)
- [Setup Watchtower](#setup-watchtower)
- [Deployment Flow](#deployment-flow)
- [Environment Management](#environment-management)
- [Troubleshooting](#troubleshooting)

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    CI/CD Pipeline                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Developer Push to GitHub                                   │
│       ↓                                                      │
│  ┌────────────────────────────────────────┐                │
│  │  GitHub Actions (CI)                   │                │
│  │  1. Build Kong Image                   │                │
│  │  2. Build Keycloak Image               │                │
│  │  3. Run Tests (optional)               │                │
│  │  4. Push to GHCR                       │                │
│  └────────────────────────────────────────┘                │
│       ↓                                                      │
│  GitHub Container Registry (GHCR)                           │
│       ↓                                                      │
│  ┌────────────────────────────────────────┐                │
│  │  Watchtower (CD)                       │                │
│  │  1. Poll GHCR every X seconds          │                │
│  │  2. Detect new image                   │                │
│  │  3. Pull new image                     │                │
│  │  4. Stop old container                 │                │
│  │  5. Start new container                │                │
│  │  6. Remove old image                   │                │
│  └────────────────────────────────────────┘                │
│       ↓                                                      │
│  Running Containers Updated! ✅                             │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## ✅ Prerequisites

### 1. GitHub Repository Setup

```bash
# Clone repository
git clone https://github.com/tekinfopg/kong-gateway.git
cd kong-gateway

# Create branches
git checkout -b develop
git checkout -b staging
git checkout main
```

### 2. GitHub Personal Access Token

1. Go to: https://github.com/settings/tokens
2. Click **"Generate new token"** → **"Generate new token (classic)"**
3. Name: `Kongloak GHCR Token`
4. Scopes: Select **`read:packages`** and **`write:packages`**
5. Click **"Generate token"**
6. **Copy the token** (starts with `ghp_...`)

### 3. Server Requirements

- Docker Engine 20.10+
- Docker Compose 2.0+
- Internet connection to GHCR

## 🔧 Setup GitHub Actions

### Step 1: Enable GitHub Actions

GitHub Actions is enabled by default. The workflow file is at:
```
.github/workflows/docker-build-push.yml
```

### Step 2: Verify Workflow

1. Go to your repository on GitHub
2. Click **"Actions"** tab
3. You should see **"Build and Push Kongloak Docker Images to GHCR"**

### Step 3: Test Workflow

```bash
# Make a small change
echo "# Test CI/CD" >> README.md

# Commit and push
git add .
git commit -m "test: trigger CI/CD pipeline"
git push origin main
```

### Step 4: Monitor Build

1. Go to **Actions** tab on GitHub
2. Click on the running workflow
3. Watch the build progress
4. Wait for ✅ success status

### Step 5: Verify Images

```bash
# Check images on GHCR
# Go to: https://github.com/orgs/tekinfopg/packages

# Or pull manually
docker pull ghcr.io/tekinfopg/kong-gateway/kong:latest
docker pull ghcr.io/tekinfopg/kong-gateway/keycloak:latest
```

## 🔄 Setup Watchtower

### Step 1: Create .env File

```bash
# Copy example
cp .env.example .env

# Edit .env file
nano .env
```

### Step 2: Configure Watchtower Credentials

Update `.env` with your GitHub credentials:

```bash
# GitHub Container Registry credentials
GHCR_USERNAME=your-github-username
GHCR_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# Polling interval (seconds) - default 60
WATCHTOWER_POLL_INTERVAL=60

# Optional: Notifications
# WATCHTOWER_NOTIFICATIONS=slack
# WATCHTOWER_NOTIFICATION_URL=slack://token-a/token-b/token-c
```

### Step 3: Start Services with Watchtower

```bash
# Start all services including Watchtower
docker-compose up -d

# Verify Watchtower is running
docker ps | grep watchtower

# Check Watchtower logs
docker logs -f kongloak-watchtower
```

### Step 4: Verify Auto-Deployment

Expected log output:
```
time="2025-01-15T10:00:00Z" level=info msg="Watchtower 1.7.1"
time="2025-01-15T10:00:00Z" level=info msg="Using scope: kongloak"
time="2025-01-15T10:00:00Z" level=info msg="Checking containers for updates"
time="2025-01-15T10:00:00Z" level=info msg="Scheduling first run: 2025-01-15 10:01:00"
```

## 🚀 Deployment Flow

### Automatic Deployment (Recommended)

```
1. Developer commits code
   ↓
2. GitHub Actions builds images
   ↓
3. Images pushed to GHCR
   ↓
4. Watchtower detects new image
   ↓
5. Watchtower pulls new image
   ↓
6. Watchtower updates container
   ↓
7. Old container stopped, new one started
   ↓
8. Deployment complete! ✅
```

**Timeline:**
- Build time: ~5-10 minutes
- Watchtower detection: 1-2 minutes (based on poll interval)
- Container update: ~30 seconds
- **Total: ~7-13 minutes from push to production**

### Manual Deployment

```bash
# Pull latest images
docker-compose pull

# Restart services
docker-compose up -d

# Verify
docker-compose ps
```

## 🌍 Environment Management

### Branch Strategy

| Branch | Environment | Image Tag | Auto-Deploy |
|--------|-------------|-----------|-------------|
| `main` | Production | `latest` | ✅ |
| `develop` | Development | `develop` | ✅ |
| `staging` | Staging | `staging` | ✅ |
| `feature/*` | Feature | `feature-*` | ❌ |

### Using Different Environments

#### Production (main)
```bash
# .env
KONG_DOCKER_TAG=ghcr.io/tekinfopg/kong-gateway/kong:latest
KEYCLOAK_DOCKER_TAG=ghcr.io/tekinfopg/kong-gateway/keycloak:latest
```

#### Development (develop)
```bash
# .env
KONG_DOCKER_TAG=ghcr.io/tekinfopg/kong-gateway/kong:develop
KEYCLOAK_DOCKER_TAG=ghcr.io/tekinfopg/kong-gateway/keycloak:develop
```

#### Staging (staging)
```bash
# .env
KONG_DOCKER_TAG=ghcr.io/tekinfopg/kong-gateway/kong:staging
KEYCLOAK_DOCKER_TAG=ghcr.io/tekinfopg/kong-gateway/keycloak:staging
```

## 🔍 Monitoring & Verification

### Check CI/CD Status

```bash
# View Watchtower logs
docker logs kongloak-watchtower --tail 50 -f

# Check container updates
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.RunningFor}}"

# View Kong version
docker exec kong-gateway kong version

# Check Kong plugins loaded
docker exec kong-gateway kong plugin list
```

### Verify Update Success

```bash
# Check image digest
docker inspect kong-gateway | jq '.[0].Image'

# Compare with GHCR
# Should match latest image digest from GitHub Packages
```

## 🐛 Troubleshooting

### Issue 1: Watchtower Not Pulling New Images

**Symptoms:**
```
level=info msg="No new images found"
```

**Solutions:**

1. **Check GHCR credentials:**
```bash
# Test login manually
echo $GHCR_TOKEN | docker login ghcr.io -u $GHCR_USERNAME --password-stdin

# Should see: Login Succeeded
```

2. **Verify image exists:**
```bash
docker pull ghcr.io/tekinfopg/kong-gateway/kong:latest
```

3. **Check Watchtower labels:**
```bash
docker inspect kong-gateway | jq '.[0].Config.Labels'

# Should see:
# "com.centurylinklabs.watchtower.enable": "true"
# "com.centurylinklabs.watchtower.scope": "kongloak"
```

### Issue 2: GitHub Actions Build Fails

**Check build logs:**
1. Go to GitHub → Actions tab
2. Click failed workflow
3. Expand failed step
4. Read error message

**Common causes:**
- Missing Dockerfile
- Invalid plugin files
- Docker build context issues

**Fix:**
```bash
# Test build locally
docker build -f deploy/Dockerfile.kong -t test-kong .
docker build -f deploy/Dockerfile.keycloak -t test-keycloak .
```

### Issue 3: Container Not Updating

**Check:**

1. **Watchtower scope:**
```bash
# Must match container labels
docker logs kongloak-watchtower | grep "scope"
```

2. **Container restart policy:**
```bash
docker inspect kong-gateway | jq '.[0].HostConfig.RestartPolicy'
```

3. **Force update:**
```bash
# Stop Watchtower
docker stop kongloak-watchtower

# Manual update
docker-compose pull
docker-compose up -d

# Restart Watchtower
docker start kongloak-watchtower
```

### Issue 4: Old Images Not Cleaned

**Symptoms:**
Multiple old images consuming disk space

**Solution:**

1. **Enable cleanup:**
```bash
# In .env or docker-compose.yml
WATCHTOWER_CLEANUP=true
```

2. **Manual cleanup:**
```bash
# Remove unused images
docker image prune -a

# Remove specific old images
docker images | grep kong-gateway
docker rmi <image-id>
```

## 📊 Watchtower Configuration

### Environment Variables Reference

| Variable | Description | Default |
|----------|-------------|---------|
| `WATCHTOWER_POLL_INTERVAL` | Check interval (seconds) | `60` |
| `WATCHTOWER_LABEL_ENABLE` | Only watch labeled containers | `true` |
| `WATCHTOWER_CLEANUP` | Remove old images | `true` |
| `WATCHTOWER_SCOPE` | Scope name for filtering | `kongloak` |
| `WATCHTOWER_INCLUDE_RESTARTING` | Update restarting containers | `true` |
| `WATCHTOWER_INCLUDE_STOPPED` | Update stopped containers | `false` |

### Notification Setup

#### Slack Notifications

```bash
# .env
WATCHTOWER_NOTIFICATIONS=slack
WATCHTOWER_NOTIFICATION_URL=slack://token-a/token-b/token-c
```

#### Email Notifications

```bash
# .env
WATCHTOWER_NOTIFICATIONS=email
WATCHTOWER_NOTIFICATION_URL=smtp://user:pass@smtp.gmail.com:587/?from=watchtower@example.com&to=admin@example.com
```

#### Discord Notifications

```bash
# .env
WATCHTOWER_NOTIFICATIONS=discord
WATCHTOWER_NOTIFICATION_URL=discord://token@channel-id
```

## 🔒 Security Best Practices

1. **Use Read-Only Token:**
   - GitHub token should only have `read:packages` scope for Watchtower
   - Use separate token with `write:packages` for CI/CD

2. **Rotate Tokens Regularly:**
```bash
# Update token every 90 days
# 1. Generate new token on GitHub
# 2. Update .env file
# 3. Restart Watchtower
docker-compose restart kongloak-watchtower
```

3. **Restrict Access:**
```bash
# Protect .env file
chmod 600 .env

# Don't commit .env to git
echo ".env" >> .gitignore
```

4. **Use Private Registry:**
   - GHCR images should be private
   - Only accessible with valid token

## 📚 Additional Resources

- **GitHub Actions Docs:** https://docs.github.com/en/actions
- **Watchtower Docs:** https://containrrr.dev/watchtower/
- **GHCR Docs:** https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry
- **Docker Compose:** https://docs.docker.com/compose/

## 💡 Tips & Tricks

### Faster Updates

```bash
# Reduce poll interval for faster updates (not recommended for production)
WATCHTOWER_POLL_INTERVAL=30  # Check every 30 seconds
```

### Scheduled Updates

```bash
# Update only at specific time
# Example: Update every day at 2 AM
WATCHTOWER_SCHEDULE=0 0 2 * * *
```

### Manual Trigger

```bash
# Force check for updates now
docker exec kongloak-watchtower watchtower --run-once
```

### Debug Mode

```bash
# Enable debug logging
WATCHTOWER_DEBUG=true
WATCHTOWER_TRACE=true
```

---

**🦍🔐 Kongloak CI/CD** - Automated deployment made easy!

For issues or questions, visit: https://github.com/tekinfopg/kong-gateway/issues
