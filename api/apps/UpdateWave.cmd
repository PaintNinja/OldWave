@echo off
if not exist "%AppData%\Wave\libs" (
SET BINDIR="%SystemDrive%\Wave\libs"
) else (
SET BINDIR="%AppData%\Wave\libs"
)
CD /D "%BINDIR%"
SET VerificationServ=https://paintninja.github.io/Wave/api/auth
Title=Wave updater
if "%1"=="Update" (
goto Update
) else (
goto Welcome
)
:Welcome
cls
echo Wave updater
if exist "%Wave%\libs\UI.cmd" (
  call %Wave%\libs\UI.cmd,TitleBar
) else (
  echo ===
)
echo This small batch file updates Wave to the latest stable version.
echo.
echo Run this with the argument "Update" without the "" to update Wave.
echo.
pause
exit
:Update
if not exist wget.exe (
echo CRITICAL: wget not found!
pause
exit
) else (
REM Nothing here...
)
if not exist %TMP%\Wave\update mkdir %TMP%\Wave\update
call wget.exe --directory-prefix=%TMP%\Wave\update --no-check-certificate --secure-protocol=auto %VerificationServ%/updates/latest.waveupdate
if not exist %TMP%\Wave\update\latest.waveupdate (
echo CRITICAL: latest.waveupdate download failed!
pause
exit
) else (
echo All OK.
)
for /F "tokens=1-4* delims=," %%A in (%TMP%\Wave\update\latest.waveupdate) do (
   set _update-app-id=%%A
   set _update-priority=%%B
   set _update-type=%%C
   set _update-version=%%D
   set _update-dir=%%E
   goto Update2
)
echo CRITICAL: Error reading latest.waveupdate
pause
exit
:Update2
del /S /Q %TMP%\Wave\update\latest.waveupdate
if "%_update-app-id%"=="" goto Error
if "%_update-priority%"=="" goto Error
if "%_update-type%"=="" goto Error
if "%_update-version%"=="" goto Error
if "%_update-dir%"=="" goto Error
for %%i in (%_update-dir%.*) do set _update-fileext=%%~xi
rmdir /S /Q %TMP%\Wave\update\core
rmdir /S /Q %TMP%\Wave\update\libs
if not exist %TMP%\Wave\update\core mkdir %TMP%\Wave\update\core
if not exist %TMP%\Wave\update\libs mkdir %TMP%\Wave\update\libs
if "%_update-type%"=="core" call wget.exe -q --directory-prefix=%TMP%\Wave\update\core --no-check-certificate --secure-protocol=auto https://%_update-dir%
if "%_update-type%"=="lib" call wget.exe -q --directory-prefix=%TMP%\Wave\update\libs --no-check-certificate --secure-protocol=auto https://%_update-dir%
::Latest.waveupdate format
::-------------------
::appid,priority,lib/core,version,dir
::.
::appid must be 1 for Wave. It can be any valid appid. Warning! Because it is not checked with appname, you have to manually check that you have the right ID.
::priority must be "Low", "Normal", "High" or "Critical". Without the "" of course.
::lib/core specifies the type of update. For example, updating ErrorHandler.cmd would mean you would put "lib" without the "". Core is used for Wave only
::version means the new version of the lib or core.
::dir means the direct link to the updated file. It must NOT have https:// or http:// etc... and it must have a file extension INCLUDED.

:: Guide for priorities:
:: Low: Bugfixes and/or minor improvements
:: Normal: New features
:: High: Major improvements
:: Critical: Important security improvements and/or fixes
:Update3
:: TODO: Check if update successfully downloaded. Use AppID to determine the file's name and extension.
if "%_update-type%"=="core" (
set filename=Wave
set fileextension=exe
)
if "%_update-dir%"=="paintninja.github.io/Wave/api/core/Latest/Setup.exe" (
set filename=Setup
)
if not exist %TMP%\Wave\Update\core\%filename%.%fileextension% (
echo CRITICAL: %filename%.%fileextension% download failed!
pause
exit
)
:: Check if it's currently running before updating
tasklist /fi "imagename eq %filename%.%fileextension%" > nul
if errorlevel 1 (
echo Process is running - terminate it first.
taskkill /IM %filename%.%fileextension%
) else (
REM (Carry on)
)

:Update4
if not exist "%AppData%\Wave" (
goto Update4Alt
)
if "%_update-type%"=="core" del /S /Q %AppData%\Wave\core\%filename%.%fileextension%
if "%_update-type%"=="lib" del /S /Q %AppData%\Wave\libs\%filename%.%fileextension%
if "%_update-type%"=="core" robocopy "%TMP%\Wave\update\core" "%AppData%\Wave\core" /E
if "%_update-type%"=="lib" robocopy "%TMP%\Wave\update\libs" "%AppData%\Wave\libs" /E

if exist "%AppData%\Wave\core\Setup.exe" (
  start /MAX /HIGH %AppData%\Wave\core\Setup.exe
)

echo Done!
pause
exit

:Update4Alt
if "%_update-type%"=="core" del /S /Q %SystemDrive%\Wave\core\%filename%.%fileextension%
if "%_update-type%"=="lib" del /S /Q %SystemDrive%\Wave\libs\%filename%.%fileextension%
if "%_update-type%"=="core" robocopy "%TMP%\Wave\update\core" "%SystemDrive%\Wave\core" /E
if "%_update-type%"=="lib" robocopy "%TMP%\Wave\update\libs" "%SystemDrive%\Wave\libs" /E

if exist "%AppData%\Wave\core\Setup.exe" (
  start /MAX /HIGH %AppData%\Wave\core\Setup.exe
)

echo Done!
pause
exit

:Update4Alt2
if "%_update-type%"=="core" del /S /Q %Wave%\core\%filename%.%fileextension%
if "%_update-type%"=="lib" del /S /Q %Wave%\libs\%filename%.%fileextension%
if "%_update-type%"=="core" robocopy "%TMP%\Wave\update\core" "%Wave%\core" /E
if "%_update-type%"=="lib" robocopy "%TMP%\Wave\update\libs" "%Wave%\libs" /E

if exist "%Wave%\core\Setup.exe" (
  start /MAX /HIGH %Wave%\core\Setup.exe
)

echo Done!
pause
exit

:Error
echo A critical error occured.
pause
exit
