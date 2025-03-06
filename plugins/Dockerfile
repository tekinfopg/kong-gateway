FROM kong:3.9.0
LABEL maintainer="edoaurahman@gmail.com"
LABEL description="Kong API Gateway with Keycloak Introspection and Token Manager Plugin"
LABEL version="1.0"

USER root
RUN luarocks install lua-resty-redis
USER kong
WORKDIR /usr/local/share/lua/5.1/kong/plugins
COPY ./keycloak-introspection ./keycloak-introspection
COPY ./token-manager ./token-manager
COPY ./kong.conf /etc/kong/kong.conf