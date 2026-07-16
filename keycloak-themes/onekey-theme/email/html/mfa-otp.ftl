<#import "template.ftl" as layout>
<@layout.emailLayout>
    <p style="margin:0 0 16px 0;">Hai ${username},</p>

    <p style="margin:0 0 8px 0;">Kode autentikasi Anda untuk ${realmName} adalah:</p>

    <@layout.codeBox code=code/>

    <p style="margin:0 0 16px 0;">Kode ini akan kedaluwarsa dalam 5 menit.</p>

    <p style="margin:0; color:#64748b; font-size:14px;">Demi keamanan, mohon untuk tidak membagikan kode ini dengan siapapun. Jika Anda tidak meminta kode ini, silakan abaikan email ini atau hubungi dukungan.</p>
</@layout.emailLayout>
