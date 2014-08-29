@echo off
SET VersionInteger=1.00
SET Version=Stable v%VersionInteger%
SET Title=CleanCache                                                        %Version%
SET ErrorTitle=Calculate Error                                                  %Version%
SET TitleBar================================================================================
SET SubTitleBar=-------------------------------------------------------------------------------
Title=CalculateMD5 - %Version%
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
if exist %AppData%\Wave\webapps\%1 (
echo %1 exists. Cleaning its cache...
rmdir /S /Q %AppData%\Wave\webapps\%1
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
rmdir /S /Q %AppData%\Wave\webapps
echo.
echo Done!
pause
exit