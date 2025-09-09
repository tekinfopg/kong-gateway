<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html>
<html lang="id" class="light">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${msg("loginTitle", (realm.displayName!''))}</title>
  <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" type="image/x-icon" />
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <!-- Tailwind CSS CDN -->
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    // Tailwind custom configuration
    tailwind.config = {
      darkMode: 'class',
      theme: {
        extend: {
          fontFamily: {
            sans: ['Inter', 'sans-serif'],
            poppins: ['Poppins', 'sans-serif']
          },
          colors: {
            'primary': '#0F172A',
            'secondary': '#2e8b57', // Ubah warna biru menjadi hijau
            'accent': '#F59E0B',
            'green': {
              700: '#2e8b57'
            },
            background: {
              light: '#f8fafc',
              dark: '#0F172A'
            }
          },
          animation: {
            float: 'float 6s ease-in-out infinite',
            pulse: 'pulse 3s infinite ease-in-out',
            'pulse-slow': 'pulse 6s infinite ease-in-out',
            fadeIn: 'fadeIn 0.5s ease-in-out',
            blob: 'blob 7s infinite',
            'blob-slow': 'blob 10s infinite'
          },
          keyframes: {
            float: {
              '0%, 100%': { transform: 'translateY(0)' },
              '50%': { transform: 'translateY(-10px)' }
            },
            fadeIn: {
              '0%': { opacity: '0' },
              '100%': { opacity: '1' }
            },
            blob: {
              '0%': {
                transform: 'translate(0px, 0px) scale(1)'
              },
              '33%': {
                transform: 'translate(30px, -50px) scale(1.1)'
              },
              '66%': {
                transform: 'translate(-20px, 20px) scale(0.9)'
              },
              '100%': {
                transform: 'translate(0px, 0px) scale(1)'
              }
            }
          }
        }
      }
    }
  </script>
  <style>
    body {
      font-family: 'Inter', sans-serif;
    }
    .glass-effect {
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.18);
      box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.1);
    }
    .dark .glass-effect {
      background: rgba(15, 23, 42, 0.3);
      border: 1px solid rgba(255, 255, 255, 0.08);
    }
    .input-focus-effect {
      transition: all 0.3s ease;
      border: 1px solid transparent;
    }
    .input-focus-effect:focus {
      box-shadow: 0 0 0 3px rgba(46, 139, 87, 0.3); /* Ubah dari rgba(59, 130, 246, 0.3) ke rgba(46, 139, 87, 0.3) */
    }
    .dark .input-focus-effect:focus {
      box-shadow: 0 0 0 3px rgba(245, 158, 11, 0.3);
    }
    .tooltip {
      position: relative;
    }
    .tooltip:hover .tooltip-text {
      visibility: visible;
      opacity: 1;
    }
    .tooltip-text {
      visibility: hidden;
      opacity: 0;
      width: 200px;
      background-color: rgba(15, 23, 42, 0.9);
      color: #fff;
      text-align: center;
      border-radius: 6px;
      padding: 8px;
      position: absolute;
      z-index: 1;
      bottom: 125%;
      left: 50%;
      margin-left: -100px;
      transition: opacity 0.3s;
    }
    .tooltip-text::after {
      content: "";
      position: absolute;
      top: 100%;
      left: 50%;
      margin-left: -5px;
      border-width: 5px;
      border-style: solid;
      border-color: rgba(15, 23, 42, 0.9) transparent transparent transparent;
    }
    .dark .tooltip-text {
      background-color: rgba(245, 158, 11, 0.9);
    }
    .dark .tooltip-text::after {
      border-color: rgba(245, 158, 11, 0.9) transparent transparent transparent;
    }
    
    /* Password strength indicator */
    .password-strength-meter {
      height: 4px;
      width: 100%;
      background: #ddd;
      border-radius: 2px;
      margin-top: 6px;
    }
    .password-strength-meter-fill {
      height: 100%;
      border-radius: 2px;
      transition: width 0.3s ease;
    }
    .password-strength-meter-fill.weak { width: 25%; background: #f44336; }
    .password-strength-meter-fill.medium { width: 50%; background: #ff9800; }
    .password-strength-meter-fill.strong { width: 75%; background: #4caf50; }
    .password-strength-meter-fill.very-strong { width: 100%; background: #2e7d32; }
    
    .dark .password-strength-meter { background: #334155; }
    
    /* Video background */
    .video-bg {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
      opacity: 0.5;
    }
    
    /* Floating badges animation */
    .floating-badge {
      animation: float 6s ease-in-out infinite;
    }
    .floating-badge:nth-child(2) { animation-delay: 1s; }
    .floating-badge:nth-child(3) { animation-delay: 2s; }
    .floating-badge:nth-child(4) { animation-delay: 3s; }
    .floating-badge:nth-child(5) { animation-delay: 4s; }
    
    /* Interactive background effect */
    .bg-radial-gradient {
      background-image: radial-gradient(circle at 30% 70%, rgba(255, 215, 0, 0.12), transparent),
                        radial-gradient(circle at 70% 30%, rgba(46, 139, 87, 0.2), transparent);
    }
    
    /* Animated blob effects */
    .blob {
      border-radius: 50%;
      filter: blur(40px);
      opacity: 0.7;
      animation: blob 7s infinite;
    }
    
    .blob:nth-child(2) {
      animation-delay: 2s;
    }
    
    .blob:nth-child(3) {
      animation-delay: 4s;
    }
    
    /* Modal */
    .iso-modal {
      display: none;
      position: fixed;
      z-index: 100;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0, 0, 0, 0.7);
      animation: fadeIn 0.3s;
    }
    
    .iso-modal-content {
      margin: 5% auto;
      padding: 20px;
      max-width: 800px;
      position: relative;
      animation: scaleIn 0.3s;
    }
    
    .iso-close {
      position: absolute;
      top: 15px;
      right: 15px;
      color: white;
      font-size: 30px;
      font-weight: bold;
      cursor: pointer;
      z-index: 110;
      background-color: rgba(0, 0, 0, 0.5);
      width: 40px;
      height: 40px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    
    @keyframes scaleIn {
      from {transform: scale(0.95); opacity: 0;}
      to {transform: scale(1); opacity: 1;}
    }
      @keyframes pulse {
    0%, 100% {
      opacity: 1;
    }
    50% {
      opacity: 0;
    }
  }
  
  .pulse-cursor {
    display: inline-block;
    width: 2px;
    height: 50px;
    background-color: #ffffff;
    animation: pulse 1s infinite;
    margin-left: -10px;
    vertical-align: baseline;
  }
  input[type="radio"]:checked + label {
  background-color: rgba(34, 197, 94, 0.1);
}

  </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-950 dark:to-gray-900 text-gray-800 dark:text-gray-200 transition-colors duration-300">
      <style>
        body::-webkit-scrollbar {
            display: none;
        }
        html {
            scrollbar-width: none;
            -ms-overflow-style: none;
        }
        html::-webkit-scrollbar {
            display: none;
        }
    </style>
  <!-- Theme Toggle Button -->
  <button id="theme-toggle" class="fixed z-50 top-4 right-4 p-3 rounded-full bg-white/10 dark:bg-white/5 backdrop-blur-md hover:bg-white/20 dark:hover:bg-white/10 transition-colors shadow-lg">
    <!-- Icon for Dark Mode -->
    <svg id="light-icon" class="hidden dark:block w-5 h-5 text-amber-400" fill="currentColor" viewBox="0 0 20 20">
      <path d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" fill-rule="evenodd" clip-rule="evenodd"></path>
    </svg>
    <!-- Icon for Light Mode -->
    <svg id="dark-icon" class="block dark:hidden w-5 h-5 text-secondary" fill="currentColor" viewBox="0 0 20 20">
      <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"></path>
    </svg>
  </button>

  <!-- ISO27001 Certificate Modal -->
  <div id="iso-modal" class="iso-modal">
    <span class="iso-close">&times;</span>
    <div class="iso-modal-content">
      <img src="${url.resourcesPath}/img/open_ISO27001.png" alt="ISO 27001 Certificate" class="w-full rounded-lg shadow-lg">
    </div>
  </div>

  <!-- Interactive Background -->
  <div class="fixed inset-0 -z-10 bg-transparent overflow-hidden">
    <!-- Large sun effect -->
    <div class="w-96 h-96 sm:w-128 sm:h-128 md:w-156 md:h-156 lg:w-192 lg:h-192 
        absolute -top-48 -right-48 sm:-top-64 sm:-right-64 md:-top-72 md:-right-72
        rounded-full 
        bg-yellow-300/30
        dark:bg-yellow-500/20 
        blur-3xl
        animate-pulse-slow">
    </div>

    <!-- Secondary smaller glow -->
    <div class="w-48 h-48 sm:w-64 sm:h-64 md:w-80 md:h-80
        absolute -top-24 -right-24 sm:-top-32 sm:-right-32
        rounded-full 
        bg-yellow-200/40
        dark:bg-yellow-400/25
        blur-2xl
        animate-pulse">
    </div>

    <!-- Grid pattern -->
    <div class="absolute inset-0 bg-[linear-gradient(to_right,rgba(46,139,87,0.08)_1px,transparent_1px),linear-gradient(to_bottom,rgba(46,139,87,0.08)_1px,transparent_1px)] dark:bg-[linear-gradient(to_right,rgba(46,139,87,0.07)_1px,transparent_1px),linear-gradient(to_bottom,rgba(46,139,87,0.07)_1px,transparent_1px)] bg-[size:3rem_3rem]"></div>
    
    <!-- Gradient overlays -->
    <div class="absolute inset-0 bg-[radial-gradient(circle_1000px_at_70%_30%,rgba(46,139,87,0.15),transparent)] dark:bg-[radial-gradient(circle_1000px_at_70%_30%,rgba(46,139,87,0.2),transparent)]"></div>
    <div class="absolute inset-0 bg-[radial-gradient(circle_800px_at_30%_70%,rgba(255,215,0,0.08),transparent)] dark:bg-[radial-gradient(circle_800px_at_30%_70%,rgba(255,215,0,0.12),transparent)]"></div>
    <div class="absolute inset-0 bg-gradient-to-b from-transparent via-transparent to-gray-100/50 dark:to-gray-900/50"></div>
    
    <!-- Animated blobs -->
    <div class="absolute top-1/4 left-1/4 w-64 h-64 bg-green-400/20 dark:bg-green-700/20 rounded-full mix-blend-multiply filter blur-3xl opacity-70 animate-blob"></div>
    <div class="absolute top-1/3 right-1/4 w-72 h-72 bg-yellow-300/20 dark:bg-yellow-500/20 rounded-full mix-blend-multiply filter blur-3xl opacity-70 animate-blob animation-delay-2000"></div>
    <div class="absolute bottom-1/4 right-1/3 w-80 h-80 bg-blue-400/20 dark:bg-blue-600/20 rounded-full mix-blend-multiply filter blur-3xl opacity-70 animate-blob animation-delay-4000"></div>
  </div>

  <div class="flex min-h-screen">
    <!-- Left Panel - Branding & Video -->
    <div class="hidden lg:flex lg:flex-col lg:justify-center lg:w-1/2 fixed inset-y-0 left-0 bg-gradient-to-br from-primary to-primary/90 dark:from-accent dark:to-green-700 p-0 overflow-hidden relative rounded-3xl shadow-2xl m-3">
      <!-- App Logo - Top Left -->
      <div class="absolute top-6 left-6 z-10 transition-transform duration-300 hover:scale-105">
        <img src="${url.resourcesPath}/img/onekey-logo.png" alt="OneKey Logo" class="h-8 object-contain" />
      </div>
      
      <!-- Video Background -->
      <video autoplay muted loop class="video-bg">
        <source src="${url.resourcesPath}/img/Star background.mp4" type="video/mp4">
        <!-- Fallback if video doesn't load -->
        <div class="absolute inset-0 bg-gradient-to-b from-primary to-primary/70 dark:from-accent dark:to-accent/70"></div>
      </video>
      
      <!-- Content Overlay -->
      <div class="max-w-2xl mx-auto text-center text-white relative z-10 px-8 transition-all duration-500 hover:translate-y-[-5px]">
        <!-- Hero Section with Typing Animation -->
        <div class="mb-12">
<h1 class="text-2xl md:text-2xl lg:text-6xl font-bold mb-4">
            <span class="bg-clip-text text-transparent bg-gradient-to-r from-green-400 to-yellow-400 inline-block">
                OneKey
            </span>
            <br>
            <span class="text-white text-md" id="typing-text">
                untuk Semua Kebutuhan Anda
            </span>
            <span class="pulse-cursor hidden"></span>
            </h1>
            <p class="text-gray-200 max-w-lg mx-auto mt-4 text-sm">
            Platform single sign-on yang aman dan terintegrasi untuk semua aplikasi perusahaan Petrokimia Gresik dalam satu portal.
            </p>
        </div>
        
        <!-- Onekey Fitur Unggulan Section -->
        <div class="mt-5">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <!-- Fitur 1: Single Sign-On -->
            <div class="bg-white/10 backdrop-blur-sm rounded-xl p-4 border border-white/20 hover:border-white/40 transition-all duration-300 shadow-lg hover:shadow-white/20 hover:scale-105 group">
                <div class="w-12 h-12 rounded-full bg-white/20 flex items-center justify-center mb-3 group-hover:bg-white/30 transition-all duration-300">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-yellow-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 7a2 2 0 012 2m4 0a6 6 0 01-7.743 5.743L11 17H9v2H7v2H4a1 1 0 01-1-1v-2.586a1 1 0 01.293-.707l5.964-5.964A6 6 0 1121 9z" />
                </svg>
                </div>
                <h3 class="text-lg font-bold text-white mb-1 group-hover:text-yellow-400 transition-all duration-300">
                Single Sign-On
                </h3>
                <p class="text-gray-300 text-xs">
                Akses semua aplikasi dengan sekali login. OneKey mengintegrasikan semua aplikasi perusahaan dalam satu platform.
                </p>
            </div>
            
            <!-- Fitur 2: Keamanan Berlapis -->
            <div class="bg-white/10 backdrop-blur-sm rounded-xl p-4 border border-white/20 hover:border-white/40 transition-all duration-300 shadow-lg hover:shadow-white/20 hover:scale-105 group">
                <div class="w-12 h-12 rounded-full bg-white/20 flex items-center justify-center mb-3 group-hover:bg-white/30 transition-all duration-300">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-yellow-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                </svg>
                </div>
                <h3 class="text-lg font-bold text-white mb-1 group-hover:text-yellow-400 transition-all duration-300">
                Keamanan Berlapis
                </h3>
                <p class="text-gray-300 text-xs">
                Sistem keamanan berlapis dengan autentikasi dua faktor, enkripsi data, dan pemantauan aktivitas real-time.
                </p>
            </div>
            
            <!-- Fitur 3: Manajemen Akses -->
            <div class="bg-white/10 backdrop-blur-sm rounded-xl p-4 border border-white/20 hover:border-white/40 transition-all duration-300 shadow-lg hover:shadow-white/20 hover:scale-105 group">
                <div class="w-12 h-12 rounded-full bg-white/20 flex items-center justify-center mb-3 group-hover:bg-white/30 transition-all duration-300">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-yellow-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                </svg>
                </div>
                <h3 class="text-lg font-bold text-white mb-1 group-hover:text-yellow-400 transition-all duration-300">
                Manajemen Akses
                </h3>
                <p class="text-gray-300 text-xs">
                Kontrol penuh atas izin dan akses pengguna dengan manajemen peran yang fleksibel dan terperinci.
                </p>
            </div>
            </div>
        </div>
        </div>

        <!-- Company Badges -->
        <!-- Updated Desktop Company Badges -->
        <div class="mt-5 flex flex-wrap justify-center gap-6 absolute bottom-0 left-0 right-0 mx-auto w-full px-4 pb-4 z-20">
          <div class="bg-white/80 dark:bg-white/10 backdrop-blur-md rounded-3xl p-4 mx-auto max-w-lg shadow-lg border border-white/30 dark:border-white/10 transition-all duration-300 hover:shadow-xl">
            <div class="flex flex-wrap justify-center items-center gap-6">
              <!-- BUMN Badge -->
              <div class="badge-container group relative transition-all duration-300 hover:scale-110">
                <img src="${url.resourcesPath}/img/Danantara_Indonesia_Logo_vector (Color).png" alt="Danantara Indonesia" class="h-4 group-hover:brightness-110 dark:hidden" />
                <img src="${url.resourcesPath}/img/Danantara_Indonesia_Logo_vector (White).png" alt="Danantara Indonesia" class="h-4 group-hover:brightness-110 hidden dark:block" />
                <div class="badge-tooltip opacity-0 group-hover:opacity-100 absolute -top-12 left-1/2 transform -translate-x-1/2 bg-black/80 text-white text-xs px-3 py-1 rounded-lg transition-all duration-300 pointer-events-none w-32 text-center">
                  BUMN Indonesia
                </div>
              </div>
              
              <!-- PKG Badge -->
              <div class="badge-container group relative transition-all duration-300 hover:scale-110">
                <img src="${url.resourcesPath}/img/PKG.png" alt="Petrokimia Gresik" class="h-8 group-hover:brightness-110 dark:hidden" />
                <img src="${url.resourcesPath}/img/PKG-putih.png" alt="Petrokimia Gresik" class="h-8 group-hover:brightness-110 hidden dark:block" />
                <div class="badge-tooltip opacity-0 group-hover:opacity-100 absolute -top-12 left-1/2 transform -translate-x-1/2 bg-black/80 text-white text-xs px-3 py-1 rounded-lg transition-all duration-300 pointer-events-none w-32 text-center">
                  Petrokimia Gresik
                </div>
              </div>
              
              <!-- PI Badge -->
              <div class="badge-container group relative transition-all duration-300 hover:scale-110">
                <img src="${url.resourcesPath}/img/PI.png" alt="Pupuk Indonesia" class="h-8 group-hover:brightness-110 dark:hidden" />
                <img src="${url.resourcesPath}/img/PI-putih.png" alt="Pupuk Indonesia" class="h-8 group-hover:brightness-110 hidden dark:block" />
                <div class="badge-tooltip opacity-0 group-hover:opacity-100 absolute -top-12 left-1/2 transform -translate-x-1/2 bg-black/80 text-white text-xs px-3 py-1 rounded-lg transition-all duration-300 pointer-events-none w-32 text-center">
                  Pupuk Indonesia
                </div>
              </div>
              
              <!-- ISO 27001 Certificate Badge -->
              <div class="badge-container group relative transition-all duration-300 hover:scale-110">
                <div class="relative">
                  <img id="iso-badge" src="${url.resourcesPath}/img/ISO27001.png" alt="ISO 27001 Certified" class="rounded-xl h-10 group-hover:brightness-110 cursor-pointer border-2 border-transparent group-hover:border-green-500 dark:group-hover:border-yellow-500" />
                  <div class="absolute -top-2 -right-2 bg-green-500 dark:bg-yellow-500 text-white text-xs px-1 rounded-full hidden group-hover:block animate-pulse">
                    Ver
                  </div>
                </div>
                <div class="badge-tooltip opacity-0 group-hover:opacity-100 absolute -top-12 left-1/2 transform -translate-x-1/2 bg-black/80 text-white text-xs px-3 py-1 rounded-lg transition-all duration-300 pointer-events-none w-48 text-center">
                  Klik untuk melihat sertifikat ISO 27001
                </div>
              </div>
            </div>
          </div>
        </div>
    </div>

    <!-- Right Panel - Form -->
    <div class="w-full lg:w-1/2 lg:ml-auto flex items-center justify-center p-8">
      <div class="w-full max-w-md glass-effect dark:bg-opacity-20 p-8 rounded-2xl shadow-lg border border-gray-200 dark:border-gray-700 transition-all duration-300 relative animate-fadeIn hover:shadow-xl transform hover:-translate-y-1">
        <!-- Mobile Logo - Only visible on mobile -->
        <div class="flex justify-center mb-6 lg:hidden">
          <img src="${url.resourcesPath}/img/onekey-logo.png" alt="OneKey Logo" class="h-12 object-contain" />
        </div>
        
        <!-- Decorative Background in Top-Right Corner -->
        <div class="absolute top-0 right-0 w-1/2 h-1/3 pointer-events-none">
            <div class="absolute inset-0 bg-[radial-gradient(#d1d5db_1px,transparent_1px)] dark:bg-[radial-gradient(#52525b_1px,transparent_1px)] [background-size:16px_16px] [mask-image:radial-gradient(ellipse_40%_40%_at_90%_10%,#000_50%,transparent_100%)]"></div>
        </div>
        
        <!-- Decorative Background in Bottom-Left Corner -->
        <div class="absolute bottom-0 left-0 w-1/2 h-1/3 pointer-events-none">
            <div class="absolute inset-0 bg-[radial-gradient(#d1d5db_1px,transparent_1px)] dark:bg-[radial-gradient(#52525b_1px,transparent_1px)] [background-size:16px_16px] [mask-image:radial-gradient(ellipse_40%_40%_at_10%_90%,#000_50%,transparent_100%)]"></div>
        </div>
        
        <#if displayMessage && message?has_content>
          <div class="mb-6 p-4 rounded-lg bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300 animate-fadeIn">
            ${kcSanitize(message.summary)?no_esc}
          </div>
        </#if>

        <#nested "form">

        <#if displayInfo>
          <div class="mt-6">
            <#nested "info">
          </div>
        </#if>
      </div>
      <!-- Add mobile footer -->
      <div class="lg:hidden fixed bottom-0 left-0 right-0 w-full z-50">
        <div class="bg-white/90 dark:bg-gray-800/90 backdrop-blur-md rounded-t-xl p-2 shadow-lg border-t border-gray-200 dark:border-gray-700">
          <div class="flex flex-wrap justify-center items-center gap-2 overflow-x-auto py-1 scrollbar-hide" id="mobile-badges-container">
            <!-- BUMN Badge -->
            <div class="badge-container relative flex flex-col items-center min-w-max">
              <img src="${url.resourcesPath}/img/Danantara_Indonesia_Logo_vector (Color).png" alt="BUMN Indonesia" class="h-3 transition duration-300 hover:scale-110 dark:hidden" />
              <img src="${url.resourcesPath}/img/Danantara_Indonesia_Logo_vector (White).png" alt="BUMN Indonesia" class="h-3 transition duration-300 hover:scale-110 hidden dark:block" />
            </div>
            
            <!-- PKG Badge -->
            <div class="badge-container relative flex flex-col items-center min-w-max">
              <img src="${url.resourcesPath}/img/PKG.png" alt="Petrokimia Gresik" class="h-5 transition duration-300 hover:scale-110 dark:hidden" />
              <img src="${url.resourcesPath}/img/PKG-putih.png" alt="Petrokimia Gresik" class="h-5 transition duration-300 hover:scale-110 hidden dark:block" />
            </div>
            
            <!-- PI Badge -->
            <div class="badge-container relative flex flex-col items-center min-w-max">
              <img src="${url.resourcesPath}/img/PI.png" alt="PI" class="h-5 transition duration-300 hover:scale-110 dark:hidden" />
              <img src="${url.resourcesPath}/img/PI-putih.png" alt="PI" class="h-5 transition duration-300 hover:scale-110 hidden dark:block" />
            </div>
            
            <!-- ISO Badge -->
            <div class="badge-container relative flex flex-col items-center min-w-max animate-pulse-slow">
              <div class="relative">
                <img id="iso-badge-mobile" src="${url.resourcesPath}/img/ISO27001.jpg" alt="ISO 27001 Certified" class="rounded-xl h-6 transition duration-300 hover:scale-110 cursor-pointer border-2 border-transparent hover:border-green-500 dark:hover:border-yellow-500" />
                <div class="absolute -top-1 -right-1 w-2 h-2 bg-green-500 rounded-full"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <script>
    // Dark/Light Theme Toggle
    const themeToggle = document.getElementById('theme-toggle');
    const html = document.documentElement;
    
    // Use system preference by default
    if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
      html.classList.add('dark');
    } else {
      html.classList.remove('dark');
    }
    
    // Listen for system theme changes
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
      if (e.matches) {
        html.classList.add('dark');
      } else {
        html.classList.remove('dark');
      }
    });
    
    // Toggle theme with animation (only for manual override)
    themeToggle.addEventListener('click', () => {
      if (html.classList.contains('dark')) {
        html.classList.remove('dark');
        themeToggle.classList.add('rotate-180');
        setTimeout(() => {
          themeToggle.classList.remove('rotate-180');
        }, 300);
      } else {
        html.classList.add('dark');
        themeToggle.classList.add('rotate-180');
        setTimeout(() => {
          themeToggle.classList.remove('rotate-180');
        }, 300);
      }
    });
    
    // Add password strength meter functionality
    const passwordInput = document.getElementById('password');
    if (passwordInput) {
      const strengthMeter = document.querySelector('.password-strength-meter-fill');
      const strengthText = document.getElementById('password-strength-text');
      
      passwordInput.addEventListener('input', function() {
        const value = passwordInput.value;
        let strength = 0;
        
        // Length check
        if (value.length >= 8) strength += 1;
        
        // Contains number
        if (/\d/.test(value)) strength += 1;
        
        // Contains special character
        if (/[!@#$%^&*(),.?":{}|<>]/.test(value)) strength += 1;
        
        // Contains uppercase and lowercase
        if (/[a-z]/.test(value) && /[A-Z]/.test(value)) strength += 1;
        
        // Update strength meter
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
      });
    }
    
    // Toggle password visibility
    const togglePasswordButtons = document.querySelectorAll('.toggle-password');
    togglePasswordButtons.forEach(button => {
    button.addEventListener('click', function() {
        const input = document.querySelector(this.getAttribute('data-target'));
        const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
        input.setAttribute('type', type);
        
        // Toggle icon
        const showIcon = this.querySelector('.show-password');
        const hideIcon = this.querySelector('.hide-password');
        
        if (showIcon) showIcon.classList.toggle('hidden');
        if (hideIcon) hideIcon.classList.toggle('hidden');
    });
    });

    // ISO27001 Certificate Modal
    const modal = document.getElementById('iso-modal');
    const isoBadge = document.getElementById('iso-badge');
    const closeBtn = document.querySelector('.iso-close');

    // Open modal when clicking on the ISO badge
    if (isoBadge) {
    isoBadge.addEventListener('click', function() {
        modal.style.display = 'block';
        document.body.style.overflow = 'hidden'; // Prevent scrolling when modal is open
    });
    }

    // Close modal functionality
    if (closeBtn) {
    closeBtn.addEventListener('click', function() {
        modal.style.display = 'none';
        document.body.style.overflow = 'auto'; // Restore scrolling
    });
    }

    // Close modal when clicking outside the image
    window.addEventListener('click', function(event) {
    if (event.target === modal) {
        modal.style.display = 'none';
        document.body.style.overflow = 'auto'; // Restore scrolling
    }
    });

    // Close modal with escape key
    document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape' && modal.style.display === 'block') {
        modal.style.display = 'none';
        document.body.style.overflow = 'auto'; // Restore scrolling
    }
    });
    
    // Add hover animations to form elements
    const formElements = document.querySelectorAll('input, button');
    formElements.forEach(element => {
      element.addEventListener('mouseover', function() {
        this.classList.add('scale-105');
        setTimeout(() => {
          this.classList.remove('scale-105');
        }, 200);
      });
    });

    const isoBadgeMobile = document.getElementById('iso-badge-mobile');

// Open modal when clicking on the mobile ISO badge
if (isoBadgeMobile) {
  isoBadgeMobile.addEventListener('click', function() {
    modal.style.display = 'block';
    document.body.style.overflow = 'hidden';
  });
}

    document.addEventListener('DOMContentLoaded', () => {
    const typingTextElement = document.getElementById('typing-text');
    const cursorElement = document.querySelector('.pulse-cursor');
    
    if (typingTextElement && cursorElement) {
      const textToType = typingTextElement.textContent.trim();
      typingTextElement.textContent = '';
      cursorElement.classList.remove('hidden');
      
      let charIndex = 0;
      
      function typeNextChar() {
        if (charIndex < textToType.length) {
          typingTextElement.textContent += textToType.charAt(charIndex);
          charIndex++;
          setTimeout(typeNextChar, 100);
        } else {
          // Show pulse cursor after typing is complete
          cursorElement.style.display = 'inline-block';
        }
      }
      
      // Start typing animation
      typeNextChar();
    }
  });
  </script>
</body>
</html>
</#macro>