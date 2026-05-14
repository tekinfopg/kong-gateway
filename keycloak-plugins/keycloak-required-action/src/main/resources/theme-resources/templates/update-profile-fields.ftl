<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global'); section>
    <#if section = "header">
        ${msg("updateProfileTitle","Lengkapi Profil Anda")}
    <#elseif section = "form">
        <div class="space-y-6">
            <!-- Header Section -->
            <div class="text-center">
                <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-primary/10 dark:bg-secondary/10 mb-4">
                    <svg class="h-6 w-6 text-primary dark:text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                    </svg>
                </div>
                <h2 class="text-2xl font-bold text-gray-900 dark:text-white font-poppins">
                    Lengkapi Profil Anda
                </h2>
                <p class="mt-2 text-sm text-gray-600 dark:text-gray-400">
                    Mohon lengkapi data berikut untuk melanjutkan
                </p>
            </div>

            <form id="kc-update-profile-fields-form" class="space-y-4" action="${url.loginAction}" method="post">

                <#if showEmail>
                    <!-- Email Field -->
                    <div class="form-group">
                        <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                            ${msg("email","Email")} <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <input type="email"
                                   id="email"
                                   name="email"
                                   value="${(currentEmail!'')}"
                                   class="input-modern w-full px-4 py-3 text-sm rounded-lg focus:outline-none transition-all duration-300 <#if messagesPerField.existsError('email')>border-red-500 bg-red-50 dark:bg-red-900/20<#else>border-gray-300 dark:border-gray-600</#if>"
                                   placeholder="Masukkan alamat email Anda"
                                   autocomplete="email"
                                   autofocus
                                   required
                                   aria-invalid="<#if messagesPerField.existsError('email')>true</#if>">
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                                <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 4.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                                </svg>
                            </div>
                        </div>
                        <#if messagesPerField.existsError('email')>
                            <div class="mt-2 text-sm text-red-600 dark:text-red-400 flex items-center">
                                <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                                </svg>
                                ${kcSanitize(messagesPerField.get('email'))?no_esc}
                            </div>
                        </#if>
                    </div>
                </#if>

                <#if showPhone>
                    <!-- Phone Number Field -->
                    <div class="form-group">
                        <label for="phoneNumber" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                            ${msg("phoneNumber","Phone Number")} <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <input type="tel"
                                   id="phoneNumber"
                                   name="phoneNumber"
                                   value="${(currentPhone!'')}"
                                   class="input-modern w-full px-4 py-3 text-sm rounded-lg focus:outline-none transition-all duration-300 <#if messagesPerField.existsError('phoneNumber')>border-red-500 bg-red-50 dark:bg-red-900/20<#else>border-gray-300 dark:border-gray-600</#if>"
                                   placeholder="+628xxxxxxxxxx"
                                   autocomplete="tel"
                                   required
                                   aria-invalid="<#if messagesPerField.existsError('phoneNumber')>true</#if>">
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                                <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
                                </svg>
                            </div>
                        </div>
                        <#if messagesPerField.existsError('phoneNumber')>
                            <div class="mt-2 text-sm text-red-600 dark:text-red-400 flex items-center">
                                <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                                </svg>
                                ${kcSanitize(messagesPerField.get('phoneNumber'))?no_esc}
                            </div>
                        </#if>
                    </div>
                </#if>

                <!-- Action Button -->
                <div class="flex flex-col sm:flex-row gap-4 pt-4">
                    <button type="submit"
                            class="flex-1 w-full px-6 py-3 text-sm font-medium text-white rounded-lg bg-secondary hover:bg-secondary/90 dark:bg-accent dark:hover:bg-accent/90 shadow hover:shadow-lg focus:outline-none focus:ring-2 focus:ring-secondary/50 transition-all duration-300 transform hover:-translate-y-0.5">
                        <div class="flex items-center justify-center space-x-2">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                            </svg>
                            <span>${msg("doSubmit","Simpan")}</span>
                        </div>
                    </button>
                </div>
            </form>

            <!-- Additional Information -->
            <div class="mt-8 p-4 bg-gray-50 dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700">
                <h4 class="text-sm font-medium text-gray-900 dark:text-white mb-2 flex items-center">
                    <svg class="w-4 h-4 text-primary dark:text-secondary mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                    </svg>
                    Informasi
                </h4>
                <ul class="text-xs text-gray-600 dark:text-gray-400 space-y-1">
                    <li class="flex items-start">
                        <span class="text-primary dark:text-secondary mr-2">•</span>
                        <span>Field bertanda (*) wajib diisi</span>
                    </li>
                    <li class="flex items-start">
                        <span class="text-primary dark:text-secondary mr-2">•</span>
                        <span>Data Anda dilindungi dengan standar keamanan tinggi</span>
                    </li>
                </ul>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
