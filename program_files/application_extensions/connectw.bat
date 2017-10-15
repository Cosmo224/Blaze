REM Blaze Connect Example Application Extension

REM 8-28-2017
REM Version 1.0

if %1=HTTP goto :starthttp
if %1=HTTPS goto :starthttps
:starthttp
start http://%2
:starthttps
start https://%2