<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
  <#if section = "form">
    <!-- Login Form Header -->
    <header class="mb-8 flex flex-col items-center text-center">
      <h2 class="text-3xl font-bold text-primary dark:text-white mb-2">Selamat datang kembali</h2>

      <p class="text-gray-600 dark:text-gray-300">Masuk untuk mengakses akun Anda</p>

    </header>

    <!-- Form Login -->
    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post" class="space-y-6">
      <div class="form-group">
        <label for="username" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
          ${msg("username")} <span class="text-secondary dark:text-accent">*</span>
        </label>
        <div class="relative">
          <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 dark:text-gray-500" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
            </svg>
          </div>
          <input tabindex="1" id="username" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="off"
                 placeholder="Masukkan username Anda"
                 class="input-focus-effect pl-10 block w-full px-4 py-3 rounded-lg bg-white/50 dark:bg-gray-800/50 text-gray-700 dark:text-white border border-gray-300 dark:border-gray-600 focus:border-secondary dark:focus:border-accent focus:outline-none transition-all" />
          <!-- Username tooltip -->
          <div class="tooltip absolute right-3 top-1/2 transform -translate-y-1/2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 dark:text-gray-500" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd" />
            </svg>
            <span class="tooltip-text">Masukkan email atau username Anda yang terdaftar</span>
          </div>
        </div>
      </div>

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
          <input tabindex="2" id="password" name="password" type="password" autocomplete="off"
                 placeholder="Masukkan password Anda"
                 class="input-focus-effect pl-10 block w-full px-4 py-3 rounded-lg bg-white/50 dark:bg-gray-800/50 text-gray-700 dark:text-white border border-gray-300 dark:border-gray-600 focus:border-secondary dark:focus:border-accent focus:outline-none transition-all" />
          <!-- Tombol Toggle Visibilitas Password -->
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
      </div>

      <div class="flex items-center justify-between">
        <label class="inline-flex items-center">
          <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" class="h-4 w-4 text-secondary dark:text-accent focus:ring-secondary dark:focus:ring-accent rounded border-gray-300 dark:border-gray-600" />
          <span class="ml-2 text-sm text-gray-600 dark:text-gray-400">Ingat saya</span>

        </label>
        
        <#if realm.resetPasswordAllowed>
          <a tabindex="5" href="${url.loginResetCredentialsUrl}" class="text-sm text-secondary dark:text-accent hover:text-secondary-600 dark:hover:text-accent-400 transition hover:underline">
            ${msg("doForgotPassword")}
          </a>
        </#if>
      </div>

      <button tabindex="4" type="submit" name="login" id="kc-login" class="w-full bg-secondary hover:bg-secondary-600 dark:bg-accent dark:hover:bg-accent-600 text-white py-3 px-4 rounded-lg transition-all hover:shadow-lg flex items-center justify-center gap-2 font-medium">
        <span>Masuk</span>
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd" />
        </svg>
      </button>
    </form>

    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
      <div class="mt-6 text-center">        
          <p class="mt-4 text-sm text-gray-600 dark:text-gray-400">
            ${msg("noAccount")} 
            <a href="${url.registrationUrl}" class="font-medium text-secondary dark:text-accent hover:text-secondary-600 dark:hover:text-accent-400 transition hover:underline">
              Daftar
          </a>
        </p>
      </div>
    </#if>

  </#if>
</@layout.registrationLayout>
