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