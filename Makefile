kong-postgres:
	COMPOSE_PROFILES=database KONG_DATABASE=postgres KONG_PG_HOST=host.docker.internal KONG_PG_USER=postgres docker compose up -d

kong-dbless:
	docker compose up -d

clean:
	docker compose kill
	docker compose rm -f