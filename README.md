# Kong Gateway Docker Compose

This repository contains a Docker Compose configuration to run Kong Gateway along with database migrations. Kong can be set up to use either an internal PostgreSQL service (managed by Docker Compose) or an external database.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setup

1. **Copy the Environment File**  
   Create a local copy of the example environment file and update the values as needed:

   ```bash
   cp .env.example .env
   ```

2. **Launch the Services**  
   Start the services with Docker Compose:

   ```bash
   docker-compose up -d
   ```

3. **View Logs**  
   To review logs for the Kong service, run:

   ```bash
   docker-compose logs -f kong
   ```

## Environment Variables

The .env.example file includes many variables that determine the behavior of your Kong Gateway setup. You can override these variables by updating your local .env file.

| Variable                     | Description                                           | Default Value               |
| ---------------------------- | ----------------------------------------------------- | --------------------------- |
| `KONG_PG_HOST`               | Hostname or IP address of the PostgreSQL server.      | `host.docker.internal`      |
| `KONG_PG_USER`               | PostgreSQL username for connecting to the database.   | `root`                      |
| `KONG_DATABASE`              | The type of database used by Kong.                    | `postgres`                  |
| `KONG_PG_PASSWORD`           | Password for the PostgreSQL user.                    | `1234`                      |
| `KONG_PG_DATABASE`           | Name of the PostgreSQL database for Kong.            | `kong`                      |
| `KONG_DOCKER_TAG`            | Docker image tag for Kong.                           | `kong:latest`               |
| `KONG_USER`                  | User used to run the Kong container.                 | `kong`                      |
| `KONG_PROXY_LISTEN`          | Port for proxy traffic.                              | `8000`                      |
| `KONG_ADMIN_LISTEN`          | Port for the Admin API.                              | `8001`                      |
| `KONG_ADMIN_GUI_LISTEN`      | Port for the Admin GUI.                              | `8002`                      |
| `KONG_SSL_PROXY_LISTEN`      | Port for SSL proxy traffic.                          | `8443`                      |
| `KONG_SSL_ADMIN_LISTEN`      | Port for SSL Admin API traffic.                      | `8444`                      |
| `KONG_SSL_ADMIN_GUI_LISTEN`  | Port for SSL Admin GUI traffic.                      | `8445`                      |
| `KONG_PREFIX`                | Kong's working directory inside the container.       | `/var/run/kong`             |
| `KONG_CERT_DIR`              | Directory containing SSL certificates.             | certs                   |
| `CERT_FILE`                  | Path to the SSL certificate file.                  | cert.pem          |
| `CERT_KEY_FILE`              | Path to the SSL certificate key file.              | key.pem           |

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

- **kong-migrations**  
  Initiates the database schema by running `kong migrations bootstrap`.

- **kong-migrations-up**  
  Applies additional migrations by running the commands `kong migrations up && kong migrations finish`.

- **kong**  
  Runs the Kong Gateway container with custom environment variables defined in the `x-kong-config` YAML anchor. It maps ports for proxy traffic, the Admin API, and the Admin GUI, and includes health checks and volume mappings.

## Troubleshooting

- **Environment Variables:**  
  Ensure that variables in your .env file are correctly set.
  
- **Database Connections:**  
  Check the values for `KONG_PG_HOST`, `KONG_PG_USER`, and `KONG_PG_PASSWORD` if the connection to your PostgreSQL database fails.
  
- **Logs:**  
  Use `docker-compose logs -f kong` to monitor error messages and detailed logs.

---

This documentation provides a basic guide for setting up and running Kong Gateway with Docker Compose. Feel free to customize the configuration and documentation as needed for your environment.
``` 

This README explains the setup process, elaborates on environment configuration, and details how to switch between an external and internal database for Kong Gateway.