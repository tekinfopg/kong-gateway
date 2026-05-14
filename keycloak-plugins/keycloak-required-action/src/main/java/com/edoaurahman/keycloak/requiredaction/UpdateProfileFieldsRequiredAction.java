package com.edoaurahman.keycloak.requiredaction;

import jakarta.ws.rs.core.MultivaluedMap;
import jakarta.ws.rs.core.Response;
import org.jboss.logging.Logger;
import org.keycloak.authentication.RequiredActionContext;
import org.keycloak.authentication.RequiredActionProvider;
import org.keycloak.models.UserModel;
import org.keycloak.models.utils.FormMessage;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class UpdateProfileFieldsRequiredAction implements RequiredActionProvider {

    private static final Logger log = Logger.getLogger(UpdateProfileFieldsRequiredAction.class);

    static final String PROVIDER_ID = "update-profile-fields";
    static final String PHONE_ATTRIBUTE = "phoneNumber";
    static final String FORM_TEMPLATE = "update-profile-fields.ftl";

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[+\\d][\\d\\s\\-]*$");

    @Override
    public void evaluateTriggers(RequiredActionContext context) {
    }

    @Override
    public void requiredActionChallenge(RequiredActionContext context) {
        UserModel user = context.getUser();
        boolean showEmail = isBlank(user.getEmail());
        boolean showPhone = isBlank(user.getFirstAttribute(PHONE_ATTRIBUTE));

        if (!showEmail && !showPhone) {
            user.removeRequiredAction(PROVIDER_ID);
            context.success();
            return;
        }

        Response challenge = context.form()
                .setAttribute("showEmail", showEmail)
                .setAttribute("showPhone", showPhone)
                .setAttribute("currentEmail", nullToEmpty(user.getEmail()))
                .setAttribute("currentPhone", nullToEmpty(user.getFirstAttribute(PHONE_ATTRIBUTE)))
                .createForm(FORM_TEMPLATE);
        context.challenge(challenge);
    }

    @Override
    public void processAction(RequiredActionContext context) {
        MultivaluedMap<String, String> form = context.getHttpRequest().getDecodedFormParameters();
        UserModel user = context.getUser();
        List<FormMessage> errors = new ArrayList<>();

        boolean emailMissing = isBlank(user.getEmail());
        boolean phoneMissing = isBlank(user.getFirstAttribute(PHONE_ATTRIBUTE));

        String submittedEmail = null;
        String submittedPhone = null;

        if (emailMissing) {
            submittedEmail = trim(form.getFirst("email"));
            if (isBlank(submittedEmail) || !EMAIL_PATTERN.matcher(submittedEmail).matches()) {
                errors.add(new FormMessage("email", "invalidEmailMessage"));
            }
        }
        if (phoneMissing) {
            submittedPhone = trim(form.getFirst("phoneNumber"));
            if (isBlank(submittedPhone) || !PHONE_PATTERN.matcher(submittedPhone).matches()) {
                errors.add(new FormMessage("phoneNumber", "invalidPhoneMessage"));
            }
        }

        if (!errors.isEmpty()) {
            Response challenge = context.form()
                    .setErrors(errors)
                    .setAttribute("showEmail", emailMissing)
                    .setAttribute("showPhone", phoneMissing)
                    .setAttribute("currentEmail", nullToEmpty(emailMissing ? submittedEmail : user.getEmail()))
                    .setAttribute("currentPhone", nullToEmpty(phoneMissing ? submittedPhone : user.getFirstAttribute(PHONE_ATTRIBUTE)))
                    .createForm(FORM_TEMPLATE);
            context.challenge(challenge);
            return;
        }

        if (emailMissing) {
            user.setEmail(submittedEmail);
            log.debugf("Updated email for user %s", user.getUsername());
        }
        if (phoneMissing) {
            user.setSingleAttribute(PHONE_ATTRIBUTE, submittedPhone);
            log.debugf("Updated phoneNumber for user %s", user.getUsername());
        }

        user.removeRequiredAction(PROVIDER_ID);
        context.success();
    }

    @Override
    public void close() {
    }

    private static boolean isBlank(String s) {
        return s == null || s.isBlank();
    }

    private static String nullToEmpty(String s) {
        return s == null ? "" : s;
    }

    private static String trim(String s) {
        return s == null ? null : s.trim();
    }
}
