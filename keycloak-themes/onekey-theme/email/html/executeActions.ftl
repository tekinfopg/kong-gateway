<#import "template.ftl" as layout>
<@layout.emailLayout>
    <p style="margin:0 0 16px 0;">Halo,</p>

    <p style="margin:0 0 8px 0;">Administrator Anda baru saja meminta Anda untuk memperbarui akun ${realmName} Anda. Klik tombol di bawah untuk memulai proses ini.</p>

    <@layout.button href=link label=msg("onekeyButtonUpdateAccount")/>

    <p style="margin:0 0 16px 0; color:#64748b; font-size:14px;">Tautan ini akan kedaluwarsa dalam ${linkExpirationFormatter(linkExpiration)}.</p>

    <p style="margin:0 0 8px 0; color:#64748b; font-size:14px;">${msg("onekeyLinkFallback")}</p>
    <p style="margin:0 0 16px 0; word-break:break-all; font-size:13px;"><a href="${link}" target="_blank" style="color:#2e8b57;">${link}</a></p>

    <p style="margin:0; color:#64748b; font-size:14px;">Jika Anda tidak mengetahui bahwa administrator Anda meminta ini, abaikan pesan ini dan tidak ada yang akan diubah.</p>
</@layout.emailLayout>
