@echo off
title="Launching console..."
if not exist "%AppData%\Wave" goto NoWave
:Wave
cls
if not exist %AppData%\Microsoft\Windows\Start Menu\Programs\MineCenter\MineCenter.appref-ms (
  goto NotSetup
  ) else (
  start /MAX %AppData%\Microsoft\Windows\Start Menu\Programs\MineCenter\MineCenter.appref-ms
  exit
  )
echo An unknown error occured
pause
exit
:NoWave
title="ERROR: Wave isn't installed!"
cls
echo Error: Wave isn't installed!
pause
exit
:NotSetup
title="ERROR: Not setup"
cls
echo Error: The console is not setup yet.
pause
exit
