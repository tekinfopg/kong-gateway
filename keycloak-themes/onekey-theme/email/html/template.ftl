<#macro emailLayout>
<#assign logoUrl = (properties.emailLogoUrl)!"">
<#assign footerLogoUrl = (properties.emailFooterLogoUrl)!"">
<#assign supportUrl = (properties.emailSupportUrl)!"">
<!DOCTYPE html>
<html lang="id" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="color-scheme" content="light">
    <meta name="supported-color-schemes" content="light">
    <title>${realmName!""}</title>
    <!--[if mso]>
    <style type="text/css">
        table, td, div, h1, p { font-family: Arial, sans-serif; }
    </style>
    <![endif]-->
    <style>
        body { margin: 0; padding: 0; width: 100% !important; -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; background-color: #f1f5f9; }
        table { border-collapse: collapse; }
        img { border: 0; line-height: 100%; outline: none; text-decoration: none; -ms-interpolation-mode: bicubic; }
        a { color: #00713A; }
        .ok-btn:hover { background-color: #00713A !important; }
        @media only screen and (max-width: 620px) {
            .ok-card { width: 100% !important; border-radius: 0 !important; }
            .ok-pad { padding-left: 24px !important; padding-right: 24px !important; }
            .ok-code { font-size: 28px !important; letter-spacing: 8px !important; }
        }
    </style>
</head>
<body style="margin:0; padding:0; background-color:#f1f5f9;">
    <div style="display:none; max-height:0; overflow:hidden; opacity:0;">${realmName!""}</div>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#f1f5f9;">
        <tr>
            <td align="center" style="padding:32px 12px;">
                <table role="presentation" class="ok-card" width="600" cellpadding="0" cellspacing="0" style="width:600px; max-width:600px; background-color:#ffffff; border:1px solid #e2e8f0; border-radius:16px; overflow:hidden;">
                    <!-- Header -->
                    <tr>
                        <td style="background-color:#009A44; background-image:linear-gradient(135deg,#00713A 0%,#009A44 100%); padding:26px 40px;">
                            <table role="presentation" cellpadding="0" cellspacing="0">
                                <tr>
                                    <#if logoUrl?has_content>
                                        <td valign="middle" style="background-color:#ffffff; border-radius:8px; padding:9px 14px;">
                                            <img src="${logoUrl}" alt="OneKey" height="24" style="display:block; height:24px; width:auto;">
                                        </td>
                                        <td valign="middle" style="padding-left:16px;">
                                            <div style="font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Arial,sans-serif; font-size:12px; font-weight:600; color:#eafff2; letter-spacing:1.5px; text-transform:uppercase;">Petrokimia Gresik</div>
                                        </td>
                                    <#else>
                                        <td valign="middle">
                                            <span style="display:inline-block; font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Arial,sans-serif; font-size:26px; font-weight:700; color:#ffffff; letter-spacing:0.5px;">One<span style="color:#FFD24D;">Key</span></span>
                                            <div style="font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Arial,sans-serif; font-size:12px; font-weight:600; color:#eafff2; margin-top:4px; letter-spacing:1.5px; text-transform:uppercase;">Petrokimia Gresik</div>
                                        </td>
                                    </#if>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <!-- Accent rule -->
                    <tr><td style="height:4px; background-color:#FFD24D; background-image:linear-gradient(90deg,#009A44 0%,#FFD24D 100%); font-size:0; line-height:0;">&nbsp;</td></tr>
                    <!-- Content -->
                    <tr>
                        <td class="ok-pad" style="padding:36px 40px 30px 40px; font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Arial,sans-serif; font-size:16px; line-height:1.6; color:#334155;">
                            <#nested>
                        </td>
                    </tr>
                    <!-- Footer -->
                    <tr>
                        <td class="ok-pad" style="padding:24px 40px 28px 40px; background-color:#f8fafc; border-top:1px solid #e2e8f0; font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Arial,sans-serif; font-size:13px; line-height:1.6; color:#64748b;">
                            <#if supportUrl?has_content>
                                <p style="margin:0 0 16px 0; color:#334155;">
                                    ${msg("onekeyFooterHelpPrefix")} <a href="${supportUrl}" target="_blank" style="color:#00713A; font-weight:600; text-decoration:none;">${msg("onekeyFooterHelpLabel")}</a>
                                </p>
                            </#if>
                            <table role="presentation" cellpadding="0" cellspacing="0">
                                <tr>
                                    <#if footerLogoUrl?has_content>
                                        <td valign="top" style="padding-right:16px;">
                                            <img src="${footerLogoUrl}" alt="Petrokimia Gresik" height="52" style="display:block; height:52px; width:auto;">
                                        </td>
                                    </#if>
                                    <td valign="middle">
                                        <p style="margin:0 0 2px 0; font-weight:700; color:#0F172A;">${msg("onekeyFooterCompany")}</p>
                                        <p style="margin:0 0 2px 0;">${msg("onekeyFooterAddress")}</p>
                                        <p style="margin:0;"><a href="https://${msg("onekeyFooterWebsite")}" target="_blank" style="color:#00713A; text-decoration:none;">${msg("onekeyFooterWebsite")}</a></p>
                                    </td>
                                </tr>
                            </table>
                            <p style="margin:14px 0 2px 0; font-size:12px; color:#94a3b8;">${msg("onekeyFooterCopyright")}</p>
                            <p style="margin:0; font-size:12px; color:#94a3b8;">${msg("onekeyFooterAutomated")}</p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
</#macro>

<#-- CTA button -->
<#macro button href label>
    <table role="presentation" cellpadding="0" cellspacing="0" style="margin:28px 0;">
        <tr>
            <td align="center" bgcolor="#009A44" style="border-radius:8px;">
                <!--[if mso]>
                <v:roundrect xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="urn:schemas-microsoft-com:office:word" href="${href}" style="height:48px;v-text-anchor:middle;width:280px;" arcsize="17%" strokecolor="#009A44" fillcolor="#009A44">
                <w:anchorlock/>
                <center style="color:#ffffff;font-family:Arial,sans-serif;font-size:16px;font-weight:bold;">${label}</center>
                </v:roundrect>
                <![endif]-->
                <!--[if !mso]><!-- -->
                <a class="ok-btn" href="${href}" target="_blank" style="display:inline-block; padding:14px 36px; font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Arial,sans-serif; font-size:16px; font-weight:600; color:#ffffff; text-decoration:none; background-color:#009A44; border-radius:8px;">${label}</a>
                <!--<![endif]-->
            </td>
        </tr>
    </table>
</#macro>

<#-- Code box -->
<#macro codeBox code>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="margin:24px 0;">
        <tr>
            <td align="center" style="background-color:#f0fdf4; border:1px solid #009A44; border-radius:10px; padding:22px 16px;">
                <span class="ok-code" style="font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Arial,sans-serif; font-size:32px; font-weight:700; letter-spacing:10px; color:#0F172A;">${code}</span>
            </td>
        </tr>
    </table>
</#macro>
