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
:Help
echo Wave UI Library
echo ===============================================================================
echo.
echo Usage: call %%Wave%%\libs\UI.cmd (Title/SubTitle/ErrorTitle)
echo.
echo Examples:
echo - call %%Wave%%\libs\UI.cmd,TitleBar
echo - call %%Wave%%\libs\UI.cmd,SubTitleBar
echo - call %%Wave%%\libs\UI.cmd,ErrorTitleBar
echo.
pause
goto:eof
