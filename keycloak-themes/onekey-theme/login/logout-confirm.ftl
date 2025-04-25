<#import "template.ftl" as layout>

<@layout.registrationLayout bodyClass="logout-confirm" displayMessage=true; section>
    <#if section = "header">
        ${msg("logoutConfirmTitle")}
    <#elseif section = "form">
        <div class="flex flex-col items-center text-center">
            <!-- Logout Icon -->
            <div class="mb-6 bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-300 p-4 rounded-full">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                </svg>
            </div>
            
            <!-- Confirmation Message -->
            <h2 class="text-xl font-bold mb-4 text-gray-800 dark:text-gray-200">Konfirmasi Keluar</h2>
            <p class="mb-6 text-gray-600 dark:text-gray-300">Apakah Anda yakin ingin keluar dari akun OneKey?</p>
            
            <!-- Form Actions -->
            <div class="flex flex-col sm:flex-row gap-4 w-full">
                <form action="${url.logoutConfirmAction}" method="post" class="w-full">
                    <input name="session_code" type="hidden" value="${logoutConfirm.code}">
                    <button type="submit" name="confirmLogout" value="${msg("doLogout")}" 
                        class="w-full bg-secondary hover:bg-green-800 text-white font-medium py-2.5 px-4 rounded-lg transition-all duration-300 flex items-center justify-center gap-2 input-focus-effect">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                        </svg>
                        Ya, Keluar
                    </button>
                </form>
                
                <#if !logoutConfirm.skipLink>
                    <#if (client.baseUrl)?has_content>
                        <a href="${client.baseUrl}" 
                           class="w-full border border-gray-300 dark:border-gray-600 hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-700 dark:text-gray-300 font-medium py-2.5 px-4 rounded-lg transition-all duration-300 flex items-center justify-center gap-2 input-focus-effect">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 15l-3-3m0 0l3-3m-3 3h8M3 12a9 9 0 1118 0 9 9 0 01-18 0z" />
                            </svg>
                            Kembali ke Aplikasi
                        </a>
                    </#if>
                </#if>
            </div>
            
            <!-- Security Note -->
            <div class="mt-8 text-xs text-gray-500 dark:text-gray-400 flex items-center gap-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span>Keluar akan mengakhiri semua sesi dan Anda perlu login kembali untuk mengakses aplikasi.</span>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>