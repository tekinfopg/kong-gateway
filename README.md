# 🦍🔐 Kongloak - Kong Gateway + Keycloak Integration

**Kongloak** is a production-ready API Gateway platform that combines **Kong Gateway** for API management with **Keycloak** for enterprise identity and access management.

This repository provides a complete Docker Compose setup with pre-configured integration, custom plugins, and zero-downtime deployment capabilities.

## ✨ Features

- 🦍 **Kong Gateway** - API Gateway for routing, rate limiting, and traffic control
- 🔐 **Keycloak** - Enterprise SSO and identity management
- 🔄 **Token Manager V2** - Automatic token refresh with Redis storage
- 🔍 **Keycloak Introspection** - OAuth2 token validation
- 🚀 **Zero Downtime Deployment** - Hot reload support
- 📊 **Konga Dashboard** - Web UI for Kong administration
- 💾 **Redis Integration** - Token caching and storage
- 🐘 **PostgreSQL** - Production database support
- 🔒 **SSL/TLS Ready** - HTTPS support out of the box

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         Kongloak                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Client Request                                             │
│       ↓                                                     │
│  ┌──────────────────────────────────────────────┐          │
│  │  Kong Gateway (API Gateway)                  │          │
│  │  - Routing & Load Balancing                  │          │
│  │  - Rate Limiting                             │          │
│  │  - Authentication                            │          │
│  │  - Custom Plugins                            │          │
│  └──────────────────────────────────────────────┘          │
│       ↓                                                     │
│  ┌──────────────────────────────────────────────┐          │
│  │  Token Manager V2 Plugin                     │          │
│  │  - Auto Token Injection                      │          │
│  │  - Auto Token Refresh                        │          │
│  │  - Redis-backed Storage                      │          │
│  └──────────────────────────────────────────────┘          │
│       ↓                                                     │
│  ┌──────────────────────────────────────────────┐          │
│  │  Keycloak Introspection Plugin               │          │
│  │  - Token Validation                          │          │
│  │  - Role-based Access Control                 │          │
│  │  - Client Authorization                      │          │
│  └──────────────────────────────────────────────┘          │
│       ↓                                                     │
│  ┌──────────────────────────────────────────────┐          │
│  │  Keycloak (Identity Provider)                │          │
│  │  - User Management                           │          │
│  │  - SSO                                       │          │
│  │  - OAuth2 / OpenID Connect                   │          │
│  └──────────────────────────────────────────────┘          │
│       ↓                                                     │
│  Upstream Services                                          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setup

### 1. **Clone Repository**
   ```bash
   git clone https://github.com/tekinfopg/kong-gateway.git
   cd kong-gateway
   git checkout feature/client-roll-base-auth
   ```

### 2. **Copy the Environment File**  
   Create a local copy of the example environment file and update the values as needed:

   ```bash
   cp .env.example .env
   ```

### 3. **Configure Environment Variables**
   Edit `.env` file and update required values (see Environment Variables section below)

### 4. **Run Database Migrations**
   Initialize Kong database schema:

   ```bash
   docker-compose --profile migration up
   ```

### 5. **Launch the Services**  
   Start all services with Docker Compose:

   ```bash
   docker-compose up -d
   ```

### 6. **Verify Services**
   Check if all services are running:

   ```bash
   docker-compose ps
   ```

   Expected output:
   ```
   NAME            STATUS    PORTS
   kong            healthy   8000, 8443, 8001, 8444
   keycloak        running   8080, 8443
   kong-redis      running   6379
   konga           running   1337
   ```

### 7. **View Logs**  
   To review logs for the Kong service, run:

   ```bash
   docker-compose logs -f kong
   ```

## Environment Variables

The `.env.example` file includes many variables that determine the behavior of your Kongloak setup. You can override these variables by updating your local `.env` file.

### Kong Configuration

| Variable                    | Description                                         | Default Value          |
| --------------------------- | --------------------------------------------------- | ---------------------- |
| `KONG_DOCKER_TAG`           | Docker image tag for Kong.                          | `kong:latest`          |
| `KONG_USER`                 | User used to run the Kong container.                | `kong`                 |
| `KONG_DATABASE`             | The type of database used by Kong.                  | `postgres`             |
| `KONG_PG_HOST`              | Hostname or IP address of the PostgreSQL server.    | `host.docker.internal` |
| `KONG_PG_USER`              | PostgreSQL username for connecting to the database. | `root`                 |
| `KONG_PG_PASSWORD`          | Password for the PostgreSQL user.                   | `1234`                 |
| `KONG_PG_DATABASE`          | Name of the PostgreSQL database for Kong.           | `kong`                 |
| `KONG_PROXY_LISTEN`         | Port for proxy traffic.                             | `8000`                 |
| `KONG_ADMIN_LISTEN`         | Port for the Admin API.                             | `8001`                 |
| `KONG_SSL_PROXY_LISTEN`     | Port for SSL proxy traffic.                         | `8443`                 |
| `KONG_SSL_ADMIN_LISTEN`     | Port for SSL Admin API traffic.                     | `8444`                 |
| `KONG_PREFIX`               | Kong's working directory inside the container.      | `/var/run/kong`        |
| `KONG_CERT_DIR`             | Directory containing SSL certificates.              | `./certs`              |
| `CERT_FILE`                 | Path to the SSL certificate file.                   | `null`                 |
| `CERT_KEY_FILE`             | Path to the SSL certificate key file.               | `null`                 |

### Keycloak Configuration

| Variable                       | Description                                      | Default Value        |
| ------------------------------ | ------------------------------------------------ | -------------------- |
| `KC_HOSTNAME`                  | Public hostname for Keycloak                     | Required             |
| `KC_HTTP_PORT`                 | HTTP port for Keycloak                           | `8080`               |
| `KC_HTTPS_PORT`                | HTTPS port for Keycloak                          | `8443`               |
| `KC_HTTP_ENABLED`              | Enable HTTP (set false for production)           | `false`              |
| `KEYCLOAK_ADMIN`               | Keycloak admin username                          | `admin`              |
| `KEYCLOAK_ADMIN_PASSWORD`      | Keycloak admin password                          | `admin`              |
| `KC_DB`                        | Database type                                    | `postgres`           |
| `KC_DB_URL`                    | JDBC connection URL                              | Required             |
| `KC_DB_USERNAME`               | Database username                                | Required             |
| `KC_DB_PASSWORD`               | Database password                                | Required             |
| `KC_PROXY`                     | Proxy mode (edge, reencrypt, passthrough)        | `edge`               |
| `KC_PROVIDER_DIR`              | Directory for custom Keycloak providers          | `./keycloak-providers` |
| `KC_THEMES_DIR`                | Directory for custom themes                      | `./keycloak-themes`  |

### Redis Configuration

| Variable                    | Description                                         | Default Value          |
| --------------------------- | --------------------------------------------------- | ---------------------- |
| `REDIS_HOST`                | Redis hostname                                      | `kong-redis`           |
| `REDIS_PORT`                | Redis port                                          | `6379`                 |
| `REDIS_TIMEOUT`             | Redis connection timeout (ms)                       | `1000`                 |

### Konga Configuration

| Variable                    | Description                                         | Default Value          |
| --------------------------- | --------------------------------------------------- | ---------------------- |
| `KONGA_LISTEN`              | Port for the Admin GUI konga                        | `1337`                 |

## Using an External Database

If you prefer to connect Kong to an external PostgreSQL database, update the following values in your .env file:

```bash
KONG_PG_HOST=your.external.db.host
KONG_PG_USER=your_username
KONG_PG_PASSWORD=your_password
KONG_PG_DATABASE=your_database
```

After updating the .env file, run the services again:

```bash
docker-compose up -d
```

If you are running an external database exclusively, consider removing or commenting out the internal database service in your docker-compose.yml.

## Services Overview

The Docker Compose configuration defines the following main services:

### Core Services

- **kong**  
  Kong Gateway container with custom plugins (token-manager-v2, keycloak-introspection).
  - Proxy: `8000` (HTTP), `8443` (HTTPS)
  - Admin API: `8001` (HTTP), `8444` (HTTPS)
  - Health check enabled
  - Hot reload support

- **keycloak**  
  Keycloak identity and access management server.
  - HTTP: `8080`
  - HTTPS: `8443`
  - Custom themes and providers support
  - PostgreSQL backend

- **kong-redis**  
  Redis cache for token storage and session management.
  - Port: `6379`
  - Alpine-based lightweight image
  - Persistent storage

- **konga**  
  Web-based GUI for Kong administration.
  - Port: `1337`
  - Visual service and route management
  - Plugin configuration UI

### Migration Services (Profile: migration)

- **kong-migrations**  
  Initiates the database schema by running `kong migrations bootstrap`.

- **kong-migrations-up**  
  Applies additional migrations by running `kong migrations up`.

## 🔌 Custom Plugins

### Token Manager V2

Automatic token management with Redis storage.

**Features:**
- Auto token injection in requests
- Auto refresh on 401 (token expired)
- Support query parameter authentication
- Support JSON and form-urlencoded
- Redis-backed token storage per service

**Documentation:** [plugins/token-manager-v2/README.md](plugins/token-manager-v2/README.md)

**Quick Setup:**
```bash
curl -X POST http://localhost:8001/services/YOUR-SERVICE/plugins \
  --data "name=token-manager-v2" \
  --data "config.access_token=initial_token" \
  --data "config.refresh_endpoint=http://auth/refresh" \
  --data "config.refresh_method=POST"
```

### Keycloak Introspection

OAuth2 token validation with Keycloak.

**Features:**
- Token introspection with Keycloak server
- Validate token active status
- Check authorized clients
- Role-based access control (RBAC)

**Documentation:** [plugins/keycloak-introspection/README.md](plugins/keycloak-introspection/README.md)

**Quick Setup:**
```bash
curl -X POST http://localhost:8001/services/YOUR-SERVICE/plugins \
  --data "name=keycloak-introspection" \
  --data "config.introspection_url=https://keycloak/realms/myrealm/protocol/openid-connect/token/introspect" \
  --data "config.client_id=introspection-client" \
  --data "config.client_secret=secret"
```

## 🚀 Deployment

### Zero Downtime Plugin Updates

```bash
# 1. Copy plugin to running container
docker cp plugins/token-manager-v2 kong:/usr/local/share/lua/5.1/kong/plugins/

# 2. Hot reload (NO DOWNTIME!)
docker exec kong kong reload

# 3. Verify
docker logs kong | grep "token-manager-v2"
```

### Production Deployment

```bash
# Build custom image with plugins
docker build -t yourusername/kongloak:latest .

# Update docker-compose.yml
# Change: image: "${KONG_DOCKER_TAG:-kong:latest}"
# To: image: "yourusername/kongloak:latest"

# Deploy
docker-compose up -d
```

## 🔗 Integration Example

### Kong + Keycloak Flow

```bash
# 1. Setup service
curl -X POST http://localhost:8001/services \
  --data "name=my-api" \
  --data "url=http://upstream-api:8080"

# 2. Setup route
curl -X POST http://localhost:8001/services/my-api/routes \
  --data "paths[]=/api"

# 3. Add token manager
curl -X POST http://localhost:8001/services/my-api/plugins \
  --data "name=token-manager-v2" \
  --data "config.access_token=initial" \
  --data "config.refresh_endpoint=https://keycloak/realms/myrealm/protocol/openid-connect/token" \
  --data "config.refresh_body=grant_type=client_credentials&client_id=app&client_secret=secret" \
  --data "config.content_type=application/x-www-form-urlencoded"

# 4. Add keycloak introspection
curl -X POST http://localhost:8001/services/my-api/plugins \
  --data "name=keycloak-introspection" \
  --data "config.introspection_url=https://keycloak/realms/myrealm/protocol/openid-connect/token/introspect" \
  --data "config.client_id=introspection-client" \
  --data "config.client_secret=introspection-secret"

# 5. Test
curl http://localhost:8000/api/endpoint
```

## 📊 Monitoring & Debugging

### Check Service Status

```bash
# All services
docker-compose ps

# Kong health
curl http://localhost:8001/status

# Keycloak health
curl http://localhost:8080/health
```

### View Logs

```bash
# Real-time Kong logs
docker logs -f kong

# Filter plugin logs
docker logs kong 2>&1 | grep "\[Access Phase\]\|\[Refresh Token\]"

# View errors only
docker logs kong 2>&1 | grep "FAILED\|ERROR"

# Keycloak logs
docker logs -f keycloak

# Redis logs
docker logs -f kong-redis
```

### Redis Monitoring

```bash
# Connect to Redis
docker exec -it kong-redis redis-cli

# Check stored tokens
keys "*"

# Get specific token
get "my-service:access_token"

# Monitor commands
MONITOR
```

## Troubleshooting

### Common Issues

#### 1. Kong fails to start
```bash
# Check database connection
docker logs kong | grep "database"

# Verify migrations ran
docker-compose --profile migration up

# Check configuration
docker exec kong kong config parse /etc/kong/kong.conf
```

#### 2. Token Manager not working
```bash
# Verify Redis connection
docker exec kong redis-cli -h kong-redis ping
# Should return: PONG

# Check plugin loaded
curl http://localhost:8001 | jq '.plugins.available_on_server."token-manager-v2"'

# View plugin logs
docker logs kong 2>&1 | grep "\[Access Phase\]\|\[Refresh Token\]"
```

#### 3. Keycloak Introspection fails
```bash
# Test introspection endpoint
docker exec kong curl -v https://keycloak/realms/myrealm/protocol/openid-connect/token/introspect

# Check plugin configuration
curl http://localhost:8001/plugins | jq '.data[] | select(.name=="keycloak-introspection")'

# View introspection logs
docker logs kong 2>&1 | grep "keycloak-introspection"
```

#### 4. Database connection issues
```bash
# Check PostgreSQL connection
docker exec kong kong health

# Test database directly
docker exec kong psql -h $KONG_PG_HOST -U $KONG_PG_USER -d $KONG_PG_DATABASE -c "SELECT version();"
```

#### 5. SSL/TLS certificate issues
```bash
# Verify certificate files exist
ls -la certs/

# Check certificate validity
openssl x509 -in certs/cert.pem -text -noout

# Test HTTPS endpoint
curl -k https://localhost:8443
```

### Debug Mode

Enable debug logging for detailed troubleshooting:

```bash
# Update docker-compose.yml or .env
KONG_LOG_LEVEL=debug

# Reload Kong
docker exec kong kong reload

# View debug logs
docker logs -f kong
```

### Performance Issues

```bash
# Check resource usage
docker stats kong keycloak kong-redis

# Monitor Kong metrics
curl http://localhost:8001/metrics

# Check Redis memory
docker exec kong-redis redis-cli INFO memory
```

## 🔒 Security Best Practices

1. **Change Default Passwords**
   ```bash
   # Update .env file
   KEYCLOAK_ADMIN_PASSWORD=strong_random_password
   KONG_PG_PASSWORD=another_strong_password
   ```

2. **Enable HTTPS Only**
   ```bash
   # Set in .env
   KC_HTTP_ENABLED=false
   KC_HOSTNAME_STRICT_HTTPS=true
   ```

3. **Restrict Admin API Access**
   ```bash
   # In docker-compose.yml, comment out admin ports
   # - 8001:8001
   # - 8444:8444
   ```

4. **Use SSL Certificates**
   ```bash
   # Generate or obtain certificates
   ./certs/generate-certs.sh
   
   # Update .env
   CERT_FILE=/certs/cert.pem
   CERT_KEY_FILE=/certs/key.pem
   ```

5. **Enable Redis Password**
   ```bash
   # Add to redis service in docker-compose.yml
   command: redis-server --requirepass your_redis_password
   
   # Update plugin config
   REDIS_PASSWORD=your_redis_password
   ```

## 📚 Documentation

### Core Documentation
- **Kong Gateway:** [docs.konghq.com](https://docs.konghq.com/)
- **Keycloak:** [www.keycloak.org/documentation](https://www.keycloak.org/documentation)

### Plugin Documentation
- **Token Manager V2:** [plugins/token-manager-v2/README.md](plugins/token-manager-v2/README.md)
- **Keycloak Integration:** [plugins/token-manager-v2/KEYCLOAK_INTEGRATION.md](plugins/token-manager-v2/KEYCLOAK_INTEGRATION.md)
- **Debugging Guide:** [plugins/token-manager-v2/DEBUGGING.md](plugins/token-manager-v2/DEBUGGING.md)

### Deployment & CI/CD
- **🚀 CI/CD Guide:** [deploy/CI-CD-GUIDE.md](deploy/CI-CD-GUIDE.md) - Complete GitHub Actions + Watchtower setup
- **✅ Deployment Checklist:** [deploy/DEPLOYMENT-CHECKLIST.md](deploy/DEPLOYMENT-CHECKLIST.md) - Step-by-step deployment guide

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 💬 Support

- **Issues:** [GitHub Issues](https://github.com/tekinfopg/kong-gateway/issues)
- **Discussions:** [GitHub Discussions](https://github.com/tekinfopg/kong-gateway/discussions)

### Maintainers
- **Edo Aurahman** - edoaurahman@gmail.com
- **Muhammad Irfan** - muhammadirfannh36@gmail.com

## 🌟 Acknowledgments

- Kong Inc. for the amazing API Gateway
- Keycloak team for the excellent identity management solution
- Community contributors

---

**🦍🔐 Kongloak** - Where Kong Meets Keycloak

Made with ❤️ by [tekinfopg](https://github.com/tekinfopg)
