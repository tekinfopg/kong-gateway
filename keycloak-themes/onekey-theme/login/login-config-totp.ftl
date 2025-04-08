<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>
    <#if section = "form">
        <div class="text-center mb-6">
            <h2 class="text-2xl font-bold text-gray-800 dark:text-gray-100 mb-2">Autentikasi Dua Faktor</h2>
            <p class="text-gray-600 dark:text-gray-300 text-sm">Pindai kode QR menggunakan aplikasi autentikator Anda</p>
        </div>

        <div class="flex flex-col items-center justify-center mb-6">
            <!-- QR Code Container -->
            <div class="bg-white p-4 rounded-lg shadow-md mb-4 relative">
                <img src="data:image/png;base64,${totp.totpSecretQrCode}" 
                     class="w-48 h-48 object-contain" 
                     alt="Kode QR untuk pengaturan TOTP" />
            </div>

            <!-- Manual Setup Link -->
            <button type="button" id="toggle-manual" onclick="toggleManualSetup()" 
                    class="text-sm text-secondary dark:text-accent hover:underline flex items-center mt-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                Tidak dapat memindai? Klik untuk pengaturan manual
            </button>

            <!-- Manual Setup Instructions (Hidden by default) -->
            <div id="manual-setup" class="bg-gray-50 dark:bg-gray-800 rounded-lg p-4 mt-3 w-full hidden">
                <p class="text-gray-700 dark:text-gray-300 text-sm mb-2">Masukkan kode ini di aplikasi Anda:</p>
                <div class="bg-white dark:bg-gray-700 p-3 rounded border border-gray-200 dark:border-gray-600 flex items-center justify-between">
                    <code class="font-mono text-secondary dark:text-accent">${totp.totpSecret}</code>
                    <button type="button" onclick="copyToClipboard('${totp.totpSecret}')" 
                            class="text-gray-500 hover:text-secondary dark:hover:text-accent">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-1M8 5a2 2 0 002 2h2a2 2 0 002-2M8 5a2 2 0 012-2h2a2 2 0 012 2m0 0h2a2 2 0 012 2v3m2 4H10m0 0l3-3m-3 3l3 3" />
                        </svg>
                    </button>
                </div>
                <p class="text-gray-600 dark:text-gray-400 text-xs mt-2">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 inline-block mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    Pastikan untuk menyimpan kode ini di tempat yang aman
                </p>
            </div>
        </div>

        <!-- Verification Form -->
        <form action="${url.loginAction}" method="post" class="mt-6">
            <div class="mb-6">
                <label for="totp" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                    Masukkan kode verifikasi dari aplikasi Anda
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                        </svg>
                    </div>
                    <input type="text" 
                           id="totp" 
                           name="totp" 
                           class="pl-10 block w-full bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md py-3 px-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 dark:focus:ring-amber-500 focus:border-green-500 dark:focus:border-amber-500 input-focus-effect"
                           autocomplete="off" 
                           pattern="[0-9]*" 
                           inputmode="numeric"
                           maxlength="6"
                           placeholder="Masukkan kode 6 digit"
                           autocomplete="one-time-code"
                           required />
                </div>
                <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3 inline mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                    </svg>
                    Kode ini berubah setiap 30 detik
                </p>
            </div>

            <input type="hidden" name="totpSecret" value="${totp.totpSecret}" />
            <input type="hidden" name="userLabel" value="OneKey Authenticator" />
            <input type="hidden" name="logout-sessions" value="on" />

            <div class="flex items-center space-x-4 mt-6">
                <button type="submit" class="w-full flex justify-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-secondary hover:bg-green-700 dark:bg-accent dark:hover:bg-yellow-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-secondary dark:focus:ring-accent transition duration-150">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    Verifikasi dan Selesaikan Pengaturan
                </button>
            </div>
        </form>

        <!-- Instructions Panel -->
        <div class="mt-8 bg-gray-50 dark:bg-gray-800/50 rounded-lg p-4">
            <h3 class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2 flex items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2 text-secondary dark:text-accent" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                Panduan Pengaturan
            </h3>
            <ol class="text-xs text-gray-600 dark:text-gray-400 list-decimal pl-5 space-y-1">
                <li>Unduh aplikasi autentikator seperti Google Authenticator, Microsoft Authenticator, atau Authy.</li>
                <li>Buka aplikasi dan tambahkan akun baru dengan memindai kode QR di atas.</li>
                <li>Setelah memindai, aplikasi akan menampilkan kode 6 digit yang berubah setiap 30 detik.</li>
                <li>Masukkan kode 6 digit yang muncul di aplikasi ke dalam kotak input di atas.</li>
            </ol>
        </div>

        <script>
            function toggleManualSetup() {
                const manualSetup = document.getElementById('manual-setup');
                manualSetup.classList.toggle('hidden');
            }

            function copyToClipboard(text) {
                navigator.clipboard.writeText(text).then(function() {
                    // Success feedback
                    const button = event.currentTarget;
                    const originalHTML = button.innerHTML;
                    
                    button.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" /></svg>';
                    
                    setTimeout(function() {
                        button.innerHTML = originalHTML;
                    }, 2000);
                });
            }

            // Auto-format TOTP input to groups of 3 digits
            document.getElementById('totp').addEventListener('input', function(e) {
                // Keep only digits
                this.value = this.value.replace(/[^0-9]/g, '');
                
                // Limit to 6 digits
                if (this.value.length > 6) {
                    this.value = this.value.slice(0, 6);
                }
            });
        </script>
    </#if>
</@layout.registrationLayout>