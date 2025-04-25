<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "form">
        <div class="mb-6 text-center">
            <h2 class="text-2xl font-bold text-primary dark:text-white mb-2">Autentikasi Dua Faktor</h2>
            <p class="text-gray-600 dark:text-gray-300 text-sm">Masukkan kode dari aplikasi autentikator Anda</p>
        </div>

        <form id="kc-otp-login-form" action="${url.loginAction}" method="post" class="space-y-5">
            <div class="space-y-2">
                <label for="otp" class="block text-sm font-medium text-gray-700 dark:text-gray-300">
                    Kode Autentikasi
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 dark:text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                        </svg>
                    </div>
                    <input type="text" id="otp" name="otp" 
                           class="w-full pl-10 pr-4 py-3 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-800 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-secondary dark:focus:ring-accent input-focus-effect"
                           autocomplete="off" 
                           pattern="[0-9]*" 
                           inputmode="numeric"
                           placeholder="Masukkan 6 digit kode"
                           autofocus />
                </div>
                <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">
                    Kode akan berganti secara otomatis setiap 30 detik
                </p>
            </div>

            <div class="flex items-center justify-center mt-6">
                <button type="submit" 
                    class="w-full flex justify-center items-center py-3 px-4 bg-secondary hover:bg-green-800 text-white font-medium rounded-lg transition duration-300 transform hover:scale-105 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-secondary dark:focus:ring-accent shadow-md hover:shadow-lg">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                    </svg>
                    Verifikasi
                </button>
            </div>
        </form>

        <div class="mt-6 space-y-3">
            <div class="py-3 px-4 bg-blue-50 dark:bg-blue-900/30 rounded-lg">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-blue-500 dark:text-blue-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                    <div class="ml-3">
                        <h3 class="text-sm font-medium text-blue-800 dark:text-blue-300">Informasi Autentikasi</h3>
                        <div class="mt-1 text-xs text-blue-700 dark:text-blue-400">
                            Kode autentikasi hanya berlaku untuk satu kali login. Jika mengalami masalah, silakan hubungi administrator.
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <#if client?? && client.baseUrl?has_content>
            <div class="mt-6 text-center">
                <a href="${client.baseUrl}" class="inline-flex items-center text-sm text-secondary hover:text-green-800 dark:text-accent dark:hover:text-yellow-500 transition duration-300">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                    </svg>
                    Kembali ke aplikasi
                </a>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>