<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('mfa-config'); section>
    <#if section == "header">
        ${msg("Configure")?replace("{0}", (method!'')?capitalize)}
    <#elseif section == "form">
        <div class="flex flex-col space-y-4">
            <!-- Judul dan Subjudul -->
            <div class="text-center mb-6">
                <h2 class="text-2xl font-semibold text-primary dark:text-white">
                    Konfigurasi Autentikasi ${(method!'')?capitalize}
                </h2>
                <p class="text-gray-600 dark:text-gray-300 mt-2 text-sm">
                    Siapkan detail autentikasi Anda untuk melanjutkan
                </p>
            </div>
            
            <form id="kc-mfa-config-form" class="space-y-4" action="${url.loginAction}" method="post">
                <input type="hidden" id="mfa-method" name="mfa-method" value="${method!''}">
                
                <div class="bg-white/50 dark:bg-gray-800/50 backdrop-blur-sm p-5 rounded-xl border border-gray-200 dark:border-gray-700 transition-all duration-300">
                    <#if method?? && method == "whatsapp">
                        <!-- Metode WhatsApp -->
                        <div class="flex items-center mb-4 p-3 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
                            <div class="mr-3 bg-green-400/20 dark:bg-green-700/30 p-3 rounded-full">
                                <!-- Ikon WhatsApp (opsional: bisa disesuaikan) -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500" fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M20.52 3.48A11.93 11.93 0 0012 0C5.373 0 0 5.373 0 12a11.93 11.93 0 003.48 8.52L0 24l3.48-3.48A11.93 11.93 0 0012 24c6.627 0 12-5.373 12-12 0-3.2-1.248-6.168-3.48-8.52zM12 22a10 10 0 01-5.292-1.426l-.378-.224-3.15.948.845-3.085-.246-.391A10 10 0 012 12c0-5.514 4.486-10 10-10s10 4.486 10 10-4.486 10-10 10zm5.43-7.59c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347"/>
                                </svg>
                            </div>
                            <p class="text-gray-700 dark:text-gray-300 text-sm">
                                Kami akan mengirimkan kode verifikasi ke WhatsApp Anda saat masuk
                            </p>
                        </div>
                        
                        <div class="space-y-2">
                            <label for="phoneNumber" class="block text-sm font-medium text-gray-700 dark:text-gray-300">
                                Nomor WhatsApp
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                    </svg>
                                </div>
                                <input 
                                    type="tel" 
                                    id="phoneNumber" 
                                    name="phoneNumber" 
                                    class="w-full pl-10 pr-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-secondary dark:focus:ring-accent focus:border-secondary dark:focus:border-accent bg-white dark:bg-gray-700 text-gray-900 dark:text-white input-focus-effect" 
                                    placeholder="+62812345678"
                                    value="${(phoneNumber!'')}" 
                                />
                            </div>
                            <p class="text-xs text-gray-500 dark:text-gray-400">
                                Masukkan nomor WhatsApp lengkap dengan kode negara (mis. +62812345678)
                            </p>
                        </div>
                    <#elseif method?? && method == "telegram">
                        <!-- Metode Telegram -->
                        <div class="flex items-center mb-4 p-3 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
                            <div class="mr-3 bg-blue-400/20 dark:bg-blue-700/30 p-3 rounded-full">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
                                </svg>
                            </div>
                            <p class="text-gray-700 dark:text-gray-300 text-sm">
                                Kami akan mengirimkan kode verifikasi ke akun Telegram Anda
                            </p>
                        </div>
                        
                        <div class="space-y-2">
                            <label for="telegramId" class="block text-sm font-medium text-gray-700 dark:text-gray-300">
                                ID Chat Telegram
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />
                                    </svg>
                                </div>
                                <input 
                                    type="text" 
                                    id="telegramId" 
                                    name="telegramId" 
                                    class="w-full pl-10 pr-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-blue-500 dark:focus:border-blue-400 bg-white dark:bg-gray-700 text-gray-900 dark:text-white input-focus-effect" 
                                    placeholder="${msg('Masukkan ID telegram Anda')}"
                                    value="${(telegramId!'')}" 
                                />
                            </div>
                            
                            <div class="mt-4 p-4 bg-blue-50 dark:bg-blue-900/30 rounded-lg border border-blue-100 dark:border-blue-800">
                                <h4 class="text-sm font-medium text-blue-800 dark:text-blue-300 mb-2">
                                    Cara mendapatkan ID Chat Telegram Anda:
                                </h4>
                                <ol class="list-decimal pl-5 text-xs text-blue-700 dark:text-blue-300 space-y-1">
                                    <li>Buka Telegram dan cari bot kami: <strong>@OneKey-PKG</strong></li>
                                    <li>Kirim pesan apa saja dan bot akan membalas dengan ID Chat Anda</li>
                                    <li>Salin ID Chat dan tempel di sini</li>
                                </ol>
                            </div>
                        </div>
                    <#elseif method?? && method == "email">
                        <!-- Metode Email -->
                        <div class="flex items-center mb-4 p-3 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
                            <div class="mr-3 bg-yellow-400/20 dark:bg-yellow-500/30 p-3 rounded-full">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-yellow-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                </svg>
                            </div>
                            <p class="text-gray-700 dark:text-gray-300 text-sm">
                                Kami akan mengirimkan kode verifikasi ke alamat email Anda saat masuk
                            </p>
                        </div>
                        
                        <div class="space-y-2">
                            <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300">
                                Alamat Email
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207" />
                                    </svg>
                                </div>
                                <input 
                                    type="email" 
                                    id="email" 
                                    name="email" 
                                    class="w-full pl-10 pr-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-yellow-500 dark:focus:ring-yellow-400 focus:border-yellow-500 dark:focus:border-yellow-400 bg-white dark:bg-gray-700 text-gray-900 dark:text-white input-focus-effect" 
                                    placeholder="${msg('Masukkan alamat email Anda')}"
                                    value="${(email!'')}" 
                                />
                            </div>
                        </div>
                    <#elseif method?? && method == "otp">
                        <!-- Metode OTP / TOTP -->
                        <div class="flex items-center mb-4 p-3 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
                            <div class="mr-3 bg-secondary/20 dark:bg-green-700/30 p-3 rounded-full">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-secondary dark:text-green-400" width="24" height="24" viewBox="0 0 15 15">
                                    <path fill="none" stroke="currentColor" d="M6 5.5h3m-1.5 0V10m3 0V7.5m0 0v-2h1a1 1 0 1 1 0 2zm-6-1v2a1 1 0 0 1-2 0v-2a1 1 0 0 1 2 0Zm-3-6h12a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1h-12a1 1 0 0 1-1-1v-12a1 1 0 0 1 1-1Z" stroke-width="1"/>
                                </svg>
                            </div>
                            <p class="text-gray-700 dark:text-gray-300 text-sm">
                                Gunakan aplikasi autentikator untuk menghasilkan kode verifikasi saat masuk
                            </p>
                        </div>
                        
                        <div class="text-center p-4">
                            <p class="text-gray-600 dark:text-gray-300 text-sm mb-2">
                                Pindai kode QR ini dengan aplikasi autentikator Anda
                            </p>
                            <div class="bg-white p-4 rounded-lg inline-block mb-4 shadow-md">
                                <!-- Placeholder untuk QR Code -->
                                <div class="w-48 h-48 bg-gray-200 dark:bg-gray-600 rounded-md animate-pulse flex items-center justify-center">
                                    <span class="text-gray-400 dark:text-gray-300 text-xs">QR Code</span>
                                </div>
                            </div>
                            <p class="text-xs text-gray-500 dark:text-gray-400">
                                Kami mendukung Google Authenticator, Authy, dan aplikasi autentikator TOTP lainnya
                            </p>
                        </div>
                    </#if>
                </div>

                <div class="flex flex-col space-y-3">
                    <button type="submit" class="w-full bg-secondary hover:bg-green-800 dark:bg-green-700 dark:hover:bg-green-600 text-white font-medium py-2 px-4 rounded-lg shadow-md hover:shadow-lg transition-all duration-300 transform hover:-translate-y-0.5">
                        Simpan
                    </button>
                    
                    <button type="button" onclick="window.history.back()" class="text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-200 text-sm font-medium py-2 px-4 rounded-lg transition-colors duration-300">
                        <span class="flex items-center justify-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                            </svg>
                            Kembali
                        </span>
                    </button>
                </div>
            </form>
        </div>
    </#if>
</@layout.registrationLayout>
