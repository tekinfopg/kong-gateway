# Kong Gateway with Docker Compose

# Configuration Parameters

You can override the following environment variables in your setup:

- **KONG_DATABASE**
  - *Description:* Determines which database backend Kong will use.
  - *Default:* `off`

- **KONG_PG_DATABASE**
  - *Description:* The PostgreSQL database name for Kong.
  - *Default:* `kong`

- **KONG_PG_HOST**
  - *Description:* Hostname of the PostgreSQL server.
  - *Default:* `db`

- **KONG_PG_USER**
  - *Description:* PostgreSQL username for Kong.
  - *Default:* `kong`

- **KONG_PG_PASSWORD_FILE**
  - *Description:* Path to a file that contains the PostgreSQL password.
  - *Default:* `/run/secrets/kong_postgres_password`

Other parameters used in the Kong service configuration include:

- **KONG_PROXY_LISTEN**
  - *Description:* IP and port that Kong listens on for proxy traffic.
  - *Default:* `0.0.0.0:8000`

- **KONG_ADMIN_LISTEN**
  - *Description:* IP and port that Kong listens on for admin API traffic.
  - *Default:* `0.0.0.0:8001`

- **KONG_ADMIN_GUI_LISTEN**
  - *Description:* IP and port that Kong listens on for admin GUI traffic.
  - *Default:* `0.0.0.0:8002`

- **KONG_ADMIN_ACCESS_LOG** and **KONG_ADMIN_ERROR_LOG**
  - *Description:* Log paths for the admin API.
  - *Default:* `/dev/stdout` and `/dev/stderr`, respectively.

- **KONG_PROXY_ACCESS_LOG** and **KONG_PROXY_ERROR_LOG**
  - *Description:* Log paths for proxy traffic.
  - *Default:* `/dev/stdout` and `/dev/stderr`, respectively.

- **KONG_PREFIX**
  - *Description:* Kong's working directory.
  - *Default:* `/var/run/kong`

- **KONG_DECLARATIVE_CONFIG**
  - *Description:* Path to Kong's declarative configuration file.
  - *Default:* `/opt/kong/kong.yaml`

Feel free to adjust these parameters to suit your environment.
