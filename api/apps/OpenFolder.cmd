@echo off
SET VersionInteger=1.01
SET Version=Stable v%VersionInteger%
SET Title=OpenFolder                                                        %Version%
SET ErrorTitle=OpenFolder Error                                                 %Version%
Title=OpenFolder - %Version%
if "%1"=="" (
goto Welcome
) else (
goto OpenFolder
)
:Welcome
cls
echo %Title%
call %Wave%\libs\UI.cmd,TitleBar
echo This tiny Wave webapp opens a specific folder on the PC it is run on, if
echo it exists, of course. 
echo.
echo Run this with the argument of the folder you want to open. If the folder
echo doesn't exist, we'll let you know.
echo.
echo Example: Wave:,OpenFolder,23,%%ProgramFiles%%
echo will open the %%ProgramFiles%% folder
echo.
echo Tip! Use %%Username%% for stuff like C:\Users\%%Username%%\Documents for
echo example so that you can open up the "Documents" folder on the current user
echo even if you don't know the username.
echo.
pause
exit
:OpenFolder
if not exist "%1" (
cls
echo %ErrorTitle%
call %Wave%\libs\UI.cmd,TitleBar
echo Whoops! I couldn't find the folder or directory:
echo %1
echo ...so I was unable to open it.
pause
exit
) else (
start explorer.exe %1
exit
)