<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('code'); section>
    <#if section = "header">
        ${msg("verifyYourEmail")}
    <#elseif section = "form">
        <div class="text-center mb-6">
            <div class="inline-flex items-center justify-center w-16 h-16 bg-green-100 dark:bg-green-900/30 rounded-full mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-green-700 dark:text-green-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                </svg>
            </div>
            <h2 class="text-2xl font-bold text-gray-800 dark:text-white mb-2">Verifikasi Email Anda</h2>
            <p class="text-gray-600 dark:text-gray-300">Kami telah mengirimkan kode verifikasi ke email Anda</p>
        </div>
        
        <form id="kc-email-verify-form" class="space-y-6" action="${url.loginAction}" method="post">
            <div class="mb-6">
                <label for="code" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                    Kode Verifikasi Email
                </label>
                
                <div class="text-sm text-gray-600 dark:text-gray-400 mb-3">
                    Silakan masukkan kode 6 digit yang dikirim ke ${email!'email Anda'}
                </div>
                
                <!-- OTP-like Input Field -->
                <div class="flex flex-col">
                    <div class="relative">
                        <input 
                            type="text" 
                            id="code" 
                            name="code" 
                            class="block w-full px-4 py-3 text-center tracking-widest text-lg bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-700 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-700 dark:focus:ring-accent input-focus-effect"
                            inputmode="numeric"
                            autocomplete="one-time-code"
                            pattern="[0-9]*"
                            minlength="6"
                            maxlength="6"
                            autofocus
                            required
                        />
                        <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                            </svg>
                        </div>
                    </div>
                    <div class="mt-1 text-xs text-center text-gray-500 dark:text-gray-400">
                        Kode 6 digit
                    </div>
                </div>
            </div>
            
            <!-- Method Info with Animation -->
            <div class="p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg flex items-center space-x-3 mb-6 animate-pulse-slow">
                <div class="flex-shrink-0 bg-blue-100 dark:bg-blue-800 rounded-full p-2">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-600 dark:text-blue-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                </div>
                <div>
                    <p class="text-sm text-blue-700 dark:text-blue-300">Periksa kotak masuk email Anda untuk kode verifikasi</p>
                </div>
            </div>

            <div class="flex justify-center">
                <button 
                    type="submit" 
                    class="w-full py-3 px-4 bg-secondary hover:bg-green-800 focus:ring-green-700 focus:ring-offset-2 text-white rounded-lg shadow-md hover:shadow-lg transition-all duration-300 flex items-center justify-center"
                >
                    <span>Verifikasi</span>
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                    </svg>
                </button>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>