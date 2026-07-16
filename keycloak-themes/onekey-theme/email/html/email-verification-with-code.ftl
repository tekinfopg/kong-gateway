<#import "template.ftl" as layout>
<@layout.emailLayout>
    <p style="margin:0 0 16px 0;">Halo,</p>

    <p style="margin:0 0 8px 0;">Silakan verifikasi alamat email Anda untuk ${realmName} dengan memasukkan kode berikut:</p>

    <@layout.codeBox code=code/>

    <p style="margin:0; color:#64748b; font-size:14px;">Demi keamanan, mohon untuk tidak membagikan kode ini dengan siapapun. Jika Anda tidak meminta verifikasi ini, silakan abaikan email ini.</p>
</@layout.emailLayout>
