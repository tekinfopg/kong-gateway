<#import "template.ftl" as layout>

<@layout.registrationLayout
  displayInfo=true
  displayMessage=!messagesPerField.existsError("username")
  ;
  section
>
  <#if section="form">
    <div class="text-center mb-6">
      <h2 class="text-2xl font-bold text-gray-800 dark:text-gray-100 mb-1">Lupa Kata Sandi</h2>
      <p class="text-sm text-gray-600 dark:text-gray-300">Masukkan email atau username Anda untuk mereset kata sandi</p>
    </div>
    
    <form action="${url.loginAction}" method="post" class="space-y-4" onsubmit="return handleSubmit(event)">
      <div class="space-y-2">
        <label for="username" class="block text-sm font-medium text-gray-700 dark:text-gray-300">
          <#if realm.loginWithEmailAllowed>Email<#else>Username</#if>
        </label>
        <div class="relative">
          <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 dark:text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <#if realm.loginWithEmailAllowed>
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207" />
              <#else>
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
              </#if>
            </svg>
          </div>
          <input 
            type="text" 
            id="username" 
            name="username" 
            autocomplete="${realm.loginWithEmailAllowed?string("email", "username")}" 
            autofocus="true" 
            value="${(auth?has_content && auth.showUsername())?then(auth.attemptedUsername, '')}"
            class="input-focus-effect w-full pl-10 pr-4 py-2 border rounded-lg text-gray-700 dark:text-gray-300 bg-white dark:bg-gray-800 border-gray-300 dark:border-gray-700 focus:outline-none focus:ring-2 focus:ring-green-500 dark:focus:ring-green-600 transition-all ${messagesPerField.existsError("username")?then('border-red-500 dark:border-red-500', '')}"
          />
        </div>
        <#if messagesPerField.existsError("username")>
          <p class="text-sm text-red-600 dark:text-red-400 mt-1">
            ${kcSanitize(messagesPerField.get("username"))?no_esc}
          </p>
        </#if>
      </div>
      
      <div class="flex flex-col space-y-4">
        <button 
          type="submit" 
          class="w-full py-2 px-4 bg-green-700 hover:bg-green-800 dark:bg-green-600 dark:hover:bg-green-700 text-white font-medium rounded-lg transition-colors duration-300 shadow-md hover:shadow-lg flex items-center justify-center"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
          </svg>
          Kirim Link Reset
        </button>
        
        <a 
          href="${url.loginUrl}" 
          class="text-center py-2 px-4 bg-transparent border border-gray-300 dark:border-gray-600 hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-700 dark:text-gray-300 font-medium rounded-lg transition-colors duration-300 flex items-center justify-center"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 17l-5-5m0 0l5-5m-5 5h12" />
          </svg>
          Kembali ke Login
        </a>
      </div>
    </form>
  <#elseif section="info">
    <div class="mt-6 p-4 bg-blue-50 dark:bg-blue-900/30 border border-blue-200 dark:border-blue-800 rounded-lg text-blue-800 dark:text-blue-300">
      <div class="flex">
        <div class="flex-shrink-0">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
        </div>
        <div class="ml-3">
          <p class="text-sm">
            Kami akan mengirimkan petunjuk untuk mengatur ulang kata sandi ke email yang terdaftar. Silakan periksa kotak masuk dan folder spam Anda.
          </p>
        </div>
      </div>
    </div>
  </#if>
</@layout.registrationLayout>

<script>
  function handleSubmit(event) {
    // Simulate email sending failure (you can remove this in production)
    const shouldFail = false; // Set to true to test failure case
    
    if (shouldFail) {
      event.preventDefault();
      
      // Show error message
      const errorDiv = document.createElement('div');
      errorDiv.className = 'mt-4 p-4 bg-red-50 dark:bg-red-900/30 border border-red-200 dark:border-red-800 rounded-lg text-red-800 dark:text-red-300';
      errorDiv.innerHTML = `
        <div class="flex">
          <div class="flex-shrink-0">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
          <div class="ml-3">
            <p class="text-sm">
              Gagal mengirim email. Silakan coba lagi nanti.
            </p>
          </div>
        </div>
      `;
      
      // Insert error message after the form
      const form = event.target;
      form.parentNode.insertBefore(errorDiv, form.nextSibling);
      
      // Redirect to login page after 3 seconds
      setTimeout(() => {
        window.location.href = '${url.loginUrl}';
      }, 3000);
      
      return false;
    }
    
    return true;
  }
</script>