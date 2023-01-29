@echo off
setlocal enabledelayedexpansion
chcp 65001
title Latest Spotify Updater
cls

:: //Websites//
::   Spotify -> https://www.spotify.com/download
:: Spicetify -> https://github.com/spicetify/spicetify-cli
::     SpotX -> https://github.com/amd64fox/SpotX  
:: #Spotify Versions# -> https://cutt.ly/8EH6NuH

:: //Config//
set "spo-del=0"
:: Spotify'ı siler.
::  True = 1
:: False = 0
:: --------------------
set "spo-ins=0"
:: Spotify'ı yükler.
::  True = 1
:: False = 0
:: --------------------
set "spi-del=0"
:: Spicetify'ı siler.
::  True = 1
:: False = 0
:: --------------------
set "spi-ins=0"
:: Spicetify'ı yükler.
::  True = 1
:: False = 0
:: --------------------
set "spx-del=0"
:: SpotX'i siler.
::  True = 1
:: False = 0
:: --------------------
set "spx-ins=0"
:: SpotX'i yükler.
::  True = 1
:: False = 0
:: --------------------

:://Additional//
set "manuel=0"
:: Spotify'ı yüklemez ve manuel yüklenmesi için betiği duraklatır.
:: "Spotify'ı yükle" ile birlikte kullanılması gerekir aksi halde bir işe yaramaz!!
::  True = 1
:: False = 0
:: --------------------
set "backup=0"
:: Spotify silinirken kullanıcı giriş bilgilerini yedekler, Spotify tekrar yüklendiğinde otomatik giriş yapar.
:: "Spotify'ı sil" ile birlikte kullanılması gerekir aksi halde bir işe yaramaz!!
:: Deneysel bir seçenektir, çalışmayabilir.
::  True = 1
:: False = 0
:: --------------------
set "force=0"
:: Spotify yüklü olarak gözükse bile tekrar yüklemeye çalışır.
:: Spotify kaldırılmış gözükse bile tekrar kaldırmaya çalışır.
:: En az bir "Config" seçeneği ile birlikte kullanılması gerekir aksi halde bir işe yaramaz!!
::  True = 1
:: False = 0
:: --------------------
set "debug=0"
:: Hata ayıklama modunu açar.
::  True = 1
:: False = 0
:: --------------------

:: //SpotX-Config//
:: https://github.com/SpotX-CLI/SpotX-Win/discussions/60
:: //Required//
set "sr=3"
:: If update available install parameters.
:: Overwrite = 1
:: Reinstall = 2
::       Ask = 3
:: --------------------
set "um=1"
:: If exist delete microsoft store version of spotify.
::  True = 1
::   Ask = 3
:: --------------------
set "po=1"
:: Remove podcasts from homepage.
::  True = 1
:: False = 2
::   Ask = 3
:: --------------------
set "bu=1"
:: Block spotify automatic updates.
::  True = 1
:: False = 2
::   Ask = 3
:: --------------------
set "ca=2"
:: Enable cache clearing.
::  True = 1
:: False = 2
::   Ask = 3
:: --------------------

:: //Other//
set "pr=2"
:: If have a premium account.
::  True = 1
:: False = 2
:: --------------------
set "ss=1"
:: Start spotify when script is finished.
::  True = 1
:: False = 2
:: --------------------
set "ns=2"
:: Not add spotify shortcut to desktop. (Only for when using SpotX)
::  True = 1
:: False = 2
:: --------------------

:: //Features//
:: https://github.com/SpotX-CLI/SpotX-Win/discussions/50
set "mdf=0"
:: Enable made for you buton.
:: Default = 0
::    True = 1
::   False = 2
:: --------------------
set "els=0"
:: Enable enhance liked songs feature.
:: Default = 0
::    True = 1
::   False = 2
:: --------------------
set "nap=0"
:: Enable new discography on artist.
:: Default = 0
::    True = 1
::   False = 2
:: --------------------
set "nl=0"
:: Enable new lyrics.
:: Default = 0
::    True = 1
::   False = 2
:: --------------------
set "iir=0"
:: Enable exception playlists from recommendations.
:: Default = 0
::    True = 1
::   False = 2
:: --------------------
set "hci=0"
:: Enable icon of collaborations in playlists.
:: Default = 0
::    True = 1
::   False = 2
:: --------------------
set "eq=0"
:: Enable built-in equalizer.
:: Default = 0
::    True = 1
::   False = 2
:: --------------------
set "dp=0"
:: Return the old device picker.
:: Default = 0
::    True = 1
::   False = 2
:: --------------------
set "na=0"
:: Return the old interface.
:: Default = 0
::    True = 1
::   False = 2
:: --------------------
set "ls=0"
:: Enable new right sidebar.
:: Default = 0
::    True = 1
::   False = 2
:: --------------------

set "t=3"
set "end=0"
if exist "%temp%\LSU\" (rd /s /q "%temp%\LSU\" >nul 2>&1)
if not exist "%temp%\LSU\" (md "%temp%\LSU\" >nul 2>&1)
if "%spo-del%"=="1" call :spo-del
if "%spi-del%"=="1" call :spi-del
if "%spx-del%"=="1" call :spx-del
if "%spo-ins%"=="1" call :spo-ins
if "%spi-ins%"=="1" call :spi-ins
if "%spx-ins%"=="1" call :spx-ins
if exist "%temp%\LSU\" (rd /s /q "%temp%\LSU\" >nul 2>&1)
if "%spo-del%"=="1" (set "end=1")
if "%spo-ins%"=="1" (set "end=1")
if "%spi-del%"=="1" (set "end=1")
if "%spi-ins%"=="1" (set "end=1")
if "%spx-del%"=="1" (set "end=1")
if "%spx-ins%"=="1" (set "end=1")
if "%end%"=="0" (
echo; [97m
echo ----------------------------------------------------------------------
echo Scripti çalıştırmadan önce not defteri ile açarak config'i düzenleyin.
echo ----------------------------------------------------------------------)
echo; & echo Çıkmak için herhangi bir tuşa basın... & pause >nul 2>&1
exit /b

:spo-ins
cls
echo; [97m& echo Spotify Install: Starting
if not "%force%"=="1" (if exist "%appdata%\Spotify\Spotify.exe" (echo; & echo Spotify zaten yüklü. & echo; & echo Spotify Install: Done & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
if "%manuel%"=="1" (echo; & echo Spotify^'ı yüklemeniz bekleniyor & echo; & echo Devam etmek için herhangi bir tuşa basın... & pause >nul 2>&1 & echo; & echo Spotify Install: Done & timeout /t %t% /nobreak >nul 2>&1 & exit /b)
call :stp
if exist "%temp%\LSU\SpotifySetup.exe" (del /s /q "%temp%\LSU\SpotifySetup.exe" >nul 2>&1)
powershell.exe -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;(New-Object System.Net.WebClient).DownloadFile('https://download.scdn.co/SpotifySetup.exe','%temp%\LSU\SpotifySetup.exe')
start /b /w "SpotifySetup" "%temp%\LSU\SpotifySetup.exe" /silent >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1
if exist "%temp%\LSU\SpotifySetup.exe" (del /s /q "%temp%\LSU\SpotifySetup.exe" >nul 2>&1)
echo; & echo Spotify Install: Done
timeout /t %t% /nobreak >nul 2>&1
exit /b

:spo-del
cls
echo; [97m& echo Spotify Uninstall: Starting
if not "%force%"=="1" (if not exist "%appdata%\Spotify\Spotify.exe" (echo; & echo Spotify yüklü değil, kaldırılamaz. & echo; & echo Spotify Uninstall: Done & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
call :stp
if "%backup%"=="1" (
xcopy "%appdata%\Spotify\Users\" "%temp%\LSU\Users\" /i /s /y >nul 2>&1
xcopy "%appdata%\Spotify\prefs.*" "%temp%\LSU\" /y >nul 2>&1)
if exist "%localappdata%\Spotify\Update" (icacls "%localappdata%\Spotify\Update" /reset /t >nul 2>&1)
if exist "%appdata%\Spotify\Spotify.exe" (start /b /w "SpotifyUninstall" "%appdata%\Spotify\Spotify.exe" /uninstall /silent)
timeout /t 1 /nobreak >nul 2>&1
if exist "%appdata%\Spotify" (rd /s /q "%appdata%\Spotify" >nul 2>&1)
if exist "%localappdata%\Spotify" (rd /s /q "%localappdata%\Spotify" >nul 2>&1)
if exist "%temp%\SpotifyUninstall.exe" (del /s /q  "%temp%\SpotifyUninstall.exe" >nul 2>&1)
if exist "%userprofile%\Desktop\Spotify.lnk" (del /s /q "%userprofile%\Desktop\Spotify.lnk" >nul 2>&1)
if "%backup%"=="1" (
xcopy "%temp%\LSU\Users\" "%appdata%\Spotify\Users\" /i /s /y >nul 2>&1
xcopy "%temp%\LSU\" "%appdata%\Spotify\prefs.*" /y >nul 2>&1)
echo; & echo Spotify Uninstall: Done
timeout /t %t% /nobreak >nul 2>&1
exit /b

:spi-ins
cls
echo; [97m& echo Spicetify Install: Starting
if not "%force%"=="1" (if not exist "%appdata%\Spotify\Spotify.exe" (echo; & echo Spotify yüklü değil, Spicetify yüklenemez. & echo; & echo Spicetify Install: Done & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
if not "%force%"=="1" (if exist "%localappdata%\spicetify\spicetify.exe" (echo; & echo Spicetify zaten yüklü. & echo; & echo Spicetify Install: Done & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
call :stp
echo;
powershell.exe -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;iwr -useb https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.ps1 ^| iex;iwr -useb https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.ps1 ^| iex;spicetify apply
echo; & echo Spicetify Install: Done
timeout /t %t% /nobreak >nul 2>&1
exit /b

:spi-del
cls
echo; [97m& echo Spicetify Uninstall: Starting
if not "%force%"=="1" (if not exist "%localappdata%\spicetify\spicetify.exe" (echo; & echo Spicetify yüklü değil, kaldırılamaz. & echo; & echo Spicetify Uninstall: Done & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
if exist "%appdata%\Spotify\Spotify.exe" (powershell.exe -ExecutionPolicy Bypass -Command spicetify restore apply)
call :stp
if exist "%appdata%\spicetify\" (rd /s /q "%appdata%\spicetify" >nul 2>&1)
if exist "%localappdata%\spicetify\" (rd /s /q "%localappdata%\spicetify" >nul 2>&1)
echo; & echo Spicetify Uninstall: Done
timeout /t %t% /nobreak >nul 2>&1
exit /b

:spx-ins
cls
echo; [97m& echo SpotX Install: Starting
if not "%force%"=="1" (if not exist "%appdata%\Spotify\Spotify.exe" (echo; & echo Spotify yüklü değil, SpotX yüklenemez. & echo; & echo SpotX Install: Done & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
if not "%force%"=="1" (if exist "%appdata%\Spotify\Spotify.bak" (echo; & echo SpotX zaten yüklü. & echo; & echo SpotX Install: Done & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
if "%sr%"=="1" (set "sr=-confirm_spoti_recomended_over")
if "%sr%"=="2" (set "sr=-confirm_spoti_recomended_unistall")
if "%sr%"=="3" (set "sr=")
if "%um%"=="1" (set "um=-confirm_uninstall_ms_spoti")
if "%um%"=="3" (set "um=")
if "%po%"=="1" (set "po=-podcasts_off")
if "%po%"=="2" (set "po=-podcasts_on")
if "%po%"=="3" (set "po=")
if "%bu%"=="1" (set "bu=-block_update_on")
if "%bu%"=="2" (set "bu=-block_update_off")
if "%bu%"=="3" (set "bu=")
if "%ca%"=="1" (set "ca=-cache_on 7")
if "%ca%"=="2" (set "ca=-cache_off")
if "%ca%"=="3" (set "ca=")
:: ----------------------------------
if "%pr%"=="1" (set "pr=-premium")
if "%pr%"=="2" (set "pr=")
if "%ss%"=="1" (set "ss=-start_spoti")
if "%ss%"=="2" (set "ss=")
if "%ns%"=="1" (set "ns=-no_shortcut")
if "%ns%"=="2" (set "ns=")
:: ----------------------------------
if "%mdf%"=="0" (set "mdf=")
if "%mdf%"=="1" (set "mdf=-made_for_you_on")
if "%mdf%"=="2" (set "mdf=-made_for_you_off")
if "%els%"=="0" (set "els=")
if "%els%"=="1" (set "els=-enhance_like_on")
if "%els%"=="2" (set "els=-enhance_like_off")
if "%nap%"=="0" (set "nap=")
if "%nap%"=="1" (set "nap=-new_artist_pages_on")
if "%nap%"=="2" (set "nap=-new_artist_pages_off")
if "%nl%"=="0" (set "nl=")
if "%nl%"=="1" (set "nl=-new_lyrics_on")
if "%nl%"=="2" (set "nl=-new_lyrics_off")
if "%iir%"=="0" (set "iir=")
if "%iir%"=="1" (set "iir=-ignore_in_recommendations_on")
if "%iir%"=="2" (set "iir=-ignore_in_recommendations_off")
if "%hci%"=="0" (set "hci=")
if "%hci%"=="1" (set "hci=-hide_col_icon_on")
if "%hci%"=="2" (set "hci=-hide_col_icon_off")
if "%eq%"=="0" (set "eq=")
if "%eq%"=="1" (set "eq=-equalizer_on")
if "%eq%"=="2" (set "eq=-equalizer_off")
if "%dp%"=="0" (set "dp=")
if "%dp%"=="1" (set "dp=-device_picker_old")
if "%dp%"=="2" (set "dp=-device_picker_new")
if "%na%"=="0" (set "na=")
if "%na%"=="1" (set "na=-navalt_on")
if "%na%"=="2" (set "na=-navalt_off")
if "%ls%"=="0" (set "ls=")
if "%ls%"=="1" (set "ls=-left_sidebar_on")
if "%ls%"=="2" (set "ls=-left_sidebar_off")
call :stp
echo;
powershell.exe -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;"""""& { $(iwr -useb 'https://raw.githubusercontent.com/SpotX-CLI/SpotX-Win/main/Install.ps1')} %sr% %um% %po% %bu% %ca% %mdf% %els% %nap% %nl% %iir% %hci% %eq% %dp% %na% %ls% %pr% %ss% %ns% """" | iex"
if "%ink%"=="0" (del /s /q "%userprofile%\Desktop\Spotify.lnk" >nul 2>&1)
echo; & echo SpotX Install: Done
timeout /t %t% /nobreak >nul 2>&1
exit /b

:spx-del
cls
echo; [97m& echo SpotX Uninstall: Starting 
if not "%force%"=="1" (if not exist "%appdata%\Spotify\Spotify.bak" (echo; & echo SpotX yüklü değil, kaldırılamaz. & echo; & echo SpotX Uninstall: Done & timeout /t %t% /nobreak >nul 2>&1 & exit /b))
call :stp
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
echo; & echo SpotX Uninstall: Done
timeout /t %t% /nobreak >nul 2>&1
exit /b

:stp
if not "%force%"=="1" (if not exist "%appdata%\Spotify\Spotify.exe" (echo; & echo Spotify bulunamadı durdurulamaz. & exit /b))
tasklist | find "Spotify.exe" >nul 2>&1
if "%errorlevel%" EQU "1" (echo; & echo Spotify zaten durdurulmuş.)
if "%errorlevel%" NEQ "1" (echo; & echo Spotify durduruluyor... & taskkill /f /im "Spotify.exe" >nul 2>&1 & timeout /t 1 /nobreak >nul 2>&1 & call :stp_chk)
exit /b

:stp_chk
tasklist | find "Spotify.exe" >nul 2>&1
if "%errorlevel%" EQU "1" (echo Spotify başarıyla durduruldu.)
if "%errorlevel%" NEQ "1" (echo Spotify durdurulamadı.)
exit /b
