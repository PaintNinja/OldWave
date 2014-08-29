@echo off
SET VersionInteger=1.00
SET Version=Stable v%VersionInteger%
SET Title=CalculateMD5                                                     %Version%
SET ErrorTitle=Calculate Error                                                  %Version%
SET TitleBar================================================================================
SET SubTitleBar=-------------------------------------------------------------------------------
Title=CalculateMD5 - %Version%
call %AppData%\Wave\core\md5sums.exe -B -b -e -u %1.* >_file
for /F "tokens=1-2* delims= " %%A in (_file) do (
   set _md5=%%A
   set _filename=%%B
)
if "%_filename%"=="Unable" (
set _filename=Error
set _md5=Error
)
if "%_filename%"=="" (
set _filename=Drag a file onto CalculateMD5 first!
set _md5=
)
echo %Title%
echo %TitleBar%
echo.
echo Data: %_filename%
echo MD5: %_md5%
echo.
del _file
pause
exit