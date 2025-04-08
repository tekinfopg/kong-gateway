<#import "./template.ftl" as layout>
<@layout.emailLayout>
    <div>
        <p>Hai ${username},</p>
        
        <p>Silakan verifikasi alamat email Anda untuk ${realmName} dengan memasukkan kode verifikasi ini:</p>
        
        <div style="background-color: #f5f5f5; padding: 20px; margin: 20px 0; text-align: center; border-radius: 4px;">
            <span style="font-size: 24px; font-weight: bold; letter-spacing: 3px;">${code}</span>
        </div>
        
        <p>Kode ini akan kedaluwarsa dalam 5 menit.</p>
        
        <p>Jika Anda tidak meminta verifikasi ini, silakan abaikan email ini atau hubungi dukungan.</p>
    </div>
</@layout.emailLayout>