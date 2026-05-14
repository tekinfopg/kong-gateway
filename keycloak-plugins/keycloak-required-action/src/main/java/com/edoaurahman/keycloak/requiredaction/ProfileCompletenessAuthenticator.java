package com.edoaurahman.keycloak.requiredaction;

import org.jboss.logging.Logger;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.Authenticator;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;

public class ProfileCompletenessAuthenticator implements Authenticator {

    private static final Logger log = Logger.getLogger(ProfileCompletenessAuthenticator.class);

    static final String PHONE_ATTRIBUTE = "phoneNumber";
    static final String REQUIRED_ACTION_ID = "update-profile-fields";

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        UserModel user = context.getUser();
        if (user == null) {
            context.success();
            return;
        }

        boolean emailEmpty = isBlank(user.getEmail());
        boolean phoneEmpty = isBlank(user.getFirstAttribute(PHONE_ATTRIBUTE));

        if (emailEmpty || phoneEmpty) {
            log.debugf("User %s missing profile fields (emailEmpty=%s, phoneEmpty=%s) — adding required action %s",
                    user.getUsername(), emailEmpty, phoneEmpty, REQUIRED_ACTION_ID);
            user.addRequiredAction(REQUIRED_ACTION_ID);
        }

        context.success();
    }

    @Override
    public void action(AuthenticationFlowContext context) {
        context.success();
    }

    @Override
    public boolean requiresUser() {
        return true;
    }

    @Override
    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }

    @Override
    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
    }

    @Override
    public void close() {
    }

    private static boolean isBlank(String s) {
        return s == null || s.isBlank();
    }
}
