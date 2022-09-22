@echo off
setlocal enabledelayedexpansion
chcp 65001
title LSU V0.5
cls

rem //Changelog// 
:: Kod en baştan yeniden yazıldı.
:: Update,Force,Limiters seçenekleri ve StpChk özelliği kaldırıldı.
:: SpotX manuel kaldırıldı.
:: SpotX auto config eklendi.
rem /////////////

rem ////Warn////
:: Yönetici olarak çalıştırmayın, Spotify installer çalışmayacaktır.
:: Çalıştırmadan önce antivürüsü kapatın False Positive olarak algılanabilir.
:: Virüslü olması olası değildir, Github'ta açık kaynak kodları bulunmakta bütün scriptlerin.
rem ////////////

rem //Websites//
:: Spotify -> https://www.spotify.com/download/windows
:: Spicetify -> https://github.com/spicetify/spicetify-cli
:: SpotX -> https://github.com/amd64fox/SpotX  #Spotify Versions# -> https://cutt.ly/8EH6NuH
rem ////////////

rem ///Config///
:: Spotify'ı siler.
:: Valid: 0 - 1
set "spo-del=0"
rem ////////////
:: Spotify'ı yükler.
:: Valid: 0 - 1
set "spo-ins=0"
rem ////////////
:: Spicetify'ı siler.
:: Valid: 0 - 1
set "spi-del=0"
rem ////////////
:: Spicetify'ı yükler.
:: Valid: 0 - 1
set "spi-ins=0"
rem ////////////
:: SpotX'i siler.
:: Valid: 0 - 1
set "spx-del=0"
rem ////////////
:: SpotX'i yükler.
:: Valid: 0 - 1
set "spx-ins=0"
rem ////////////
:: Silme işlemleri yükleme işlemlerinden önce çalışır.

rem //General//
:: Spotify silinirken kullanıcı giriş bilgilerini yedekler, Spotify tekrar yüklendiğinde otomatik giriş yapar.
:: Spotify'ı sil ile birlikte kullanılması gerekir.
:: Oturum açmada sorun çıkarsa backup'ı kapatıp tekrar deneyin.
:: Valid: 0 - 1
set "backup=1"
rem ///////////
:: Geçişler arasında ki bekleme süresini ayarlar.
:: Valid: 0 - 9999
set "to=3"
rem ///////////

rem //SpotXConfig//
:: 0 -> Don't remove podcasts from homepage.
:: 1 -> Remove podcasts from homepage.
set "pd=0"
rem ///////////////
:: 0 -> Don't block Spotify automatic updates.
:: 1 -> Block Spotify automatic updates.
set "bu=1"
rem ///////////////
:: 0 -> Don't enable cache clearing.
:: 1 -> Enable clear cache.
set "ch=0"
rem ///////////////
:: 0 -> Do nothing.
:: 1 -> If an outdated or unsupported version of Spotify is found, the recommended version will automatically be installed over it.
:: 2 -> If an outdated or unsupported version of Spotify is found, it will be automatically uninstalled and the recommended version will be installed.
set "csr=0"
rem ///////////////
:: 0 -> Do nothing.
:: 1 -> Automatic uninstallation of Microsoft Store Version Spotify if it was found.
set "ums=1"
rem ///////////////
:: 0 -> Do nothing.
:: 1 -> Automatic launch of Spotify after installation is complete.
set "ss=1"
rem ///////////////
:: 0 -> Do nothing.
:: 1 -> Installation without ad blocking for premium accounts.
set "pm=0"
rem ///////////////

if exist "%temp%\LSU\" (rd /s /q "%temp%\LSU\")
if not exist "%temp%\LSU\" (md "%temp%\LSU\")
if "%spo-del%"=="1" call :spo-del
if "%spi-del%"=="1" call :spi-del
if "%spx-del%"=="1" call :spx-del
if "%spo-ins%"=="1" call :spo-ins
if "%spi-ins%"=="1" call :spi-ins
if "%spx-ins%"=="1" call :spx-ins
if exist "%temp%\LSU\" (rd /s /q "%temp%\LSU\")

set "end=0"
if "%spo-del%"=="1" (set "end=1")
if "%spo-ins%"=="1" (set "end=1")
if "%spi-del%"=="1" (set "end=1")
if "%spi-ins%"=="1" (set "end=1")
if "%spx-del%"=="1" (set "end=1")
if "%spx-ins%"=="1" (set "end=1")

if "%end%"=="0" (
echo; [97m
echo ----------------------------------------------------------------------
echo Dosyayı çalıştırmadan önce not defteri ile açarak config'i düzenleyin.
echo ----------------------------------------------------------------------)

echo; & echo Çıkmak için herhangi bir tuşa basın... & pause >nul 2>&1
exit /b

:spo-ins
cls
echo; [97m& echo Spotify Install: Starting
if exist "%appdata%\Spotify\Spotify.exe" (echo; & echo Spotify zaten yüklü. & echo; & echo Spotify Install: Done & timeout /t %to% /nobreak >nul 2>&1 & exit /b)
call :stp
if exist "%temp%\LSU\SpotifySetup.exe" (del /s /q "%temp%\LSU\SpotifySetup.exe")
powershell.exe -ExecutionPolicy Bypass -Command (new-object System.Net.WebClient).DownloadFile('https://download.scdn.co/SpotifySetup.exe','%temp%\LSU\SpotifySetup.exe')
start /b /wait "Spotify Setup" "%temp%\LSU\SpotifySetup.exe"
timeout /t 1 /nobreak >nul 2>&1
if exist "%temp%\LSU\SpotifySetup.exe" (del /s /q "%temp%\LSU\SpotifySetup.exe")
echo; & echo Spotify Install: Done
timeout /t %to% /nobreak >nul 2>&1
exit /b

:spo-del
cls
echo; [97m& echo Spotify Uninstall: Starting
if not exist "%appdata%\Spotify\Spotify.exe" (echo; & echo Spotify yüklü değil, kaldırılamaz. & echo; & echo Spotify Uninstall: Done & timeout /t %to% /nobreak >nul 2>&1 & exit /b)
call :stp
if "%backup%"=="1" (
xcopy "%appdata%\Spotify\Users\" "%temp%\LSU\Users\" /i /s /y >nul 2>&1
xcopy "%appdata%\Spotify\prefs.*" "%temp%\LSU\" /y >nul 2>&1)
if exist "%localappdata%\Spotify\Update" (icacls "%localappdata%\Spotify\Update" /reset /t >nul 2>&1)
if exist "%appdata%\Spotify\Spotify.exe" (start /b /wait "" "%appdata%\Spotify\Spotify.exe" /UNINSTALL /SILENT)
timeout /t 1 /nobreak >nul 2>&1
if exist "%appdata%\Spotify" (rd /s /q "%appdata%\Spotify" >nul 2>&1)
if exist "%localappdata%\Spotify" (rd /s /q "%localappdata%\Spotify" >nul 2>&1)
if exist "%temp%\SpotifyUninstall.exe" (del /s /q  "%temp%\SpotifyUninstall.exe" >nul 2>&1)
if exist "%userprofile%\Desktop\Spotify.lnk" (del /s /q "%userprofile%\Desktop\Spotify.lnk" >nul 2>&1)
if "%backup%"=="1" (
xcopy "%temp%\LSU\Users\" "%appdata%\Spotify\Users\" /i /s /y >nul 2>&1
xcopy "%temp%\LSU\" "%appdata%\Spotify\prefs.*" /y >nul 2>&1)
echo; & echo Spotify Uninstall: Done
timeout /t %to% /nobreak >nul 2>&1
exit /b

:spi-ins
cls
echo; [97m& echo Spicetify Install: Starting
if not exist "%appdata%\Spotify\Spotify.exe" (echo; & echo Spotify yüklü değil, Spicetify yüklenemez. & echo; & echo Spicetify Install: Done & timeout /t %to% /nobreak >nul 2>&1 & exit /b)
if exist "%localappdata%\spicetify\spicetify.exe" (echo; & echo Spicetify zaten yüklü. & echo; & echo Spicetify Install: Done & timeout /t %to% /nobreak >nul 2>&1 & exit /b)
call :stp
echo;
powershell.exe -ExecutionPolicy Bypass -Command iwr -useb 'https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.ps1' ^| iex;iwr -useb 'https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.ps1' ^| iex;spicetify apply
echo; & echo Spicetify Install: Done
timeout /t %to% /nobreak >nul 2>&1
exit /b

:spi-del
cls
echo; [97m& echo Spicetify Uninstall: Starting
if not exist "%localappdata%\spicetify\spicetify.exe" (echo; & echo Spicetify yüklü değil, kaldırılamaz. & echo; & echo Spicetify Uninstall: Done & timeout /t %to% /nobreak >nul 2>&1 & exit /b)
if exist "%appdata%\Spotify\Spotify.exe" (powershell.exe -ExecutionPolicy Bypass -Command spicetify restore apply)
call :stp
if exist "%appdata%\spicetify\" (rd /s /q "%appdata%\spicetify")
if exist "%localappdata%\spicetify\" (rd /s /q "%localappdata%\spicetify")
echo; & echo Spicetify Uninstall: Done
timeout /t %to% /nobreak >nul 2>&1
exit /b

:spx-ins
cls
echo; [97m& echo SpotX Install: Starting
if not exist "%appdata%\Spotify\Spotify.exe" (echo; & echo Spotify yüklü değil, SpotX yüklenemez. & echo; & echo SpotX Install: Done & timeout /t %to% /nobreak >nul 2>&1 & exit /b)
if exist "%appdata%\Spotify\Spotify.bak" (echo; & echo SpotX zaten yüklü. & echo; & echo SpotX Install: Done & timeout /t %to% /nobreak >nul 2>&1 & exit /b)
if exist "%userprofile%\Desktop\Spotify.lnk" (set "ink=1") else (set "ink=0")
if "%pd%" EQU "0" (set "pd=-podcasts_on")
if "%pd%" EQU "1" (set "pd=-podcasts_off")
if "%bu%" EQU "0" (set "bu=-block_update_off")
if "%bu%" EQU "1" (set "bu=-block_update_on")
if "%ch%" EQU "0" (set "ch=-cache_off")
if "%ch%" EQU "1" (set "ch=-cache_on")
if "%ss%" EQU "0" (set "ss=")
if "%ss%" EQU "1" (set "ss=-start_spoti")
if "%pm%" EQU "0" (set "pm=")
if "%pm%" EQU "1" (set "pm=-premium")
if "%csr%" EQU "0" (set "csr=")
if "%csr%" EQU "1" (set "csr=-confirm_spoti_recomended_over")
if "%csr%" EQU "2" (set "csr=-confirm_spoti_recomended_unistall")
if "%ums%" EQU "0" (set "ums=")
if "%ums%" EQU "1" (set "ums=-confirm_uninstall_ms_spoti")
call :stp
echo;
powershell.exe -ExecutionPolicy Bypass -Command """""& { $(iwr -useb 'https://raw.githubusercontent.com/amd64fox/SpotX/main/Install.ps1')} %csr% %ums% %pd% %bu% %ch% %pm% %ss% """" | iex"
if "%ink%"=="0" (del /s /q "%userprofile%\Desktop\Spotify.lnk" >nul 2>&1)
echo; & echo SpotX Install: Done
timeout /t %to% /nobreak >nul 2>&1
exit /b

:spx-del
cls
echo; [97m& echo SpotX Uninstall: Starting 
if not exist "%appdata%\Spotify\Spotify.bak" (echo; & echo SpotX yüklü değil, kaldırılamaz. & echo; & echo SpotX Uninstall: Done & timeout /t %to% /nobreak >nul 2>&1 & exit /b)
call :stp
if exist "%Appdata%\Spotify\chrome_elf_bak.dll" (del /s /q "%Appdata%\Spotify\chrome_elf.dll" >nul 2>&1 & move "%Appdata%\Spotify\chrome_elf_bak.dll" "%Appdata%\Spotify\chrome_elf.dll" >nul 2>&1)
if exist "%Appdata%\Spotify\Spotify.bak" (del /s /q "%Appdata%\Spotify.exe" >nul 2>&1 & move "%Appdata%\Spotify\Spotify.bak" "%Appdata%\Spotify\Spotify.exe" >nul 2>&1)
if exist "%Appdata%\Spotify\config.ini" (del /s /q "%Appdata%\Spotify\config.ini" >nul 2>&1)
if exist "%Appdata%\Spotify\Apps\xpui.bak" (del /s /q "%Appdata%\Spotify\Apps\xpui.spa" >nul 2>&1 & move "%Appdata%\Spotify\Apps\xpui.bak" "%Appdata%\Spotify\Apps\xpui.spa" >nul 2>&1)
if exist "%Appdata%\Spotify\Apps\xpui\xpui.js.bak" (del /s /q "%Appdata%\Spotify\Apps\xpui\xpui.js" >nul 2>&1 & move "%Appdata%\Spotify\Apps\xpui\xpui.js.bak" "%Appdata%\Spotify\Apps\xpui\xpui.js" >nul 2>&1)
if exist "%Appdata%\Spotify\Apps\xpui\xpui.css.bak" (del /s /q "%Appdata%\Spotify\Apps\xpui\xpui.css" >nul 2>&1 & move "%Appdata%\Spotify\Apps\xpui\xpui.css.bak" "%Appdata%\Spotify\Apps\xpui\xpui.css" >nul 2>&1)
if exist "%Appdata%\Spotify\Apps\xpui\licenses.html.bak" (del /s /q "%Appdata%\Spotify\Apps\xpui\licenses.html" >nul 2>&1 & move "%Appdata%\Spotify\Apps\xpui\licenses.html.bak" "%Appdata%\Spotify\Apps\xpui\licenses.html" >nul 2>&1)
if exist "%Appdata%\Spotify\Apps\xpui\i18n\ru.json.bak" (del /s /q "%Appdata%\Spotify\Apps\xpui\i18n\ru.json" >nul 2>&1 & move "%Appdata%\Spotify\Apps\xpui\i18n\ru.json.bak" "%Appdata%\Spotify\Apps\xpui\i18n\ru.json" >nul 2>&1)
if exist "%Appdata%\Spotify\blockthespot_log.txt" (del /s /q "%Appdata%\Spotify\blockthespot_log.txt" >nul 2>&1)
if exist "%Appdata%\Spotify\cache" (
rd /s /q %Appdata%\Spotify\cache >nul 2>&1
set Esc_LinkDest=%userprofile%\Desktop\Spotify.lnk
set Esc_LinkTarget=%Appdata%\Spotify\Spotify.exe
set Esc_WorkLinkTarget=%Appdata%\Spotify\
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
timeout /t %to% /nobreak >nul 2>&1
exit /b

:stp
tasklist | find "Spotify.exe" >nul 2>&1
if "%errorlevel%"=="0" (echo; & echo Spotify durduruluyor... & taskkill /f /im Spotify.exe >nul 2>&1 & taskkill /f /im SpotifyWebHelper.exe >nul 2>&1) else (echo; & echo Spotify zaten durdurulmuş.)
exit /b
