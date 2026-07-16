<#import "template.ftl" as layout>
<@layout.emailLayout>
    <#if firstName?? && lastName??>
        <p style="margin:0 0 16px 0;">Halo, ${firstName} ${lastName},</p>
    <#else>
        <p style="margin:0 0 16px 0;">Halo,</p>
    </#if>

    <p style="margin:0 0 8px 0;">Anda diundang untuk bergabung dengan organisasi <strong>${organization.name}</strong>. Klik tombol di bawah untuk bergabung.</p>

    <@layout.button href=link label=msg("onekeyButtonJoinOrg")/>

    <p style="margin:0 0 16px 0; color:#64748b; font-size:14px;">Tautan ini akan kedaluwarsa dalam ${linkExpirationFormatter(linkExpiration)}.</p>

    <p style="margin:0 0 8px 0; color:#64748b; font-size:14px;">${msg("onekeyLinkFallback")}</p>
    <p style="margin:0 0 16px 0; word-break:break-all; font-size:13px;"><a href="${link}" target="_blank" style="color:#2e8b57;">${link}</a></p>

    <p style="margin:0; color:#64748b; font-size:14px;">Jika Anda tidak ingin bergabung dengan organisasi, abaikan pesan ini.</p>
</@layout.emailLayout>
