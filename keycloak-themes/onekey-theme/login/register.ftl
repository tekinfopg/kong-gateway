<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true displayRequiredFields=true; section>
  <#if section = "form">
    <!-- Registration Form Header -->
    <header class="mb-8 flex flex-col items-center text-center">
      <h2 class="text-3xl font-bold text-primary dark:text-white mb-2">Buat Akun Anda</h2>
      <p class="text-gray-600 dark:text-gray-300">Bergabunglah dengan platform aman kami dalam beberapa langkah saja</p>

    </header>

    <!-- Form Registration -->
    <form id="kc-register-form" action="${url.registrationAction}" method="post" class="space-y-6">
      <!-- Name Fields - Two Column Layout -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <!-- First Name Field -->
        <div class="form-group">
          <label for="firstName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Nama Depan <span class="text-secondary dark:text-accent">*</span>
          </label>

          <div class="relative">
            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 dark:text-gray-500" viewBox="0 0 20 20" fill="currentColor">
                <path d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" />
              </svg>
            </div>
<input id="firstName" name="firstName" type="text" value="${(register.formData.firstName!'')}" 
                   placeholder="Masukkan nama depan Anda"
                   aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"
                   class="input-focus-effect pl-10 block w-full px-4 py-3 rounded-lg bg-white/50 dark:bg-gray-800/50 text-gray-700 dark:text-white border border-gray-300 dark:border-gray-600 focus:border-secondary dark:focus:border-accent focus:outline-none transition-all" />
          </div>
          <#if messagesPerField.existsError('firstName')>
            <span class="text-sm text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</span>
          </#if>
        </div>

        <!-- Last Name Field -->
        <div class="form-group">
          <label for="lastName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Nama Belakang <span class="text-secondary dark:text-accent">*</span>
          </label>

          <div class="relative">
            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 dark:text-gray-500" viewBox="0 0 20 20" fill="currentColor">
                <path d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" />
              </svg>
            </div>
<input id="lastName" name="lastName" type="text" value="${(register.formData.lastName!'')}" 
                   placeholder="Masukkan nama belakang Anda"
                   aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"
                   class="input-focus-effect pl-10 block w-full px-4 py-3 rounded-lg bg-white/50 dark:bg-gray-800/50 text-gray-700 dark:text-white border border-gray-300 dark:border-gray-600 focus:border-secondary dark:focus:border-accent focus:outline-none transition-all" />
          </div>
          <#if messagesPerField.existsError('lastName')>
            <span class="text-sm text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</span>
          </#if>
        </div>
      </div>

      <!-- Email Field -->
      <div class="form-group">
          <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Email <span class="text-secondary dark:text-accent">*</span>
          </label>

        <div class="relative">
          <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 dark:text-gray-500" viewBox="0 0 20 20" fill="currentColor">
              <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z" />
              <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z" />
            </svg>
          </div>
<input id="email" name="email" type="email" value="${(register.formData.email!'')}" 
                 placeholder="Masukkan alamat email Anda"
                 aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
                 class="input-focus-effect pl-10 block w-full px-4 py-3 rounded-lg bg-white/50 dark:bg-gray-800/50 text-gray-700 dark:text-white border border-gray-300 dark:border-gray-600 focus:border-secondary dark:focus:border-accent focus:outline-none transition-all" />
          <!-- Email tooltip -->
          <div class="tooltip absolute right-3 top-1/2 transform -translate-y-1/2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 dark:text-gray-500" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd" />
            </svg>
            <span class="tooltip-text">Kami akan mengirim email verifikasi ke alamat ini</span>
          </div>
        </div>
        <#if messagesPerField.existsError('email')>
          <span class="text-sm text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('email'))?no_esc}</span>
        </#if>
      </div>

      <!-- Username Field -->
      <div class="form-group">
          <label for="username" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Username <span class="text-secondary dark:text-accent">*</span>
          </label>

        <div class="relative">
          <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 dark:text-gray-500" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
            </svg>
          </div>
<input id="username" name="username" type="text" value="${(register.formData.username!'')}" 
                 placeholder="Pilih nama pengguna Anda"
                 aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                 class="input-focus-effect pl-10 block w-full px-4 py-3 rounded-lg bg-white/50 dark:bg-gray-800/50 text-gray-700 dark:text-white border border-gray-300 dark:border-gray-600 focus:border-secondary dark:focus:border-accent focus:outline-none transition-all" />
          <!-- Username tooltip -->
          <div class="tooltip absolute right-3 top-1/2 transform -translate-y-1/2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 dark:text-gray-500" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd" />
            </svg>
            <span class="tooltip-text">Gunakan hanya huruf, angka, dan garis bawah</span>
          </div>
        </div>
        <#if messagesPerField.existsError('username')>
          <span class="text-sm text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('username'))?no_esc}</span>
        </#if>
      </div>

      <!-- Password Field -->
      <div class="form-group">
          <label for="password" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Password <span class="text-secondary dark:text-accent">*</span>
          </label>

        <div class="relative">
          <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 dark:text-gray-500" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd" />
            </svg>
          </div>
<input id="password" name="password" type="password" 
                 placeholder="Buat kata sandi"
                 aria-invalid="<#if messagesPerField.existsError('password')>true</#if>"
                 class="input-focus-effect pl-10 block w-full px-4 py-3 rounded-lg bg-white/50 dark:bg-gray-800/50 text-gray-700 dark:text-white border border-gray-300 dark:border-gray-600 focus:border-secondary dark:focus:border-accent focus:outline-none transition-all" />
          <!-- Toggle password visibility button -->
          <button type="button" class="toggle-password absolute inset-y-0 right-0 pr-3 flex items-center focus:outline-none" data-target="#password">
            <svg class="show-password h-5 w-5 text-gray-400 dark:text-gray-500" fill="none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
            </svg>
            <svg class="hide-password hidden h-5 w-5 text-gray-400 dark:text-gray-500" fill="none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
            </svg>
          </button>
        </div>
        
        <!-- Password tooltip -->
<div class="mt-2 flex justify-between items-center">
          <div class="text-xs text-gray-500 dark:text-gray-400">Kata sandi harus mencakup:</div>
          <div class="tooltip relative">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400 dark:text-gray-500" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd" />
            </svg>
            <span class="tooltip-text">
              <ul class="text-xs text-left">
                <li>• Minimal 8 karakter</li>
                <li>• Setidaknya satu angka</li>
                <li>• Setidaknya satu huruf kapital</li>
                <li>• Setidaknya satu karakter khusus</li>
              </ul>
            </span>
          </div>
        </div>
        
        <!-- Password strength meter -->
        <div class="password-strength-meter mt-2">
          <div class="password-strength-meter-fill"></div>
        </div>
        <div class="flex justify-between items-center mt-1">
          <span id="password-strength-text" class="text-xs text-gray-500 dark:text-gray-400"></span>
        </div>
        
        <#if messagesPerField.existsError('password')>
          <span class="text-sm text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
        </#if>
      </div>

      <!-- Password Confirmation Field -->
      <div class="form-group">
          <label for="password-confirm" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Konfirmasi Password <span class="text-secondary dark:text-accent">*</span>
          </label>

        <div class="relative">
          <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 dark:text-gray-500" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd" />
            </svg>
          </div>
            <input id="password-confirm" name="password-confirm" type="password" 
                   placeholder="Konfirmasi password Anda"

                 aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                 class="input-focus-effect pl-10 block w-full px-4 py-3 rounded-lg bg-white/50 dark:bg-gray-800/50 text-gray-700 dark:text-white border border-gray-300 dark:border-gray-600 focus:border-secondary dark:focus:border-accent focus:outline-none transition-all" />
          <!-- Toggle password visibility button -->
          <button type="button" class="toggle-password absolute inset-y-0 right-0 pr-3 flex items-center focus:outline-none" data-target="#password-confirm">
            <svg class="show-password h-5 w-5 text-gray-400 dark:text-gray-500" fill="none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
            </svg>
            <svg class="hide-password hidden h-5 w-5 text-gray-400 dark:text-gray-500" fill="none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
            </svg>
          </button>
        </div>
        <#if messagesPerField.existsError('password-confirm')>
          <span class="text-sm text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
        </#if>
      </div>

      <!-- Terms and Conditions -->
      <div class="form-group">
        <label class="inline-flex items-center">
          <input id="terms-accepted" name="terms-accepted" type="checkbox" class="h-4 w-4 text-secondary dark:text-accent focus:ring-secondary dark:focus:ring-accent rounded border-gray-300 dark:border-gray-600" />
          <span class="ml-2 text-sm text-gray-600 dark:text-gray-400">
            Saya setuju dengan <a href="#" class="text-secondary dark:text-accent hover:underline">Syarat Layanan</a> dan <a href="#" class="text-secondary dark:text-accent hover:underline">Kebijakan Privasi</a>

          </span>
        </label>
      </div>

      <!-- Register Button -->
      <button type="submit" class="w-full bg-secondary hover:bg-secondary-600 dark:bg-accent dark:hover:bg-accent-600 text-white py-3 px-4 rounded-lg transition-all hover:shadow-lg flex items-center justify-center gap-2 font-medium">
        <span>BUAT AKUN</span>

        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd" />
        </svg>
      </button>
    </form>

    <!-- Already have an account -->
    <div class="mt-6 text-center">
      <div class="relative">
        <div class="absolute inset-0 flex items-center">
          <div class="w-full border-t border-gray-300 dark:border-gray-700"></div>
        </div>
        <div class="relative flex justify-center text-sm">
          <span class="px-2 bg-white dark:bg-gray-900 text-gray-500 dark:text-gray-400">Sudah memiliki akun?</span>

        </div>
      </div>
      
      <p class="mt-4 text-sm text-gray-600 dark:text-gray-400">
        <a href="${url.loginUrl}" class="font-medium text-secondary dark:text-accent hover:text-secondary-600 dark:hover:text-accent-400 transition hover:underline">
          Silakan masuk

        </a>
      </p>
    </div>

  </#if>
</@layout.registrationLayout>