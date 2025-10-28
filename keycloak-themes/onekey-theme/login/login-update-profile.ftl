<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','email','firstName','lastName') displayInfo=realm.registrationEmailAsUsername; section>
    <#if section = "header">
        ${msg("loginProfileTitle")}
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
                    Mohon lengkapi informasi profil Anda untuk melanjutkan ke sistem
                </p>
            </div>
            
            <!-- Profile Update Form -->
            <form id="kc-update-profile-form" class="space-y-4" action="${url.loginAction}" method="post">
                <!-- Standard User Fields Section -->
                <div class="space-y-4">
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4 border-b border-gray-200 dark:border-gray-700 pb-2">
                        <svg class="w-5 h-5 inline-block mr-2 text-primary dark:text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                        Informasi Dasar
                    </h3>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <!-- First Name Field -->
                        <div class="form-group">
                            <label for="firstName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                                ${msg("firstName")} <span class="text-red-500">*</span>
                            </label>
                            <div class="relative">
                                <input type="text" id="firstName" name="firstName" value="${(user.firstName!'')}" 
                                       class="input-modern w-full px-4 py-3 text-sm rounded-lg focus:outline-none transition-all duration-300 
                                              <#if messagesPerField.existsError('firstName')>border-red-500 bg-red-50 dark:bg-red-900/20<#else>border-gray-300 dark:border-gray-600</#if>"
                                       placeholder="Masukkan nama depan Anda"
                                       required aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>">
                                <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                                    <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                    </svg>
                                </div>
                            </div>
                            <#if messagesPerField.existsError('firstName')>
                                <div class="mt-2 text-sm text-red-600 dark:text-red-400 flex items-center">
                                    <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                                    </svg>
                                    ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                                </div>
                            </#if>
                        </div>

                        <!-- Last Name Field -->
                        <div class="form-group">
                            <label for="lastName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                                ${msg("lastName")} <span class="text-red-500">*</span>
                            </label>
                            <div class="relative">
                                <input type="text" id="lastName" name="lastName" value="${(user.lastName!'')}" 
                                       class="input-modern w-full px-4 py-3 text-sm rounded-lg focus:outline-none transition-all duration-300 
                                              <#if messagesPerField.existsError('lastName')>border-red-500 bg-red-50 dark:bg-red-900/20<#else>border-gray-300 dark:border-gray-600</#if>"
                                       placeholder="Masukkan nama belakang Anda"
                                       required aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>">
                                <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                                    <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                    </svg>
                                </div>
                            </div>
                            <#if messagesPerField.existsError('lastName')>
                                <div class="mt-2 text-sm text-red-600 dark:text-red-400 flex items-center">
                                    <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                                    </svg>
                                    ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                                </div>
                            </#if>
                        </div>
                    </div>

                    <#if user.editUsernameAllowed>
                        <!-- Username Field -->
                        <div class="form-group">
                            <label for="username" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                                <#if !realm.registrationEmailAsUsername>
                                    ${msg("username")} <span class="text-red-500">*</span>
                                <#else>
                                    ${msg("email")} <span class="text-red-500">*</span>
                                </#if>
                            </label>
                            <div class="relative">
                                <input type="text" id="username" name="username" value="${(user.username!'')}" 
                                       class="input-modern w-full px-4 py-3 text-sm rounded-lg focus:outline-none transition-all duration-300 
                                              <#if messagesPerField.existsError('username')>border-red-500 bg-red-50 dark:bg-red-900/20<#else>border-gray-300 dark:border-gray-600</#if>"
                                       placeholder="<#if !realm.registrationEmailAsUsername>Masukkan username Anda<#else>Masukkan email Anda</#if>"
                                       required aria-invalid="<#if messagesPerField.existsError('username')>true</#if>">
                                <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                                    <#if !realm.registrationEmailAsUsername>
                                        <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                        </svg>
                                    <#else>
                                        <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 4.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                                        </svg>
                                    </#if>
                                </div>
                            </div>
                            <#if messagesPerField.existsError('username')>
                                <div class="mt-2 text-sm text-red-600 dark:text-red-400 flex items-center">
                                    <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                                    </svg>
                                    ${kcSanitize(messagesPerField.get('username'))?no_esc}
                                </div>
                            </#if>
                        </div>
                    </#if>

                    <#if user.editEmailAllowed>
                        <!-- Email Field -->
                        <div class="form-group">
                            <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                                ${msg("email")} <span class="text-red-500">*</span>
                            </label>
                            <div class="relative">
                                <input type="email" id="email" name="email" value="${(user.email!'')}" 
                                       class="input-modern w-full px-4 py-3 text-sm rounded-lg focus:outline-none transition-all duration-300 
                                              <#if messagesPerField.existsError('email')>border-red-500 bg-red-50 dark:bg-red-900/20<#else>border-gray-300 dark:border-gray-600</#if>"
                                       placeholder="Masukkan alamat email Anda"
                                       required aria-invalid="<#if messagesPerField.existsError('email')>true</#if>">
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
                </div>

                <!-- Dynamic User Attributes Section -->
                <#if profile?? && profile.attributes??>
                    <div class="space-y-4">
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4 border-b border-gray-200 dark:border-gray-700 pb-2">
                            <svg class="w-5 h-5 inline-block mr-2 text-primary dark:text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                            Informasi Tambahan
                        </h3>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <#list profile.attributes as attribute>
                                <#if attribute.name != "firstName" && attribute.name != "lastName" && attribute.name != "email" && attribute.name != "username">
                                    <div class="form-group">
                                        <label for="user.attributes.${attribute.name}" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                                            <#if attribute.displayName??>
                                                ${attribute.displayName}
                                            <#else>
                                                <#assign labelText = attribute.name?replace("_", " ")?replace("-", " ")?cap_first>
                                                ${labelText}
                                            </#if>
                                            <#if attribute.required?? && attribute.required>
                                                <span class="text-red-500">*</span>
                                            </#if>
                                        </label>
                                        <div class="relative">
                                            <#if attribute.name?contains("phone") || attribute.name?contains("telephone") || attribute.name?contains("mobile")>
                                                <input type="tel" 
                                                       id="user.attributes.${attribute.name}" 
                                                       name="user.attributes.${attribute.name}" 
                                                       value="${(user.attributes[attribute.name]!'')}"
                                                       class="input-modern w-full px-4 py-3 text-sm rounded-lg focus:outline-none transition-all duration-300 
                                                              <#if messagesPerField.existsError('user.attributes.' + attribute.name)>border-red-500 bg-red-50 dark:bg-red-900/20<#else>border-gray-300 dark:border-gray-600</#if>"
                                                       placeholder="Masukkan nomor telepon"
                                                       <#if attribute.required?? && attribute.required>required</#if>
                                                       aria-invalid="<#if messagesPerField.existsError('user.attributes.' + attribute.name)>true</#if>">
                                            <#elseif attribute.name?contains("email")>
                                                <input type="email" 
                                                       id="user.attributes.${attribute.name}" 
                                                       name="user.attributes.${attribute.name}" 
                                                       value="${(user.attributes[attribute.name]!'')}"
                                                       class="input-modern w-full px-4 py-3 text-sm rounded-lg focus:outline-none transition-all duration-300 
                                                              <#if messagesPerField.existsError('user.attributes.' + attribute.name)>border-red-500 bg-red-50 dark:bg-red-900/20<#else>border-gray-300 dark:border-gray-600</#if>"
                                                       placeholder="Masukkan alamat email"
                                                       <#if attribute.required?? && attribute.required>required</#if>
                                                       aria-invalid="<#if messagesPerField.existsError('user.attributes.' + attribute.name)>true</#if>">
                                            <#elseif attribute.name?contains("date") || attribute.name?contains("birth")>
                                                <input type="date" 
                                                       id="user.attributes.${attribute.name}" 
                                                       name="user.attributes.${attribute.name}" 
                                                       value="${(user.attributes[attribute.name]!'')}"
                                                       class="input-modern w-full px-4 py-3 text-sm rounded-lg focus:outline-none transition-all duration-300 
                                                              <#if messagesPerField.existsError('user.attributes.' + attribute.name)>border-red-500 bg-red-50 dark:bg-red-900/20<#else>border-gray-300 dark:border-gray-600</#if>"
                                                       <#if attribute.required?? && attribute.required>required</#if>
                                                       aria-invalid="<#if messagesPerField.existsError('user.attributes.' + attribute.name)>true</#if>">
                                            <#else>
                                                <input type="text" 
                                                       id="user.attributes.${attribute.name}" 
                                                       name="user.attributes.${attribute.name}" 
                                                       value="${(user.attributes[attribute.name]!'')}"
                                                       class="input-modern w-full px-4 py-3 text-sm rounded-lg focus:outline-none transition-all duration-300 
                                                              <#if messagesPerField.existsError('user.attributes.' + attribute.name)>border-red-500 bg-red-50 dark:bg-red-900/20<#else>border-gray-300 dark:border-gray-600</#if>"
                                                       placeholder="Masukkan nilai"
                                                       <#if attribute.required?? && attribute.required>required</#if>
                                                       aria-invalid="<#if messagesPerField.existsError('user.attributes.' + attribute.name)>true</#if>">
                                            </#if>
                                        </div>
                                        <#if messagesPerField.existsError('user.attributes.' + attribute.name)>
                                            <div class="mt-2 text-sm text-red-600 dark:text-red-400 flex items-center">
                                                <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                                                </svg>
                                                ${kcSanitize(messagesPerField.get('user.attributes.' + attribute.name))?no_esc}
                                            </div>
                                        </#if>
                                    </div>
                                </#if>
                            </#list>
                        </div>
                    </div>
                </#if>

                <!-- Action Buttons -->
                <div class="flex flex-col sm:flex-row gap-4 pt-4">
                    <button type="submit" name="submitAction" value="Save" 
                            class="btn-primary flex-1 w-full px-6 py-3 text-sm font-medium text-white rounded-lg 
                                   hover:shadow-lg focus:outline-none focus:ring-2 focus:ring-primary/50 
                                   transition-all duration-300 transform hover:-translate-y-0.5">
                        <div class="flex items-center justify-center space-x-2">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                            </svg>
                            <span>Perbarui Profil</span>
                        </div>
                    </button>
                    
                    <#if url.loginRestartFlowUrl??>
                        <a href="${url.loginRestartFlowUrl}" 
                           class="flex-1 w-full px-6 py-3 text-sm font-medium text-gray-700 dark:text-gray-300 
                                  bg-gray-100 dark:bg-gray-700 border border-gray-300 dark:border-gray-600 
                                  rounded-lg hover:bg-gray-50 dark:hover:bg-gray-600 focus:outline-none 
                                  focus:ring-2 focus:ring-gray-500/50 transition-all duration-300 text-center">
                            <div class="flex items-center justify-center space-x-2">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                                </svg>
                                <span>Kembali ke Login</span>
                            </div>
                        </a>
                    </#if>
                </div>
            </form>

            <!-- Additional Information -->
            <div class="mt-8 p-4 bg-gray-50 dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700">
                <h4 class="text-sm font-medium text-gray-900 dark:text-white mb-2 flex items-center">
                    <svg class="w-4 h-4 text-primary dark:text-secondary mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                    </svg>
                    Informasi Profil
                </h4>
                <ul class="text-xs text-gray-600 dark:text-gray-400 space-y-1">
                    <li class="flex items-start">
                        <span class="text-primary dark:text-secondary mr-2">•</span>
                        <span>Semua field yang ditandai dengan (*) wajib diisi</span>
                    </li>
                    <li class="flex items-start">
                        <span class="text-primary dark:text-secondary mr-2">•</span>
                        <span>Data Anda akan dienkripsi dan dilindungi dengan standar keamanan tinggi</span>
                    </li>
                </ul>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
