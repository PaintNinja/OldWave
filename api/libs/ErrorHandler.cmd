@echo off
SET Name=ErrorHandler for Wave
SET VersionInteger=0.50
SET Version=Alpha v%VersionInteger%
SET Title=%Name%                                            %Version%
SET ErrorTitleBar=*******************************************************************************
Title=Wave ErrorHandler

shift
if "%1"=="" goto Welcome
if "%1"=="3" goto Critical
if "%1"=="2" goto Warning

:Welcome
cls
echo %Title%
echo %ErrorTitleBar%
echo.
echo This is the error handler for Wave. This makes Wave more stable
echo and allows it to let you know when it has a problem rather than
echo just being quiet about it.
echo.
pause
goto Exit

:Critical
if "%2"=="" goto Exit
if "%2"=="InvalidID" goto Critical-InvalidID
if "%2"=="InvalidFileExtension" goto Critical-InvalidFileExtension
if "%2"=="FailedToLaunchWebapp" goto Critical-FailedToLaunchWebapp
:Warning
if "%2"=="" goto Exit
goto Exit

:Critical-InvalidID
cls
echo %Title%
echo %ErrorTitleBar%
echo CODE: 3,InvalidID
echo.
echo CRITICAL ERROR!
echo ----------------
echo.
echo The app-id specified does not match the app-name!
echo.
echo Please notify the developer about this ASAP. Thanks!
echo.
pause
goto Exit

:Critical-InvalidFileExtension
cls
echo %Title%
echo %ErrorTitleBar%
echo CODE: 3,InvalidFileExtension
echo.
echo CRITICAL ERROR!
echo ----------------
echo.
echo The file extension that the webapp uses is not
echo yet supported.
echo.
echo Please notify the developer about this ASAP. Thanks!
echo.
pause
goto Exit

:Critical-FailedToLaunchWebapp
cls
echo %Title%
echo %ErrorTitleBar%
echo CODE: 3,FailedToLaunchWebapp
echo.
echo CRITICAL ERROR!
echo ----------------
echo.
echo Wave failed to launch app-id %3.
echo.
echo It initially tried normal cloud launching, but failed. So it tried
echo launching from the cache and installed webapps folder, but nothing
echo related to app-id %3 was there. It even tried getting the latest
echo version of app-id %3's corresponding webapp and installing it,
echo but nope. That failed too. The result is this big fat descriptive
echo error message.
echo.
pause
goto Exit

:Exit
exit