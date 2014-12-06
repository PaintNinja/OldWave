@echo off
SET VersionInteger=1.01
SET Version=Stable v%VersionInteger%
SET Title=CleanCache                                                        %Version%
SET ErrorTitle=CleanCache Error                                                 %Version%
SET TitleBar================================================================================
SET SubTitleBar=-------------------------------------------------------------------------------
Title=CleanCache - %Version%
if "%1"=="" (
goto Welcome
) else (
goto CleanCache
)
:Welcome
cls
echo %Title% && echo %Titlebar%
echo.
echo This tiny Wave webapp cleans the cache for a specific webapp, or all webapps
echo if you like. 
echo.
echo Run this with the argument "-all" to clean the cache for all webapps
echo ...or...
echo Run this with the argument "#" to clean the cache for a specific webapp.
echo.
echo NOTE: Replace # with an AppID, such as 3 for example.
echo.
pause
exit
:CleanCache
if "%1"=="-all" goto CleanAllCache
cls
echo %Title% && echo %TitleBar%
echo.
echo Checking if %1 exists...
if exist %SystemDrive%\Wave\webapps\%1 (
echo %1 exists. Cleaning its cache...
rmdir /S /Q %SystemDrive%\Wave\webapps\%1
) else (
echo %1 doesn't exist!
pause
exit
)
exit
:CleanAllCache
cls
echo %Title% && echo %TitleBar%
echo.
echo Cleaning the entire cache...
rmdir /S /Q %SystemDrive%\Wave\webapps
echo.
echo Done!
pause
exit
:Changelog
exit
v1.01
---
* Updated to work with Wave v0.58

v1.00
---
First version