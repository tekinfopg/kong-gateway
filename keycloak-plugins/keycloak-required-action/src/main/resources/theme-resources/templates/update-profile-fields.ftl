<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global'); section>
    <#if section = "header">
        ${msg("updateProfileTitle","Lengkapi Profil Anda")}
    <#elseif section = "form">
        <form id="kc-update-profile-fields-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">

            <#if showEmail>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="email" class="${properties.kcLabelClass!}">${msg("email","Email")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="email"
                               id="email"
                               name="email"
                               class="${properties.kcInputClass!}"
                               value="${(currentEmail!'')}"
                               autocomplete="email"
                               autofocus
                               required/>
                        <#if messagesPerField.existsError('email')>
                            <span id="input-error-email" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('email'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </div>
            </#if>

            <#if showPhone>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="phoneNumber" class="${properties.kcLabelClass!}">${msg("phoneNumber","Phone Number")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="tel"
                               id="phoneNumber"
                               name="phoneNumber"
                               class="${properties.kcInputClass!}"
                               value="${(currentPhone!'')}"
                               placeholder="+628xxxxxxxxxx"
                               autocomplete="tel"
                               required/>
                        <#if messagesPerField.existsError('phoneNumber')>
                            <span id="input-error-phone" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('phoneNumber'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </div>
            </#if>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                           type="submit"
                           value="${msg('doSubmit','Simpan')}"/>
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
