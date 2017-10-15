ver >nul | find "%1" >nul

if ERRORLEVEL 1 ( set %version%=ERRORLEVEL )
if ERRORLEVEL 0 ( set %version%=ERRORLEVEL )