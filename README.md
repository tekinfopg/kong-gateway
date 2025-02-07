# Kong Gateway Docker Compose Setup

This repository provides a Docker Compose configuration for running Kong Gateway along with its migrations. The configuration is defined in the [docker-compose.yml](docker-compose.yml) file.

## Configuration

The Compose file uses a YAML anchor (`x-kong-config: &kong-env`) to define a common set of environment variables for Kong. You can override these variables as needed.

### Environment Variables

- **KONG_DATABASE**  
  - _Usage_: Sets the type of database to use by Kong.  
  - _Default_: `postgres`  
  - _Example_: `export KONG_DATABASE=postgres`

- **KONG_PG_DATABASE**  
  - _Usage_: The name of the PostgreSQL database Kong will connect to.  
  - _Default_: `kong`  
  - _Example_: `export KONG_PG_DATABASE=kong`

- **KONG_PG_HOST**  
  - _Usage_: The hostname or IP address of your external PostgreSQL server.  
  - _Default_: `your-external-db-host`  
  - _Example_: `export KONG_PG_HOST=192.168.1.100`

- **KONG_PG_USER**  
  - _Usage_: The PostgreSQL username for connecting to the database.  
  - _Default_: `kong`  
  - _Example_: `export KONG_PG_USER=kong`

- **KONG_PG_PASSWORD**  
  - _Usage_: The PostgreSQL password for the user.  
  - _Default_: `your-db-password`  
  - _Example_: `export KONG_PG_PASSWORD=secretpass`

### Kong Service Specific Variables

Additional settings for the Kong container include:

- **KONG_ADMIN_ACCESS_LOG** and **KONG_ADMIN_ERROR_LOG**  
  - _Usage_: Paths for the admin access and error logs.  
  - _Default_: `/dev/stdout` and `/dev/stderr`, respectively.

- **KONG_PROXY_LISTEN**  
  - _Usage_: Address (IP and port) for Kong to listen on for proxy traffic.  
  - _Default_: `0.0.0.0:8000`

- **KONG_ADMIN_LISTEN**  
  - _Usage_: Address for Kong to listen on for the Admin API.  
  - _Default_: `0.0.0.0:8001`

- **KONG_ADMIN_GUI_LISTEN**  
  - _Usage_: Address for Kong to listen on for the Admin GUI.  
  - _Default_: `0.0.0.0:8002`

- **KONG_PROXY_ACCESS_LOG** and **KONG_PROXY_ERROR_LOG**  
  - _Usage_: Paths for the proxy access and error logs.  
  - _Default_: `/dev/stdout` and `/dev/stderr`

- **KONG_PREFIX**  
  - _Usage_: Kong's working directory.  
  - _Default_: `/var/run/kong`

- **KONG_DECLARATIVE_CONFIG**  
  - _Usage_: Location of the declarative configuration file for Kong.  
  - _Default_: `/opt/kong/kong.yaml`

## Services

The Compose file defines three primary services:

- **kong-migrations**  
  Runs the command `kong migrations bootstrap` to initialize the database schema.  
  It uses the shared environment from the YAML anchor (`*kong-env`) and connects to the network `kong-net`.

- **kong-migrations-up**  
  Runs `kong migrations up && kong migrations finish` to apply further database migrations if needed.

- **kong**  
  Runs the Kong Gateway container. It also applies several additional environment variables and port mappings:
  - **Ports:**  
    - Proxy: `${KONG_INBOUND_PROXY_LISTEN:-0.0.0.0}:8000`  
    - SSL Proxy: `${KONG_INBOUND_SSL_PROXY_LISTEN:-0.0.0.0}:8443`  
    - Admin API: `8001`  
    - Extra Admin API: `8444`  
    - Admin GUI: `8002`
  - **Health Check:** Uses `kong health` command with a 10-second interval, timeout, and 10 retries.
  - **Volumes:** Mounts for persisting Kong's prefix and temporary files, as well as loading configuration files from the local `./config` directory.

## Using an External Database

To use an external PostgreSQL database instead of an internal one, update the environment variables before starting Docker Compose:

```sh
export KONG_PG_HOST=your.external.db.host
export KONG_PG_PASSWORD=your-db-password