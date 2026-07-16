<#import "template.ftl" as layout>
<@layout.emailLayout>
    <p style="margin:0 0 16px 0;">Halo,</p>

    <p style="margin:0 0 8px 0;">Seseorang telah membuat akun ${realmName} dengan alamat email ini. Jika ini adalah Anda, klik tombol di bawah untuk memverifikasi alamat email Anda.</p>

    <@layout.button href=link label=msg("onekeyButtonVerifyEmail")/>

    <p style="margin:0 0 16px 0; color:#64748b; font-size:14px;">Tautan ini akan kedaluwarsa dalam ${linkExpirationFormatter(linkExpiration)}.</p>

    <p style="margin:0 0 8px 0; color:#64748b; font-size:14px;">${msg("onekeyLinkFallback")}</p>
    <p style="margin:0 0 16px 0; word-break:break-all; font-size:13px;"><a href="${link}" target="_blank" style="color:#2e8b57;">${link}</a></p>

    <p style="margin:0; color:#64748b; font-size:14px;">Jika Anda tidak membuat akun ini, abaikan pesan ini.</p>
</@layout.emailLayout>
