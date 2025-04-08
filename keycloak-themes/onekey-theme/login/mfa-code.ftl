<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('code'); section>
    <#if section = "header">
        ${msg("Masukkan Kode Verifikasi")}
    <#elseif section = "form">
        <div class="text-center mb-6">
            <div class="flex justify-center mb-3">
                <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 15 15" class="text-secondary dark:text-accent">
                    <path fill="none" stroke="currentColor" d="M6 5.5h3m-1.5 0V10m3 0V7.5m0 0v-2h1a1 1 0 1 1 0 2zm-6-1v2a1 1 0 0 1-2 0v-2a1 1 0 0 1 2 0Zm-3-6h12a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1h-12a1 1 0 0 1-1-1v-12a1 1 0 0 1 1-1Z" stroke-width="1"/>
                </svg>
            </div>
            <h2 class="text-2xl font-bold text-gray-800 dark:text-white mb-2">Verifikasi Diperlukan</h2>
            <#if method?? && method == "totp">
                <p class="text-gray-600 dark:text-gray-300">Masukkan kode dari aplikasi autentikator Anda</p>
            <#elseif method?? && method == "whatsapp">
                <p class="text-gray-600 dark:text-gray-300">Masukkan kode yang kami kirim ke ponsel Anda</p>
            <#elseif method?? && method == "telegram">
                <p class="text-gray-600 dark:text-gray-300">Masukkan kode yang kami kirim ke Telegram Anda</p>
            <#elseif method?? && method == "email">
                <p class="text-gray-600 dark:text-gray-300">Masukkan kode yang kami kirim ke email Anda</p>
            <#else>
                <p class="text-gray-600 dark:text-gray-300">Masukkan kode yang kami kirimkan</p>
            </#if>
        </div>
        
        <form id="kc-otp-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <div class="mb-6">
                <div class="relative">
                    <div class="flex items-center">
                        <input id="code" name="code" type="text" 
                            autocomplete="one-time-code"
                            inputmode="numeric" 
                            pattern="[0-9]*" 
                            minlength="6" 
                            maxlength="6"
                            class="w-full px-4 py-3 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-800 dark:text-white text-center text-lg tracking-widest font-mono focus:outline-none focus:ring-2 focus:ring-secondary dark:focus:ring-accent transition-all input-focus-effect"
                            autofocus required/>
                    </div>
                    <p class="text-xs text-gray-500 dark:text-gray-400 text-center mt-2">Kode 6 digit</p>
                </div>
                
                <#if method?? && method == "totp">
                    <div class="mt-4 p-4 bg-gray-100 dark:bg-gray-800 rounded-lg flex items-center">
                        <div class="mr-3 text-secondary dark:text-accent">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                            </svg>
                        </div>
                        <p class="text-gray-700 dark:text-gray-300 text-sm">Buka aplikasi autentikator Anda untuk melihat kode</p>
                    </div>
                <#elseif method?? && method == "whatsapp">
                    <div class="mt-4 p-4 bg-gray-100 dark:bg-gray-800 rounded-lg flex items-center">
                        <div class="mr-3 text-secondary dark:text-accent">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z" />
                            </svg>
                        </div>
                        <p class="text-gray-700 dark:text-gray-300 text-sm">Kami mengirimkan kode ke nomor telepon terdaftar Anda</p>
                    </div>
                <#elseif method?? && method == "telegram">
                    <div class="mt-4 p-4 bg-gray-100 dark:bg-gray-800 rounded-lg flex items-center">
                        <div class="mr-3 text-secondary dark:text-accent">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
                            </svg>
                        </div>
                        <p class="text-gray-700 dark:text-gray-300 text-sm">Kami mengirimkan kode ke akun Telegram Anda</p>
                    </div>
                <#elseif method?? && method == "email">
                    <div class="mt-4 p-4 bg-gray-100 dark:bg-gray-800 rounded-lg flex items-center">
                        <div class="mr-3 text-secondary dark:text-accent">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                            </svg>
                        </div>
                        <p class="text-gray-700 dark:text-gray-300 text-sm">Kami mengirimkan kode ke alamat email Anda</p>
                    </div>
                </#if>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <button type="submit" class="w-full bg-secondary hover:bg-green-800 dark:bg-accent dark:hover:bg-yellow-500 text-white font-medium py-3 px-4 rounded-lg transition-all duration-300 transform hover:scale-105 flex justify-center items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        Verifikasi
                    </button>
                </div>
                
                <div class="mt-6 text-center">
                    <button type="button" onclick="window.history.back()" class="text-secondary dark:text-accent hover:underline transition-all duration-300 text-sm flex items-center justify-center mx-auto">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                        </svg>
                        Gunakan metode lain
                    </button>
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>