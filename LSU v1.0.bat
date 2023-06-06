@echo off
setlocal enabledelayedexpansion
chcp 65001
title LSU
cls

:: //Websites//
::   Spotify -> https://www.spotify.com/download #Spotify Versions# -> https://cutt.ly/8EH6NuH
:: Spicetify -> https://github.com/spicetify/spicetify-cli & https://spicetify.app
::     SpotX -> https://github.com/amd64fox/SpotX
::       LSU -> https://github.com/Reload59/LSU
:: ------------------

:: //LSU-Config//
set "spo-del=1"
:: Spotify'ı siler.
::  True = 1
:: False = 0
:: ------------------
set "spo-ins=1"
:: Spotify'ı yükler.
::  True = 1
:: False = 0
:: ------------------
set "spx-del=1"
:: SpotX'i siler.
::  True = 1
:: False = 0
:: ------------------
set "spx-ins=1"
:: SpotX'i yükler.
::  True = 1
:: False = 0
:: ------------------
set "spi-del=1"
:: Spicetify'ı siler.
::  True = 1
:: False = 0
:: ------------------
set "spi-ins=1"
:: Spicetify'ı yükler.
::  True = 1
:: False = 0
:: ------------------

:://Additional//
set "manuel=0"
:: Spotify'ı yüklemez ve manuel yüklenmesi için betiği duraklatır.
:: "Spotify'ı yükle" ile birlikte kullanılması gerekir aksi halde bir işe yaramaz!
::  True = 1
:: False = 0
:: --------------------------------------
set "force=0"
:: Spotify,Spicetify,SpotX yüklemesi ve kaldırması için betiği zorlar.
:: En az bir "LSU-Config" seçeneği ile birlikte kullanılması gerekir aksi halde bir işe yaramaz!
::  True = 1
:: False = 0
:: --------------------------------------
set "debug=0"
:: Hata ayıklama modunu açar.
::  True = 1
:: False = 0
:: --------------------------------------

:: //SpotX-Config//
:: https://github.com/amd64fox/SpotX/discussions/60
:: //Required//
set "csr=3"
:: If update available install parameters.
:: Overwrite = 1
:: Reinstall = 2
::       Ask = 3 (SpotX Default)(Recommended)
:: --------------------------------------
set "ums=1"
:: If exist delete microsoft store version of spotify.
::  True = 1 (Recommended)
::   Ask = 3 (SpotX Default)
:: --------------------------------------
set "po=1"
:: Disable podcasts from homepage.
::  True = 1 (Recommended)
:: False = 2 (Spotify Default)
::   Ask = 3 (SpotX Default)
:: --------------------------------------
set "bu=1"
:: Disable spotify automatic updates.
::  True = 1 (Recommended)
:: False = 2 (Spotify Default)
::   Ask = 3 (SpotX Default)
:: --------------------------------------

:: //Other//
set "pr=2"
:: If have a premium account enable this section. (No ad blocking features.)
::  True = 1
:: False = 2 (SpotX Default)
:: --------------------------------------
set "ss=1"
:: Start spotify when script is finished.
::  True = 1 (Recommended)
:: False = 2 (SpotX Default)
:: --------------------------------------
set "ns=2"
:: Do not add spotify shortcut to desktop. (Only for when using SpotX.)
::  True = 1
:: False = 2 (SpotX Default)
:: --------------------------------------

:: //Features//
set "el=1"
:: Enable enhance liked songs feature.
:: https://github.com/amd64fox/SpotX/discussions/50#discussioncomment-2851482
::  True = 1 (SpotX Default)(Recommended)
:: False = 2
:: --------------------------------------
set "nt=2"
:: Enable new theme. (New right and left sidebar, some cover change.)
:: https://github.com/amd64fox/SpotX/discussions/50#discussioncomment-3202577
::  True = 1 (Recommended)
:: False = 2 (SpotX Default)
:: --------------------------------------
set "rsbc=1"
:: Enable right sidebar coloring to match cover color. (Only works with new theme.)
::  True = 1 
:: False = 2 (SpotX Default)
:: --------------------------------------
set "as=2"
:: Enable hiding ad-like sections from the homepage.
:: https://github.com/amd64fox/SpotX/discussions/50#discussioncomment-4478943
::  True = 1 
:: False = 2 (SpotX Default)
:: --------------------------------------

set "t=1"
set "end=0"
if "%debug%"=="1" (set "force=1") 
if exist "%temp%\LSU\" (rd /s /q "%temp%\LSU\" >nul 2>&1)
if not exist "%temp%\LSU\" (md "%temp%\LSU\" >nul 2>&1)
if "%debug%"=="1" call :spx-ins
if "%spo-del%"=="1" call :spo-del
if "%spx-del%"=="1" call :spx-del
if "%spi-del%"=="1" call :spi-del
if "%spo-ins%"=="1" call :spo-ins
if "%spx-ins%"=="1" call :spx-ins
if "%spi-ins%"=="1" call :spi-ins
if "%spo-upg%"=="1" call :spo-upg
if "%spx-upg%"=="1" call :spx-upg
if "%spi-upg%"=="1" call :spi-upg
if exist "%temp%\LSU\" (rd /s /q "%temp%\LSU\" >nul 2>&1)
if "%spo-del%"=="1" (set "end=1")
if "%spx-del%"=="1" (set "end=1")
if "%spi-del%"=="1" (set "end=1")
if "%spo-ins%"=="1" (set "end=1")
if "%spx-ins%"=="1" (set "end=1")
if "%spi-ins%"=="1" (set "end=1")
if "%spo-upg%"=="1" (set "end=1")
if "%spx-upg%"=="1" (set "end=1")
if "%spi-upg%"=="1" (set "end=1")
if "%end%"=="0" (
echo; [97m
echo ----------------------------------------------------------------------
echo Scripti çalıştırmadan önce not defteri ile açarak configi düzenleyin.
echo ----------------------------------------------------------------------)  
echo; & echo [33m Çıkmak için herhangi bir tuşa basın... [97m & pause >nul 2>&1
exit /b

:spo-ins
cls & echo; & echo [90m Spotify-Install: Starting [97m
if not "%force%"=="1" (if exist "%appdata%\Spotify\Spotify.exe" (echo; & echo [34m Spotify zaten yüklü. [97m & echo; & echo [90m Spotify-Install: Done [97m & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
if "%manuel%"=="1" (
echo; & echo [33m Spotifyı manuel olarak yüklemeniz bekleniyor... [97m
echo; & echo [32m Spotify versiyonları -^> https://cutt.ly/8EH6NuH [97m
echo; & choice /c EH /m "> Manuel yükleme için web tarayıcınız üzerinden spotify versiyonlarını görmek ister misiniz"
if "!errorlevel!" EQU "1" (start /b "Link" "https://cutt.ly/8EH6NuH")
echo; & echo [33m Devam etmek için herhangi bir tuşa basın... [97m & pause >nul 2>&1
if not exist "%appdata%\Spotify\Spotify.exe" (
cls & echo; & echo [90m Spotify-Install: Starting [97m
echo; & echo [31m Spotify doğru bir şekilde yüklenmiş gözükmüyor. [97m
echo; & choice /c EH /m "> Spotifyın en son sürümünü otomatik olarak yüklemek ister misiniz"
if "!errorlevel!" EQU "1" (set "manuel=0" & goto spo-ins)
if "!errorlevel!" EQU "2" (echo; & echo [90m Spotify-Install: Done [97m & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
echo; & echo [90m Spotify-Install: Done [97m & timeout /t %t% /nobreak >nul 2>&1 & exit /b)
call :stp
if exist "%temp%\LSU\SpotifySetup.exe" (del /s /q "%temp%\LSU\SpotifySetup.exe" >nul 2>&1)
echo; & echo [33m Spotify yükleniyor... [97m
powershell -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-WebRequest -UseBasicParsing -Uri "https://download.scdn.co/SpotifySetup.exe" -OutFile "%temp%\LSU\SpotifySetup.exe"
start /b /w "SpotifySetup" "%temp%\LSU\SpotifySetup.exe" /silent >nul 2>&1 & timeout /t 1 /nobreak >nul 2>&1
if exist "%temp%\LSU\SpotifySetup.exe" (del /s /q "%temp%\LSU\SpotifySetup.exe" >nul 2>&1)
echo; & echo [90m Spotify-Install: Done [97m
timeout /t %t% /nobreak >nul 2>&1
exit /b

:spo-del
cls & echo; & echo [90m Spotify-Uninstall: Starting [97m
if not "%force%"=="1" (if not exist "%appdata%\Spotify\Spotify.exe" (echo; & echo [31m Spotify yüklü değil, kaldırılamaz. [97m & echo; & echo [90m Spotify-Uninstall: Done [97m & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
call :stp
echo; & echo [33m Spotify kaldırılıyor... [97m
if exist "%localappdata%\Spotify\Update" (icacls "%localappdata%\Spotify\Update" /reset /t >nul 2>&1)
if exist "%appdata%\Spotify\Spotify.exe" (start /b /w "Spotify-Uninstall" "%appdata%\Spotify\Spotify.exe" /uninstall /silent & timeout /t 1 /nobreak >nul 2>&1)
if exist "%appdata%\Spotify" (rd /s /q "%appdata%\Spotify" >nul 2>&1)
if exist "%localappdata%\Spotify" (rd /s /q "%localappdata%\Spotify" >nul 2>&1)
if exist "%temp%\SpotifyUninstall.exe" (del /s /q  "%temp%\SpotifyUninstall.exe" >nul 2>&1)
if exist "%userprofile%\Desktop\Spotify.lnk" (del /s /q "%userprofile%\Desktop\Spotify.lnk" >nul 2>&1)
echo; & echo [90m Spotify-Uninstall: Done [97m
timeout /t %t% /nobreak >nul 2>&1
exit /b

:spx-ins
cls & echo; & echo [90m SpotX-Install: Starting [97m
if not "%force%"=="1" (if not exist "%appdata%\Spotify\Spotify.exe" (echo; & echo [31m Spotify yüklü değil, SpotX yüklenemez. [97m & echo; & echo [90m SpotX-Install: Done [97m & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
if not "%force%"=="1" (if exist "%appdata%\Spotify\Spotify.bak" (echo; & echo [34m SpotX zaten yüklü. [97m & echo; & echo [90m SpotX-Install: Done [97m & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
if "%csr%" NEQ "1" (if "%csr%" NEQ "2" (if "%csr%" NEQ "3" (set "csr=")))
if "%csr%" EQU "1" (set "csr= -confirm_spoti_recomended_over")
if "%csr%" EQU "2" (set "csr= -confirm_spoti_recomended_unistall")
if "%csr%" EQU "3" (set "csr=")
if "%ums%" NEQ "1" (if "%ums%" NEQ "3" (set "ums="))
if "%ums%" EQU "1" (set "ums= -confirm_uninstall_ms_spoti")
if "%ums%" EQU "3" (set "ums=")
if "%po%" NEQ "1" (if "%po%" NEQ "2" (if "%po%" NEQ "3" (set "po=")))
if "%po%" EQU "1" (set "po= -podcasts_off")
if "%po%" EQU "2" (set "po= -podcasts_on")
if "%po%" EQU "3" (set "po=")
if "%bu%" NEQ "1" (if "%bu%" NEQ "2" (if "%bu%" NEQ "3" (set "bu=")))
if "%bu%" EQU "1" (set "bu= -block_update_on")
if "%bu%" EQU "2" (set "bu= -block_update_off")
if "%bu%" EQU "3" (set "bu=")
::--------------------------------------------------------------------
if "%pr%" NEQ "1" (if "%pr%" NEQ "2" (set "pr="))
if "%pr%" EQU "1" (set "pr= -premium")
if "%pr%" EQU "2" (set "pr=")
if "%ss%" NEQ "1" (if "%ss%" NEQ "2" (set "ss="))
if "%ss%" EQU "1" (set "ss= -start_spoti")
if "%ss%" EQU "2" (set "ss=")
if "%ns%" NEQ "1" (if "%ns%" NEQ "2" (set "ns="))
if "%ns%" EQU "1" (set "ns= -no_shortcut")
if "%ns%" EQU "2" (set "ns=")
::--------------------------------------------------------------------
if "%el%" NEQ "1" (if "%el%" NEQ "2" (set "el="))
if "%el%" EQU "1" (set "el=")
if "%el%" EQU "2" (set "el= -enhance_like_off")
if "%nt%" NEQ "1" (if "%nt%" NEQ "2" (set "nt="))
if "%nt%" EQU "1" (set "nt= -new_theme")
if "%nt%" EQU "2" (set "nt=")
if "%rsbc%" NEQ "1" (if "%rsbc%" NEQ "2" (set "rsbc="))
if "%rsbc%" EQU "1" (set "rsbc= -rightsidebarcolor")
if "%rsbc%" EQU "2" (set "rsbc=")
if "%as%" NEQ "1" (if "%as%" NEQ "2" (set "as="))
if "%as%" EQU "1" (set "as= -adsections_off")
if "%as%" EQU "2" (set "as=")
if "%debug%"=="1" (echo; & echo  Parameters:%csr%%ums%%po%%bu%%el%%hci%%nt%%rsbc%%as%%pr%%ss%%ns% & echo; & echo [33m Devam etmek için herhangi bir tuşa basın... [97m & pause >nul 2>&1)
call :stp
echo; & echo [33m SpotX yükleniyor... [97m
echo; & powershell -ExecutionPolicy Bypass -Command "&{[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12}; """"& { $(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/amd64fox/SpotX/main/Install.ps1')} %csr%%ums%%po%%bu%%el%%hci%%nt%%rsbc%%as%%pr%%ss%%ns% """" | Invoke-Expression"
if "%ink%"=="0" (del /s /q "%userprofile%\Desktop\Spotify.lnk" >nul 2>&1)
echo; & echo [90m SpotX-Install: Done [97m
timeout /t %t% /nobreak >nul 2>&1
exit /b

:spx-del
cls & echo; & echo [90m SpotX-Uninstall: Starting [97m 
if not "%force%"=="1" (if not exist "%appdata%\Spotify\Spotify.bak" (echo; & echo [31m SpotX yüklü değil, kaldırılamaz. [97m & echo; & echo [90m SpotX-Uninstall: Done [97m & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
call :stp
echo; & echo [33m SpotX kaldırılıyor... [97m
if exist "%appdata%\Spotify\chrome_elf_bak.dll" (del /s /q "%appdata%\Spotify\chrome_elf.dll" >nul 2>&1 & move "%appdata%\Spotify\chrome_elf_bak.dll" "%appdata%\Spotify\chrome_elf.dll" >nul 2>&1)
if exist "%appdata%\Spotify\Spotify.bak" (del /s /q "%appdata%\Spotify.exe" >nul 2>&1 & move "%appdata%\Spotify\Spotify.bak" "%appdata%\Spotify\Spotify.exe" >nul 2>&1)
if exist "%appdata%\Spotify\config.ini" (del /s /q "%appdata%\Spotify\config.ini" >nul 2>&1)
if exist "%appdata%\Spotify\Apps\xpui.bak" (del /s /q "%appdata%\Spotify\Apps\xpui.spa" >nul 2>&1 & move "%appdata%\Spotify\Apps\xpui.bak" "%appdata%\Spotify\Apps\xpui.spa" >nul 2>&1)
if exist "%appdata%\Spotify\Apps\xpui\xpui.js.bak" (del /s /q "%appdata%\Spotify\Apps\xpui\xpui.js" >nul 2>&1 & move "%appdata%\Spotify\Apps\xpui\xpui.js.bak" "%appdata%\Spotify\Apps\xpui\xpui.js" >nul 2>&1)
if exist "%appdata%\Spotify\Apps\xpui\xpui.css.bak" (del /s /q "%appdata%\Spotify\Apps\xpui\xpui.css" >nul 2>&1 & move "%appdata%\Spotify\Apps\xpui\xpui.css.bak" "%appdata%\Spotify\Apps\xpui\xpui.css" >nul 2>&1)
if exist "%appdata%\Spotify\Apps\xpui\licenses.html.bak" (del /s /q "%appdata%\Spotify\Apps\xpui\licenses.html" >nul 2>&1 & move "%appdata%\Spotify\Apps\xpui\licenses.html.bak" "%appdata%\Spotify\Apps\xpui\licenses.html" >nul 2>&1)
if exist "%appdata%\Spotify\Apps\xpui\i18n\ru.json.bak" (del /s /q "%appdata%\Spotify\Apps\xpui\i18n\ru.json" >nul 2>&1 & move "%appdata%\Spotify\Apps\xpui\i18n\ru.json.bak" "%appdata%\Spotify\Apps\xpui\i18n\ru.json" >nul 2>&1)
if exist "%appdata%\Spotify\blockthespot_log.txt" (del /s /q "%appdata%\Spotify\blockthespot_log.txt" >nul 2>&1)
if exist "%appdata%\Spotify\cache" (
rd /s /q %appdata%\Spotify\cache >nul 2>&1
set Esc_LinkDest=%userprofile%\Desktop\Spotify.lnk
set Esc_LinkTarget=%appdata%\Spotify\Spotify.exe
set Esc_WorkLinkTarget=%appdata%\Spotify\
set cSctVBS=CreateShortcut.vbs
((echo Set oWS = WScript.CreateObject^("WScript.Shell"^)
echo sLinkFile = oWS.ExpandEnvironmentStrings^("!Esc_LinkDest!"^)
echo Set oLink = oWS.CreateShortcut^(sLinkFile^)
echo oLink.TargetPath = oWS.ExpandEnvironmentStrings^("!Esc_LinkTarget!"^)
echo oLink.WorkingDirectory = oWS.ExpandEnvironmentStrings^("!Esc_WorkLinkTarget!"^)
echo oLink.Save)1>!cSctVBS!
cscript !cSctVBS!
del !cSctVBS! /f /q))
echo; & echo [90m SpotX-Uninstall: Done [97m
timeout /t %t% /nobreak >nul 2>&1
exit /b

:spi-ins
cls & echo; & echo [90m Spicetify-Install: Starting [97m
if not "%force%"=="1" (if not exist "%appdata%\Spotify\Spotify.exe" (echo; & echo [31m Spotify yüklü değil, Spicetify yüklenemez. [97m & echo; & echo [90m Spicetify-Install: Done [97m & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
if not "%force%"=="1" (if exist "%localappdata%\spicetify\spicetify.exe" (echo; & echo [34m Spicetify zaten yüklü. [97m & echo; & echo [90m Spicetify-Install: Done [97m & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
call :stp
echo; & echo [33m Spicetify yükleniyor... [97m
echo; & powershell -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.ps1 ^| Invoke-Expression;Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.ps1 ^| Invoke-Expression;spicetify apply
echo; & echo [90m Spicetify-Install: Done [97m
timeout /t %t% /nobreak >nul 2>&1
exit /b

:spi-del
cls & echo; & echo [90m Spicetify-Uninstall: Starting [97m
if not "%force%"=="1" (if not exist "%localappdata%\spicetify\spicetify.exe" (echo; & echo [31m Spicetify yüklü değil, kaldırılamaz. [97m & echo; & echo [90m Spicetify-Uninstall: Done [97m & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
call :stp
echo; & echo [33m Spicetify kaldırılıyor... [97m
if exist "%appdata%\spicetify\" (rd /s /q "%appdata%\spicetify" >nul 2>&1)
if exist "%localappdata%\spicetify\" (rd /s /q "%localappdata%\spicetify" >nul 2>&1)
echo; & echo [90m Spicetify-Uninstall: Done [97m
timeout /t %t% /nobreak >nul 2>&1
exit /b

:spi-upg
cls & echo; & echo [90m Spicetify-Upgrade: Starting [97m
if not "%force%"=="1" (if not exist "%localappdata%\spicetify\spicetify.exe" (echo; & echo [31m Spicetify yüklü değil, Güncelenemez. [97m & echo; & echo [90m Spicetify-Upgrade: Done [97m & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
call :stp
echo; & echo [33m Spicetify Güncelleniyor... [97m
echo; & powershell -ExecutionPolicy Bypass -Command spicetify upgrade;spicetify restore backup apply
echo; & echo [90m Spicetify-Upgrade: Done [97m
timeout /t %t% /nobreak >nul 2>&1
exit /b

:stp
if not "%force%"=="1" (if not exist "%appdata%\Spotify\Spotify.exe" (echo; & echo [34m Spotify bulunamadı, durdurulamaz. [97m & exit /b))
tasklist | find "Spotify.exe" >nul 2>&1
if "%errorlevel%" EQU "1" (echo; & echo [34m Spotify zaten durdurulmuş. [97m)
if "%errorlevel%" NEQ "1" (echo; & echo [33m Spotify durduruluyor... [97m & taskkill /f /im "Spotify.exe" >nul 2>&1 & timeout /t 2 /nobreak >nul 2>&1 & call :stp_chk)
exit /b

:stp_chk
tasklist | find "Spotify.exe" >nul 2>&1
if "%errorlevel%" EQU "1" (echo [32m Spotify başarıyla durduruldu. [97m)
if "%errorlevel%" NEQ "1" (echo [31m Spotify durdurulamadı. [97m)
exit /b
