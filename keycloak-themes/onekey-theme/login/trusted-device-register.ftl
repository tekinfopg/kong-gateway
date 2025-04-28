<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        ${msg("trusted-device-confirmation")}
    <#elseif section = "header">
        ${msg("trusted-device-header")}
    <#elseif section="form">
      <form id="kc-form-trusted-device" class="${properties.kcFormClass!}"
            action="${url.loginAction}"
            method="post">
        <div class="${properties.kcFormGroupClass!}">
          <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
            <div class="${properties.kcFormOptionsWrapperClass!}"></div>
          </div>

          <input type="hidden" id="kc-trusted-device-name" name="trusted-device-name"
                 value="${trustedDeviceName}"/>

          <div class="w-full max-w-md mx-auto mt-4">
              <!-- Header dengan icon dan judul -->
              <div class="flex items-center justify-center mb-6">
                  <div class="w-16 h-16 rounded-full bg-green-100 dark:bg-green-900 flex items-center justify-center">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-green-600 dark:text-green-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                      </svg>
                  </div>
              </div>
              
              <h2 class="text-2xl font-bold text-center text-gray-800 dark:text-white mb-4">Jadikan Perangkat Ini Terpercaya?</h2>
              
              <!-- Info box tentang apa yang terjadi jika perangkat dipercaya -->
              <div class="bg-blue-50 dark:bg-blue-900/30 border-l-4 border-blue-500 p-4 mb-6 rounded-md">
                  <div class="flex">
                      <div class="flex-shrink-0">
                          <svg class="h-5 w-5 text-blue-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                              <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" />
                          </svg>
                      </div>
                      <div class="ml-3">
                          <p class="text-sm text-blue-700 dark:text-blue-300">
                              Dengan memilih "Ya", Anda tidak perlu memasukkan kode verifikasi saat login dari perangkat ini selama 30 hari ke depan.
                          </p>
                      </div>
                  </div>
              </div>
              
              <!-- Feature cards yang menjelaskan tentang fitur perangkat terpercaya -->
              <div class="space-y-4 mb-6">
                  <div class="flex items-center p-3 bg-gray-50 dark:bg-gray-700/50 rounded-lg border border-gray-200 dark:border-gray-700">
                      <div class="mr-3 bg-green-100 dark:bg-green-900/50 p-2 rounded-full">
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-600 dark:text-green-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                          </svg>
                      </div>
                      <div>
                          <h3 class="text-sm font-medium text-gray-800 dark:text-gray-200">Perangkat Terpercaya</h3>
                          <p class="text-xs text-gray-500 dark:text-gray-400">Status berlaku selama 30 hari</p>
                      </div>
                  </div>
                  
                  <div class="flex items-center p-3 bg-gray-50 dark:bg-gray-700/50 rounded-lg border border-gray-200 dark:border-gray-700">
                      <div class="mr-3 bg-blue-100 dark:bg-blue-900/50 p-2 rounded-full">
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-blue-600 dark:text-blue-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                          </svg>
                      </div>
                      <div>
                          <h3 class="text-sm font-medium text-gray-800 dark:text-gray-200">Login Lebih Cepat</h3>
                          <p class="text-xs text-gray-500 dark:text-gray-400">Verifikasi multi-faktor akan dilewati</p>
                      </div>
                  </div>
                  
                  <div class="flex items-center p-3 bg-gray-50 dark:bg-gray-700/50 rounded-lg border border-gray-200 dark:border-gray-700">
                      <div class="mr-3 bg-yellow-100 dark:bg-yellow-900/50 p-2 rounded-full">
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-600 dark:text-yellow-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                          </svg>
                      </div>
                      <div>
                          <h3 class="text-sm font-medium text-gray-800 dark:text-gray-200">Hanya Untuk Perangkat Pribadi</h3>
                          <p class="text-xs text-gray-500 dark:text-gray-400">Jangan aktifkan pada perangkat umum</p>
                      </div>
                  </div>
              </div>
            
              <!-- Tombol aksi -->
              <div class="flex flex-col gap-3">
                  <button
                      id="trust-device-btn"
                      class="w-full py-3 px-4 bg-green-600 hover:bg-green-700 focus:ring-green-500 focus:ring-offset-green-200 text-white transition ease-in duration-200 text-center text-base font-semibold shadow-md focus:outline-none focus:ring-2 focus:ring-offset-2 rounded-lg"
                      type="button">
                      Ya, Percayai Perangkat Ini
                  </button>

                  <button
                      class="w-full py-3 px-4 bg-gray-200 hover:bg-gray-300 dark:bg-gray-700 dark:hover:bg-gray-600 focus:ring-gray-500 focus:ring-offset-gray-200 text-gray-900 dark:text-white transition ease-in duration-200 text-center text-base font-semibold shadow-md focus:outline-none focus:ring-2 focus:ring-offset-2 rounded-lg"
                      name="trusted-device"
                      id="kc-trusted-device-no"
                      type="submit"
                      value="no">
                      Tidak, Tetap Gunakan Verifikasi
                  </button>
              </div>
              
              <!-- Footer info -->
              <div class="mt-6 text-center text-xs text-gray-500 dark:text-gray-400">
                  <p>Status perangkat terpercaya akan berakhir setelah 30 hari atau saat Anda logout.</p>
              </div>
              
              <!-- Modal untuk input nama perangkat -->
              <div id="device-name-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center hidden">
                  <div class="bg-white dark:bg-gray-800 rounded-lg shadow-xl p-6 w-11/12 max-w-md transform transition-all">
                      <div class="flex items-center mb-4">
                          <div class="w-10 h-10 rounded-full bg-green-100 dark:bg-green-900/50 flex items-center justify-center mr-3">
                              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-600 dark:text-green-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 3v2m6-2v2M9 19v2m6-2v2M5 9H3m2 6H3m18-6h-2m2 6h-2M7 19h10a2 2 0 002-2V7a2 2 0 00-2-2H7a2 2 0 00-2 2v10a2 2 0 002 2z" />
                              </svg>
                          </div>
                          <h3 class="text-lg font-semibold text-gray-800 dark:text-white">Nama Perangkat Terpercaya</h3>
                      </div>
                      
                      <p class="text-sm text-gray-600 dark:text-gray-300 mb-4">
                          Beri nama untuk perangkat ini agar mudah dikenali di daftar perangkat terpercaya Anda.
                      </p>
                      
                      <input 
                          type="text" 
                          id="device-name-input" 
                          class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 dark:focus:ring-green-400 bg-white dark:bg-gray-700 text-gray-800 dark:text-white"
                          placeholder="Contoh: Laptop Kantor, HP Pribadi"
                          value="${trustedDeviceName}">
                          
                      <div class="flex justify-end gap-3 mt-6">
                          <button 
                              type="button" 
                              id="cancel-device-name" 
                              class="px-4 py-2 bg-gray-200 hover:bg-gray-300 dark:bg-gray-700 dark:hover:bg-gray-600 text-gray-800 dark:text-white rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-400">
                              Batal
                          </button>
                          <button 
                              type="button" 
                              id="confirm-device-name" 
                              class="px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                              Simpan
                          </button>
                      </div>
                  </div>
              </div>
          </div>
        </div>
      </form>
      
      <script>
        // Fungsi untuk modal nama perangkat
        const trustDeviceBtn = document.getElementById('trust-device-btn');
        const deviceNameModal = document.getElementById('device-name-modal');
        const deviceNameInput = document.getElementById('device-name-input');
        const cancelDeviceNameBtn = document.getElementById('cancel-device-name');
        const confirmDeviceNameBtn = document.getElementById('confirm-device-name');
        const hiddenInput = document.getElementById('kc-trusted-device-name');
        
        // Tampilkan modal saat tombol 'Ya' ditekan
        trustDeviceBtn.addEventListener('click', function() {
            deviceNameModal.classList.remove('hidden');
            deviceNameInput.focus();
        });
        
        // Sembunyikan modal saat tombol 'Batal' ditekan
        cancelDeviceNameBtn.addEventListener('click', function() {
            deviceNameModal.classList.add('hidden');
        });
        
        // Proses saat tombol 'Simpan' ditekan
        confirmDeviceNameBtn.addEventListener('click', function() {
            // Update nilai hidden input
            hiddenInput.value = deviceNameInput.value.trim();
            
            // Sembunyikan modal
            deviceNameModal.classList.add('hidden');
            
            // Submit form dengan nilai 'yes'
            const formElement = document.getElementById('kc-form-trusted-device');
            const hiddenButton = document.createElement('input');
            hiddenButton.type = 'hidden';
            hiddenButton.name = 'trusted-device';
            hiddenButton.value = 'yes';
            formElement.appendChild(hiddenButton);
            formElement.submit();
        });
        
        // Tutup modal jika user klik di luar modal
        deviceNameModal.addEventListener('click', function(e) {
            if (e.target === deviceNameModal) {
                deviceNameModal.classList.add('hidden');
            }
        });
        
        // Support untuk keyboard navigation
        deviceNameInput.addEventListener('keyup', function(e) {
            if (e.key === 'Enter') {
                confirmDeviceNameBtn.click();
            } else if (e.key === 'Escape') {
                cancelDeviceNameBtn.click();
            }
        });
      </script>
    </#if>
</@layout.registrationLayout>