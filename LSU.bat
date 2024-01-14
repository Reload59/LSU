@echo off
setlocal enabledelayedexpansion
chcp 65001
title LSU
cls

:: //Websites//
::   Spotify -> https://www.spotify.com/download #Spotify Versions# -> https://cutt.ly/8EH6NuH
:: Spicetify -> https://github.com/spicetify/spicetify-cli & https://spicetify.app
::     SpotX -> https://github.com/SpotX-Official/SpotX
::       LSU -> https://github.com/Reload59/LSU
:: ------------------

:: //LSU-Config//
set "mode=4"
::    Custom = 0
::   Install = 1
::    Delete = 2
::    Update = 3
:: Reinstall = 4
:: ------------------
:: //Custom-Settings//
set "spo-del=0"
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
:: Ask = 3 (SpotX Default)(Recommended)
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
set "dt=2"
:: Activates developer tools.
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

if "%mode%"=="1" (
	set "spo-ins=1" & set "spo-del=0" & set "spo-upg=0"
	set "spx-ins=1" & set "spx-del=0" & set "spx-upg=0"
	set "spi-ins=1" & set "spi-del=0" & set "spi-upg=0"
	)

if "%mode%"=="2" (
	set "spo-ins=0" & set "spo-del=1" & set "spo-upg=0"
	set "spx-ins=0" & set "spx-del=1" & set "spx-upg=0"
	set "spi-ins=0" & set "spi-del=1" & set "spi-upg=0"
	)

if "%mode%"=="3" (
	set "spo-ins=0" & set "spo-del=0" & set "spo-upg=0"
	set "spx-ins=0" & set "spx-del=0" & set "spx-upg=0"
	set "spi-ins=0" & set "spi-del=0" & set "spi-upg=1"
	)

if "%mode%"=="4" (
	set "spo-ins=1" & set "spo-del=1" & set "spo-upg=0"
	set "spx-ins=1" & set "spx-del=1" & set "spx-upg=0"
	set "spi-ins=1" & set "spi-del=1" & set "spi-upg=0"
	)

if not "%debug%"=="1" (set "t=2") else (set "t=1")
if exist "%temp%\LSU\" (rd /s /q "%temp%\LSU\" >nul 2>&1)
if not exist "%temp%\LSU\" (md "%temp%\LSU\" >nul 2>&1)
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
echo Çıkmak için herhangi bir tuşa basın...  & pause >nul 2>&1
exit /b

:spo-del
cls & echo #Spotify-Uninstall#
if not "%force%"=="1" (
	if not exist "%appdata%\Spotify\Spotify.exe" (
		echo Spotify yüklü değil, kaldırılamaz.
		timeout /t %t% /nobreak >nul 2>&1 & exit /b
		)
	)
call :stp
echo Spotify kaldırılıyor... 
if exist "%localappdata%\Spotify\Update" (icacls "%localappdata%\Spotify\Update" /reset /t >nul 2>&1)
if exist "%appdata%\Spotify\Spotify.exe" (start /b /w "Spotify-Uninstall" "%appdata%\Spotify\Spotify.exe" /uninstall /silent & timeout /t 2 /nobreak >nul 2>&1)
if exist "%appdata%\Spotify" (rd /s /q "%appdata%\Spotify" >nul 2>&1)
if exist "%localappdata%\Spotify" (rd /s /q "%localappdata%\Spotify" >nul 2>&1)
if exist "%temp%\SpotifyUninstall.exe" (del /s /q  "%temp%\SpotifyUninstall.exe" >nul 2>&1)
if exist "%userprofile%\Desktop\Spotify.lnk" (del /s /q "%userprofile%\Desktop\Spotify.lnk" >nul 2>&1)
if not exist "%appdata%\Spotify\Spotify.exe" (
	echo Spotify başarıyla kaldırıldı.
	timeout /t %t% /nobreak >nul 2>&1
	) else (
	echo Spotify kaldırılamadı manuel olarak kaldırmayı deneyin.
	pause & exit /b
	)
if not "%debug%"=="1" (timeout /t %t% /nobreak >nul 2>&1) else (pause)
exit /b

:spx-del
cls & echo #SpotX-Uninstall#
if not "%force%"=="1" (
	if not exist "%appdata%\Spotify\Spotify.bak" (
		echo SpotX yüklü değil, kaldırılamaz.
		timeout /t %t% /nobreak >nul 2>&1 & exit /b
		)
	)
call :stp
if not exist "%appdata%\Spotify\Spotify.bak" (
	echo SpotX başarıyla kaldırıldı.
	timeout /t %t% /nobreak >nul 2>&1
	) else (
	echo SpotX kaldırılamadı manuel olarak kaldırmayı deneyin.
	pause & exit /b
	)
if not "%debug%"=="1" (timeout /t %t% /nobreak >nul 2>&1) else (pause)
exit /b

:spi-del
cls & echo #Spicetify-Uninstall#
if not "%force%"=="1" (
	if not exist "%localappdata%\spicetify\spicetify.exe" (
		echo Spicetify yüklü değil, kaldırılamaz.
		timeout /t %t% /nobreak >nul 2>&1 & exit /b
		)
	)
call :stp
echo Spicetify kaldırılıyor... 
if exist "%appdata%\spicetify\" (rd /s /q "%appdata%\spicetify" >nul 2>&1)
if exist "%localappdata%\spicetify\" (rd /s /q "%localappdata%\spicetify" >nul 2>&1)
if not exist "%localappdata%\spicetify\spicetify.exe" (
	echo Spicetify başarıyla kaldırıldı.
	timeout /t %t% /nobreak >nul 2>&1
	) else (
	echo Spicetify kaldırılamadı manuel olarak kaldırmayı deneyin.
	pause & exit /b
	)
if not "%debug%"=="1" (timeout /t %t% /nobreak >nul 2>&1) else (pause)
exit /b

:spo-ins
cls & echo #Spotify-Install#
if not "%force%"=="1" (
	if exist "%appdata%\Spotify\Spotify.exe" (
		echo Spotify zaten yüklü.
		timeout /t %t% /nobreak >nul 2>&1 & exit /b
		)
	)
if "%manuel%"=="1" (
	echo Spotifyı manuel olarak yüklemeniz bekleniyor... 
	echo Eski spotify versiyonları -^> https://cutt.ly/8EH6NuH 
	echo Devam etmek için herhangi bir tuşa basın...  & pause >nul 2>&1
	if not exist "%appdata%\Spotify\Spotify.exe" (
		cls & echo #Spotify-Install#
		echo Spotify doğru bir şekilde yüklenmiş gözükmüyor. 
		choice /c EH /m "> Spotifyın en son sürümünü otomatik olarak yüklemek ister misiniz"
		if "!errorlevel!" EQU "1" (set "manuel=0" & goto spo-ins)
		)
	timeout /t %t% /nobreak >nul 2>&1 & exit /b
	)
	call :stp
if exist "%temp%\LSU\SpotifySetup.exe" (del /s /q "%temp%\LSU\SpotifySetup.exe" >nul 2>&1)
echo Spotify indiriliyor...
powershell -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = 3072;Invoke-WebRequest -UseBasicParsing -Uri "https://download.scdn.co/SpotifySetup.exe" -OutFile "%temp%\LSU\SpotifySetup.exe"
if exist "%temp%\LSU\SpotifySetup.exe" (
	echo Spotify başarıyla indirildi.
	timeout /t %t% /nobreak >nul 2>&1
	) else (
	echo Spotify indirilemedi manuel olarak indirmeyi deneyin.
	pause & exit /b
	)
echo Spotify yükleniyor...
start /b /w "SpotifySetup" "%temp%\LSU\SpotifySetup.exe" /silent >nul 2>&1 & timeout /t 1 /nobreak >nul 2>&1
if exist "%appdata%\Spotify\Spotify.exe" (
	echo Spotify başarıyla yüklendi.
	timeout /t %t% /nobreak >nul 2>&1
	) else (
	echo Spotify yüklenemedi manuel olarak yüklemeyi deneyin.
	pause & exit /b
	)
if exist "%temp%\LSU\SpotifySetup.exe" (del /s /q "%temp%\LSU\SpotifySetup.exe" >nul 2>&1)
if not "%debug%"=="1" (timeout /t %t% /nobreak >nul 2>&1) else (pause)
exit /b

:spx-ins
cls & echo #SpotX-Install#
if not "%force%"=="1" (
	if not exist "%appdata%\Spotify\Spotify.exe" (
		echo Spotify yüklü değil, SpotX yüklenemez.
		timeout /t %t% /nobreak >nul 2>&1 & exit /b
		)
	)
if not "%force%"=="1" (
	if exist "%appdata%\Spotify\Spotify.bak" (
		echo SpotX zaten yüklü.
		timeout /t %t% /nobreak >nul 2>&1 & exit /b
		)
	)
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
if "%dt%" NEQ "1" (if "%dt%" NEQ "2" (set "dt="))
if "%dt%" EQU "1" (set "dt= -devtools")
if "%dt%" EQU "2" (set "dt=")
if "%ss%" NEQ "1" (if "%ss%" NEQ "2" (set "ss="))
if "%ss%" EQU "1" (set "ss= -start_spoti")
if "%ss%" EQU "2" (set "ss=")
if "%ns%" NEQ "1" (if "%ns%" NEQ "2" (set "ns="))
if "%ns%" EQU "1" (set "ns= -no_shortcut")
if "%ns%" EQU "2" (set "ns=")
::--------------------------------------------------------------------
set "param=%csr%%ums%%po%%bu%%pr%%dt%%ss%%ns%"
if "%debug%"=="1" (echo Parameters:%param% & pause)
call :stp
echo SpotX yükleniyor... 
powershell -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = 3072;$p='%param%';""" & {$(iwr -useb 'https://raw.githubusercontent.com/SpotX-Official/spotx-official.github.io/main/run.ps1')} $p """" | iex
if exist "%appdata%\Spotify\Spotify.bak" (
	echo SpotX başarıyla yüklendi.
	timeout /t %t% /nobreak >nul 2>&1 & exit /b
	) else (
	echo SpotX yüklenemedi manuel olarak yüklemeyi deneyin.
	pause & exit /b
	)
if not "%debug%"=="1" (timeout /t %t% /nobreak >nul 2>&1) else (pause)
exit /b

:spi-ins
cls & echo #Spicetify-Install#
if not "%force%"=="1" (
	if not exist "%appdata%\Spotify\Spotify.exe" (
		echo Spotify yüklü değil, Spicetify yüklenemez.
		timeout /t %t% /nobreak >nul 2>&1 & exit /b
		)
	)
if not "%force%"=="1" (
	if exist "%localappdata%\spicetify\spicetify.exe" (
		echo Spicetify zaten yüklü.
		timeout /t %t% /nobreak >nul 2>&1 & exit /b
		)
	)
call :stp
echo Spicetify yükleniyor... 
powershell -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = 3072;iwr -useb https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.ps1 ^| iex;Spicetify apply
if exist "%localappdata%\spicetify\spicetify.exe" (
	echo Spicetify başarıyla yüklendi.
	timeout /t %t% /nobreak >nul 2>&1
	) else (
	echo Spicetify yüklenemedi manuel olarak yüklemeyi deneyin.
	pause & exit /b
	)
if not "%debug%"=="1" (timeout /t %t% /nobreak >nul 2>&1) else (pause)
exit /b


:spi-upg
cls & echo #Spicetify-Upgrade#
if not "%force%"=="1" (
	if not exist "%localappdata%\spicetify\spicetify.exe" (
		echo Spicetify yüklü değil, Güncelenemez.
		timeout /t %t% /nobreak >nul 2>&1 & exit /b
		)
	)
call :stp
echo Spicetify güncelleniyor...
powershell -ExecutionPolicy Bypass -Command spicetify upgrade;spicetify restore backup apply
if not "%debug%"=="1" (timeout /t %t% /nobreak >nul 2>&1) else (pause)
exit /b

:stp
if not "%force%"=="1" (
	if not exist "%appdata%\Spotify\Spotify.exe" (
		echo Spotify bulunamadı, durdurulamaz.
		timeout /t %t% /nobreak >nul 2>&1 & exit /b
		)
	)
tasklist | find "Spotify.exe" >nul 2>&1
if "%errorlevel%" EQU "1" (echo Spotify zaten durdurulmuş.)
if "%errorlevel%" NEQ "1" (
	echo Spotify durduruluyor...
	taskkill /f /im "Spotify.exe" >nul 2>&1
	timeout /t 2 /nobreak >nul 2>&1
	call :stp_chk
	)
exit /b

:stp_chk
tasklist | find "Spotify.exe" >nul 2>&1
if "%errorlevel%" EQU "1" (echo Spotify başarıyla durduruldu.)
if "%errorlevel%" NEQ "1" (echo Spotify durdurulamadı.)
exit /b

rem ;iwr -useb https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.ps1 ^| iex