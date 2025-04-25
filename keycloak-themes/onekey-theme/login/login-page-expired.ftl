<#import "template.ftl" as layout>
<@layout.registrationLayout bodyClass="page-expired" displayInfo=false displayMessage=true; section>
    <#if section = "form">
        <div class="flex flex-col items-center text-center mb-8">
            <!-- Session Expired Icon -->
            <div class="w-20 h-20 mb-6 text-secondary dark:text-amber-400">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="w-full h-full">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
            </div>
            
            <!-- Page Title -->
            <h2 class="text-2xl font-bold text-gray-800 dark:text-white mb-2">Sesi Telah Berakhir</h2>
            
            <!-- Description -->
            <p class="text-gray-600 dark:text-gray-300 mb-8">
                Sesi Anda telah berakhir atau tidak valid. Silakan coba lagi untuk melanjutkan.
            </p>
            
            <!-- Action Buttons -->
            <div class="flex flex-col sm:flex-row gap-4 w-full">
                <!-- Try Again Button -->
                <a href="${url.loginRestartFlowUrl}" class="w-full py-2.5 px-4 bg-secondary hover:bg-green-600 dark:bg-amber-500 dark:hover:bg-amber-600 text-white font-medium rounded-lg text-sm transition-colors duration-300 flex items-center justify-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                    </svg>
                    Coba Lagi
                </a>
                
                <!-- Continue Button -->
                <a href="${url.loginAction}" class="w-full py-2.5 px-4 bg-white hover:bg-gray-100 dark:bg-white/10 dark:hover:bg-white/20 text-gray-700 dark:text-white font-medium rounded-lg text-sm border border-gray-300 dark:border-gray-600 transition-colors duration-300 flex items-center justify-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 5l7 7-7 7M5 5l7 7-7 7" />
                    </svg>
                    Lanjutkan
                </a>
            </div>
        </div>
        
        <!-- Help Text -->
        <div class="mt-8 text-center text-sm text-gray-500 dark:text-gray-400">
            <p>Jika masalah berlanjut, silakan hubungi <a href="#" class="text-secondary dark:text-amber-400 hover:underline">tim dukungan</a> kami.</p>
        </div>
    </#if>
</@layout.registrationLayout>