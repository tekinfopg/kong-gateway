<#import "template.ftl" as layout>

<@layout.registrationLayout
  displayMessage=!messagesPerField.existsError("password", "password-confirm")
  ;
  section
>
  <#if section="header">
    <h2 class="text-2xl font-bold text-gray-800 dark:text-white mb-6 text-center">
      Perbarui Kata Sandi
    </h2>
  <#elseif section="form">
    <div class="space-y-6">
      <form id="kc-passwd-update-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
        <input type="text" id="username" name="username" autocomplete="username" class="hidden" value="${username}">
        <input type="password" id="password" name="password" autocomplete="current-password" class="hidden">
        
        <!-- New Password Field -->
        <div class="mb-6">
          <label for="password-new" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Kata Sandi Baru <span class="text-red-500">*</span>
          </label>
          <div class="relative">
            <input 
              type="password" 
              id="password-new" 
              name="password-new" 
              class="w-full px-4 py-3 rounded-lg border ${messagesPerField.existsError('password', 'password-confirm')?then('border-red-500 dark:border-red-400', 'border-gray-300 dark:border-gray-600')} bg-white dark:bg-gray-800 text-gray-800 dark:text-white placeholder-gray-400 focus:border-green-500 dark:focus:border-yellow-500 focus:ring-green-500 dark:focus:ring-yellow-500 focus:outline-none focus:ring-2 focus:ring-opacity-30 transition-colors input-focus-effect" 
              autofocus 
              autocomplete="new-password" 
              aria-invalid="${messagesPerField.existsError('password', 'password-confirm')?string('true', 'false')}"
              required
            />
            <button type="button" class="toggle-password absolute inset-y-0 right-0 pr-3 flex items-center text-sm leading-5 text-gray-500 dark:text-gray-400" data-target="#password-new">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 show-password" viewBox="0 0 20 20" fill="currentColor">
                <path d="M10 12a2 2 0 100-4 2 2 0 000 4z" />
                <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd" />
              </svg>
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 hide-password hidden" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M3.707 2.293a1 1 0 00-1.414 1.414l14 14a1 1 0 001.414-1.414l-1.473-1.473A10.014 10.014 0 0019.542 10C18.268 5.943 14.478 3 10 3a9.958 9.958 0 00-4.512 1.074l-1.78-1.781zm4.261 4.26l1.514 1.515a2.003 2.003 0 012.45 2.45l1.514 1.514a4 4 0 00-5.478-5.478z" clip-rule="evenodd" />
                <path d="M12.454 16.697L9.75 13.992a4 4 0 01-3.742-3.741L2.335 6.578A9.98 9.98 0 00.458 10c1.274 4.057 5.065 7 9.542 7 .847 0 1.669-.105 2.454-.303z" />
              </svg>
            </button>
          </div>
          
          <!-- Password Strength Meter -->
          <div class="password-strength-meter mt-2">
            <div class="password-strength-meter-fill"></div>
          </div>
          <div class="mt-1 flex justify-between">
            <span id="password-strength-text" class="text-xs text-gray-500 dark:text-gray-400">Kekuatan kata sandi</span>
            <#if messagesPerField.existsError('password', 'password-confirm')>
              <span class="text-xs text-red-500">${kcSanitize(messagesPerField.getFirstError('password', 'password-confirm'))?no_esc}</span>
            </#if>
          </div>
          
          <!-- Password Requirements -->
          <div class="mt-2">
            <ul class="text-xs text-gray-500 dark:text-gray-400 space-y-1">
              <li class="flex items-center" id="length-requirement">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3 mr-1 requirement-icon" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                </svg>
                Minimal 8 karakter
              </li>
              <li class="flex items-center" id="case-requirement">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3 mr-1 requirement-icon" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                </svg>
                Berisi huruf besar & kecil
              </li>
              <li class="flex items-center" id="special-requirement">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3 mr-1 requirement-icon" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                </svg>
                Berisi angka & karakter khusus
              </li>
            </ul>
          </div>
        </div>
        
        <!-- Confirm Password Field -->
        <div class="mb-6">
          <label for="password-confirm" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Konfirmasi Kata Sandi <span class="text-red-500">*</span>
          </label>
          <div class="relative">
            <input 
              type="password" 
              id="password-confirm" 
              name="password-confirm" 
              class="w-full px-4 py-3 rounded-lg border ${messagesPerField.existsError('password-confirm')?then('border-red-500 dark:border-red-400', 'border-gray-300 dark:border-gray-600')} bg-white dark:bg-gray-800 text-gray-800 dark:text-white placeholder-gray-400 focus:border-green-500 dark:focus:border-yellow-500 focus:ring-green-500 dark:focus:ring-yellow-500 focus:outline-none focus:ring-2 focus:ring-opacity-30 transition-colors input-focus-effect" 
              autocomplete="new-password" 
              aria-invalid="${messagesPerField.existsError('password-confirm')?string('true', 'false')}"
              required
            />
            <button type="button" class="toggle-password absolute inset-y-0 right-0 pr-3 flex items-center text-sm leading-5 text-gray-500 dark:text-gray-400" data-target="#password-confirm">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 show-password" viewBox="0 0 20 20" fill="currentColor">
                <path d="M10 12a2 2 0 100-4 2 2 0 000 4z" />
                <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd" />
              </svg>
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 hide-password hidden" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M3.707 2.293a1 1 0 00-1.414 1.414l14 14a1 1 0 001.414-1.414l-1.473-1.473A10.014 10.014 0 0019.542 10C18.268 5.943 14.478 3 10 3a9.958 9.958 0 00-4.512 1.074l-1.78-1.781zm4.261 4.26l1.514 1.515a2.003 2.003 0 012.45 2.45l1.514 1.514a4 4 0 00-5.478-5.478z" clip-rule="evenodd" />
                <path d="M12.454 16.697L9.75 13.992a4 4 0 01-3.742-3.741L2.335 6.578A9.98 9.98 0 00.458 10c1.274 4.057 5.065 7 9.542 7 .847 0 1.669-.105 2.454-.303z" />
              </svg>
            </button>
          </div>
          <div id="password-match-message" class="mt-1 text-xs text-red-500 hidden">
            Kata sandi tidak cocok. Silakan periksa kembali.
          </div>
          <#if messagesPerField.existsError('password-confirm')>
            <div class="mt-1">
              <span class="text-xs text-red-500">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
            </div>
          </#if>
        </div>
        
        <!-- Logout All Sessions Checkbox (if app initiated action) -->
        <#if isAppInitiatedAction??>
          <div class="mb-6">
            <label class="flex items-center">
              <input 
                type="checkbox" 
                id="logout-sessions" 
                name="logout-sessions" 
                value="on" 
                checked 
                class="rounded border-gray-300 text-green-600 dark:text-yellow-600 shadow-sm focus:border-green-300 dark:focus:border-yellow-300 focus:ring focus:ring-green-200 dark:focus:ring-yellow-200 focus:ring-opacity-50 dark:bg-gray-700"
              />
              <span class="ml-2 text-sm text-gray-700 dark:text-gray-300">
                Keluar dari semua sesi lain
              </span>
            </label>
          </div>
        </#if>
      
        <!-- Form Buttons -->
        <div class="flex flex-col sm:flex-row gap-4 mt-8">
          <#if isAppInitiatedAction??>
            <button
              type="submit"
              class="w-full inline-flex justify-center items-center px-4 py-3 border border-transparent rounded-md shadow-sm text-base font-medium text-white bg-green-700 hover:bg-green-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors duration-300 dark:bg-yellow-600 dark:hover:bg-yellow-700 dark:focus:ring-yellow-500"
            >
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
              </svg>
              Simpan
            </button>
            <button
              type="submit"
              name="cancel-aia"
              value="true"
              class="w-full inline-flex justify-center items-center px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm text-base font-medium text-gray-700 dark:text-gray-200 bg-white dark:bg-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 dark:focus:ring-yellow-500 transition-colors duration-300"
            >
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
              Batal
            </button>
          <#else>
            <button 
              type="submit" 
              class="w-full inline-flex justify-center items-center px-4 py-3 border border-transparent rounded-md shadow-sm text-base font-medium text-white bg-green-700 hover:bg-green-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors duration-300 dark:bg-yellow-600 dark:hover:bg-yellow-700 dark:focus:ring-yellow-500"
            >
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
              </svg>
              Simpan
            </button>
          </#if>
        </div>
      </form>
    </div>
  </#if>
</@layout.registrationLayout>

<script>
  // Password strength indicator functionality
  const passwordInput = document.getElementById('password-new');
  const confirmPasswordInput = document.getElementById('password-confirm');
  const strengthMeter = document.querySelector('.password-strength-meter-fill');
  const strengthText = document.getElementById('password-strength-text');
  const passwordMatchMessage = document.getElementById('password-match-message');
  const requirementIcons = document.querySelectorAll('.requirement-icon');
  
  // Password requirements check
  function checkPasswordRequirements(password) {
    const hasLength = password.length >= 8;
    const hasUpperCase = /[A-Z]/.test(password);
    const hasLowerCase = /[a-z]/.test(password);
    const hasNumber = /\d/.test(password);
    const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
    
    // Update requirement icons
    document.getElementById('length-requirement').classList.toggle('text-green-500', hasLength);
    document.getElementById('case-requirement').classList.toggle('text-green-500', hasUpperCase && hasLowerCase);
    document.getElementById('special-requirement').classList.toggle('text-green-500', hasNumber && hasSpecialChar);
    
    return {
      hasLength,
      hasUpperCase,
      hasLowerCase,
      hasNumber,
      hasSpecialChar
    };
  }
  
  // Password strength calculation
  function calculatePasswordStrength(password) {
    const requirements = checkPasswordRequirements(password);
    let strength = 0;
    
    if (requirements.hasLength) strength += 1;
    if (requirements.hasUpperCase && requirements.hasLowerCase) strength += 1;
    if (requirements.hasNumber) strength += 1;
    if (requirements.hasSpecialChar) strength += 1;
    
    return strength;
  }
  
  // Update password strength meter
  function updatePasswordStrength(password) {
    const strength = calculatePasswordStrength(password);
    
    if (strengthMeter) {
      strengthMeter.className = 'password-strength-meter-fill';
      if (strength === 0) {
        strengthMeter.classList.add('weak');
        if (strengthText) strengthText.textContent = 'Sangat Lemah';
      } else if (strength === 1) {
        strengthMeter.classList.add('weak');
        if (strengthText) strengthText.textContent = 'Lemah';
      } else if (strength === 2) {
        strengthMeter.classList.add('medium');
        if (strengthText) strengthText.textContent = 'Sedang';
      } else if (strength === 3) {
        strengthMeter.classList.add('strong');
        if (strengthText) strengthText.textContent = 'Kuat';
      } else {
        strengthMeter.classList.add('very-strong');
        if (strengthText) strengthText.textContent = 'Sangat Kuat';
      }
    }
  }
  
  // Check password match
  function checkPasswordMatch() {
    const password = passwordInput.value;
    const confirmPassword = confirmPasswordInput.value;
    
    if (confirmPassword && password !== confirmPassword) {
      passwordMatchMessage.classList.remove('hidden');
      confirmPasswordInput.classList.add('border-red-500');
    } else {
      passwordMatchMessage.classList.add('hidden');
      confirmPasswordInput.classList.remove('border-red-500');
    }
  }
  
  // Event listeners
  if (passwordInput) {
    passwordInput.addEventListener('input', function() {
      updatePasswordStrength(this.value);
    });
  }
  
  if (confirmPasswordInput) {
    confirmPasswordInput.addEventListener('input', checkPasswordMatch);
  }
  
  // Toggle password visibility
  const togglePasswordButtons = document.querySelectorAll('.toggle-password');
  togglePasswordButtons.forEach(button => {
    button.addEventListener('click', function() {
      const input = document.querySelector(this.getAttribute('data-target'));
      const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
      input.setAttribute('type', type);
      
      const showIcon = this.querySelector('.show-password');
      const hideIcon = this.querySelector('.hide-password');
      
      if (showIcon) showIcon.classList.toggle('hidden');
      if (hideIcon) hideIcon.classList.toggle('hidden');
    });
  });
</script>