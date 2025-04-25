<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('mfa-method'); section>
    <#if section == "header">
        ${msg("Pilih Metode 2FA")}
    <#elseif section == "form">
        <div class="text-center mb-6">
            <h2 class="text-2xl font-bold text-gray-900 dark:text-white transition-colors duration-300">Pilih Metode Autentikasi</h2>
            <p class="text-gray-600 dark:text-gray-300 transition-colors duration-300">Pilih metode Autentikasi dua faktor yang Anda inginkan</p>
        </div>
        
        <form id="kc-select-mfa-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-6">
                <#-- Metode Email -->
                <div class="method-card border-2 rounded-lg overflow-hidden transition-all duration-300 bg-white dark:bg-gray-800
                    ${(email_configured?? && email_configured)?
                        string('border-green-200 dark:border-green-700 hover:border-green-500 dark:hover:border-green-500 hover:shadow-md dark:hover:shadow-green-800/30', 
                               'border-gray-200 bg-gray-50 dark:border-gray-700 dark:bg-gray-800 opacity-80')}">
                    <div class="relative flex w-full">
                        <input type="radio" id="email" name="mfa-method" value="email" 
                            class="absolute opacity-0 w-0 h-0"
                            <#if email_configured?? && email_configured>checked</#if>>
                        <label for="email" class="flex p-4 w-full cursor-pointer transition-all duration-300 hover:bg-green-50 dark:hover:bg-green-900/30 relative">
                            <div class="w-12 h-12 rounded-lg bg-gray-100 dark:bg-gray-700 flex items-center justify-center mr-4 transition-all duration-300">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-7 h-7 text-green-600 dark:text-green-400 transition-colors duration-300" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                                    <polyline points="22,6 12,13 2,6"></polyline>
                                </svg>
                            </div>
                            <div class="flex flex-col justify-center">
                                <span class="font-semibold text-base text-gray-900 dark:text-white transition-colors duration-300">Email</span>
                                <#if !email_configured?? || !email_configured>
                                    <span class="text-sm text-gray-500 dark:text-gray-400 transition-colors duration-300">${msg("Belum Dikonfigurasi")}</span>
                                <#else>
                                    <span class="text-sm text-green-600 dark:text-green-400 transition-colors duration-300">Siap digunakan</span>
                                </#if>
                            </div>
                        </label>
                    </div>
                </div>

                <#-- Metode WhatsApp -->
                <div class="method-card border-2 rounded-lg overflow-hidden transition-all duration-300 bg-white dark:bg-gray-800
                    ${(whatsapp_configured?? && whatsapp_configured)?
                        string('border-green-200 dark:border-green-700 hover:border-green-500 dark:hover:border-green-500 hover:shadow-md dark:hover:shadow-green-800/30', 
                               'border-gray-200 bg-gray-50 dark:border-gray-700 dark:bg-gray-800 opacity-80')}">
                    <div class="relative flex w-full">
                        <input type="radio" id="whatsapp" name="mfa-method" value="whatsapp" 
                            class="absolute opacity-0 w-0 h-0"
                            <#if whatsapp_configured?? && whatsapp_configured>checked</#if>>
                        <label for="whatsapp" class="flex p-4 w-full cursor-pointer transition-all duration-300 hover:bg-green-50 dark:hover:bg-green-900/30 relative">
                            <div class="w-12 h-12 rounded-lg bg-gray-100 dark:bg-gray-700 flex items-center justify-center mr-4 transition-all duration-300">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-7 h-7 text-green-600 dark:text-green-400 transition-colors duration-300" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
                                </svg>
                            </div>
                            <div class="flex flex-col justify-center">
                                <span class="font-semibold text-base text-gray-900 dark:text-white transition-colors duration-300">WhatsApp</span>
                                <#if !whatsapp_configured?? || !whatsapp_configured>
                                    <span class="text-sm text-gray-500 dark:text-gray-400 transition-colors duration-300">${msg("Belum Dikonfigurasi")}</span>
                                <#else>
                                    <span class="text-sm text-green-600 dark:text-green-400 transition-colors duration-300">Siap digunakan</span>
                                </#if>
                            </div>
                        </label>
                    </div>
                </div>

                <#-- Metode Telegram -->
                <div class="method-card border-2 rounded-lg overflow-hidden transition-all duration-300 bg-white dark:bg-gray-800
                    ${(telegram_configured?? && telegram_configured)?
                        string('border-green-200 dark:border-green-700 hover:border-green-500 dark:hover:border-green-500 hover:shadow-md dark:hover:shadow-green-800/30', 
                               'border-gray-200 bg-gray-50 dark:border-gray-700 dark:bg-gray-800 opacity-80')}">
                    <div class="relative flex w-full">
                        <input type="radio" id="telegram" name="mfa-method" value="telegram" 
                            class="absolute opacity-0 w-0 h-0"
                            <#if telegram_configured?? && telegram_configured>checked</#if>>
                        <label for="telegram" class="flex p-4 w-full cursor-pointer transition-all duration-300 hover:bg-green-50 dark:hover:bg-green-900/30 relative">
                            <div class="w-12 h-12 rounded-lg bg-gray-100 dark:bg-gray-700 flex items-center justify-center mr-4 transition-all duration-300">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-7 h-7 text-green-600 dark:text-green-400 transition-colors duration-300" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10s10-4.48 10-10S17.52 2 12 2m4.64 6.8c-.15 1.58-.8 5.42-1.13 7.19c-.14.75-.42 1-.68 1.03c-.58.05-1.02-.38-1.58-.75c-.88-.58-1.38-.94-2.23-1.5c-.99-.65-.35-1.01.22-1.59c.15-.15 2.71-2.48 2.76-2.69a.2.2 0 0 0-.05-.18c-.06-.05-.14-.03-.21-.02c-.09.02-1.49.95-4.22 2.79c-.4.27-.76.41-1.08.4c-.36-.01-1.04-.2-1.55-.37c-.63-.2-1.12-.31-1.08-.66c.02-.18.27-.36.74-.55c2.92-1.27 4.86-2.11 5.83-2.51c2.78-1.16 3.35-1.36 3.73-1.36c.08 0 .27.02.39.12c.1.08.13.19.14.27c-.01.06.01.24 0 .38"/></svg>
                            </div>
                            <div class="flex flex-col justify-center">
                                <span class="font-semibold text-base text-gray-900 dark:text-white transition-colors duration-300">Telegram</span>
                                <#if !telegram_configured?? || !telegram_configured>
                                    <span class="text-sm text-gray-500 dark:text-gray-400 transition-colors duration-300">${msg("Belum Dikonfigurasi")}</span>
                                <#else>
                                    <span class="text-sm text-green-600 dark:text-green-400 transition-colors duration-300">Siap digunakan</span>
                                </#if>
                            </div>
                        </label>
                    </div>
                </div>

                <#-- Metode Authenticator App (TOTP) -->
                <div class="method-card border-2 rounded-lg overflow-hidden transition-all duration-300 bg-white dark:bg-gray-800
                    ${(totp_configured?? && totp_configured)?
                        string('border-green-200 dark:border-green-700 hover:border-green-500 dark:hover:border-green-500 hover:shadow-md dark:hover:shadow-green-800/30', 
                               'border-gray-200 bg-gray-50 dark:border-gray-700 dark:bg-gray-800 opacity-80')}">
                    <div class="relative flex w-full">
                        <input type="radio" id="totp" name="mfa-method" value="totp" 
                            class="absolute opacity-0 w-0 h-0"
                            <#if totp_configured?? && totp_configured>checked</#if>>
                        <label for="totp" class="flex p-4 w-full cursor-pointer transition-all duration-300 hover:bg-green-50 dark:hover:bg-green-900/30 relative">
                            <div class="w-12 h-12 rounded-lg bg-gray-100 dark:bg-gray-700 flex items-center justify-center mr-4 transition-all duration-300">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-7 h-7 text-green-600 dark:text-green-400 transition-colors duration-300" width="24" height="24" viewBox="0 0 48 48">
                                    <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M43.5 24a3.285 3.285 0 0 1-3.285 3.285H29.69L24 17.428l5.262-9.113a3.285 3.285 0 0 1 4.488-1.203h0a3.285 3.285 0 0 1 1.203 4.488l-5.262 9.115h10.524A3.285 3.285 0 0 1 43.5 24" stroke-width="1"/>
                                    <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M33.75 40.888a3.285 3.285 0 0 1-4.488-1.202L24 30.572l-5.262 9.114a3.285 3.285 0 0 1-4.488 1.202h0a3.285 3.285 0 0 1-1.203-4.488l5.261-9.115H29.69l5.262 9.115a3.285 3.285 0 0 1-1.202 4.488M24 17.428l-1.92 3.325l-3.771-.038l-5.262-9.115a3.285 3.285 0 0 1 1.203-4.488h0a3.285 3.285 0 0 1 4.488 1.202z" stroke-width="1"/>
                                    <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="m22.08 20.753l-3.771 6.532H7.785A3.285 3.285 0 0 1 4.5 24h0a3.285 3.285 0 0 1 3.285-3.285zm-3.771 6.532L24 17.428l5.691 9.857z" stroke-width="1"/>
                                </svg>
                            </div>
                            <div class="flex flex-col justify-center">
                                <span class="font-semibold text-base text-gray-900 dark:text-white transition-colors duration-300">Google Authenticator</span>
                                <#if !totp_configured?? || !totp_configured>
                                    <span class="text-sm text-gray-500 dark:text-gray-400 transition-colors duration-300">${msg("Belum Dikonfigurasi")}</span>
                                <#else>
                                    <span class="text-sm text-green-600 dark:text-green-400 transition-colors duration-300">Siap digunakan</span>
                                </#if>
                            </div>
                        </label>
                    </div>
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <button type="submit" class="w-full bg-yellow-500 hover:bg-yellow-600 active:bg-yellow-700 dark:bg-yellow-600 dark:hover:bg-yellow-700 dark:active:bg-yellow-800 text-white font-medium py-3 px-5 border-none rounded-lg cursor-pointer text-base transition-colors duration-300 shadow-md hover:shadow-lg">
                        ${msg('Lanjutkan')}
                    </button>
                </div>
            </div>
        </form>

        <#-- Script untuk meningkatkan interaktivitas -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Tambahkan efek highlight saat metode dipilih
                const methodCards = document.querySelectorAll('.method-card');
                const radioInputs = document.querySelectorAll('input[name="mfa-method"]');
                
                // Set kelas aktif pada pilihan awal
                radioInputs.forEach(input => {
                    if (input.checked) {
                        const card = input.closest('.method-card');
                        highlightCard(card);
                    }
                });
                
                // Tambahkan event listener untuk setiap kartu
                methodCards.forEach(card => {
                    card.addEventListener('click', function() {
                        // Reset semua kartu
                        methodCards.forEach(c => {
                            c.classList.remove('ring-2', 'ring-green-500', 'dark:ring-green-400');
                            c.classList.remove('scale-105');
                        });
                        
                        // Highlight kartu yang dipilih
                        highlightCard(card);
                        
                        // Pilih radio button
                        const radio = card.querySelector('input[type="radio"]');
                        if (radio) {
                            radio.checked = true;
                        }
                    });
                });
                
                function highlightCard(card) {
                    card.classList.add('ring-2', 'ring-green-500', 'dark:ring-green-400');
                    card.classList.add('scale-105');
                }
                
                // Tambahkan animasi sederhana pada hover
                methodCards.forEach(card => {
                    if (!card.classList.contains('opacity-70')) {
                        card.addEventListener('mouseenter', function() {
                            if (!card.classList.contains('scale-105')) {
                                card.classList.add('scale-102');
                            }
                        });
                        
                        card.addEventListener('mouseleave', function() {
                            if (!card.classList.contains('scale-105')) {
                                card.classList.remove('scale-102');
                            }
                        });
                    }
                });
            });
        </script>
        
        <#-- Tambahkan gaya CSS untuk animasi dan efek -->
        <style>
            .scale-102 {
                transform: scale(1.02);
            }
            .scale-105 {
                transform: scale(1.05);
            }
            
            @media (prefers-color-scheme: dark) {
                body.system-mode {
                    background-color: #1a1a1a;
                    color: #ffffff;
                }
            }
            
            /* Transisi ketika kartu diklik */
            .method-card {
                transform-origin: center;
                transition: all 0.3s ease;
            }
            
            /* Animasi pulse untuk kartu terpilih */
            @keyframes softPulse {
                0% { box-shadow: 0 0 0 0 rgba(34, 197, 94, 0.4); }
                70% { box-shadow: 0 0 0 10px rgba(34, 197, 94, 0); }
                100% { box-shadow: 0 0 0 0 rgba(34, 197, 94, 0); }
            }
            
            .ring-2.ring-green-500 {
                animation: softPulse 1s infinite;
            }
            
            /* Warna teks pada mode gelap */
            @media (prefers-color-scheme: dark) {
                .text-gray-800 {
                    color: #f3f4f6;
                }
            }
        </style>
    </#if>
</@layout.registrationLayout>