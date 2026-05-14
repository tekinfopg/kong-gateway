package com.edoaurahman.keycloak.requiredaction;

import org.keycloak.Config;
import org.keycloak.authentication.RequiredActionFactory;
import org.keycloak.authentication.RequiredActionProvider;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;

public class UpdateProfileFieldsRequiredActionFactory implements RequiredActionFactory {

    private static final UpdateProfileFieldsRequiredAction SINGLETON = new UpdateProfileFieldsRequiredAction();

    @Override
    public String getId() {
        return UpdateProfileFieldsRequiredAction.PROVIDER_ID;
    }

    @Override
    public String getDisplayText() {
        return "Update Email & Phone Number";
    }

    @Override
    public RequiredActionProvider create(KeycloakSession session) {
        return SINGLETON;
    }

    @Override
    public void init(Config.Scope config) {
    }

    @Override
    public void postInit(KeycloakSessionFactory factory) {
    }

    @Override
    public void close() {
    }
}
