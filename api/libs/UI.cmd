@echo off

if "%1"=="TitleBar" (
  echo ===============================================================================
  echo.
  goto:eof
  )
if "%1"=="SubTitleBar" (
  echo -------------------------------------------------------------------------------
  echo.
  goto:eof
  )
if "%1"=="ErrorTitleBar" (
  echo *******************************************************************************
  echo.
  goto:eof
  )
if "%1"=="Wbusy" (
  start %Wave%\libs\Wbusy.exe %2 %3 /marquee
  goto:eof
  )
:Help
echo Wave UI Library
echo ===============================================================================
echo.
echo Usage: call %%Wave%%\libs\UI.cmd (Title/SubTitle/ErrorTitle/Wbusy)
echo.
echo Examples:
echo - call %%Wave%%\libs\UI.cmd,TitleBar
echo - call %%Wave%%\libs\UI.cmd,SubTitleBar
echo - call %%Wave%%\libs\UI.cmd,ErrorTitleBar
echo - call %%Wave%%\libs\UI.cmd,Wbusy,"Title","Text"
echo - call %%Wave%%\libs\Wbusy.exe,"Title",/stop
echo.
pause
goto:eof
