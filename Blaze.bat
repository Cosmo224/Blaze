@echo off
REM echo Blaze was initalized >> log.txt
REM if %1==[] goto blazeinitvars
REM if %1==debug goto debug_menu
REM if %1==jump @echo off | goto %2
REM if %1==delete_all_apps cd program_files | del *.* | rd /s /q *.* | cd..
REM if %1==delete_api cd API | del *.* | rd /s /q *.* | cd..
REM if %1==set_win_color_without_blaze color %2
REM if %1==multichain | %2 | %3 | %4 | %5 | %6 | %7 | %8 | %9
set /p version=<version.txt
set /p apiversion=<apiversion.txt
set /a blazekey=%random%
cd settings
set /p window_color=<windowcolor.blaze

color %window_color%
cd..
goto windetect
:blazeinitvars

REM title Warning

goto blazeinitvars
:windetect
title Blaze (%version%)
ver >nul | find "5.0" >nul

if ERRORLEVEL 1 goto detectxp
if ERRORLEVEL 0 goto warning

:detectxp
ver >nul | find "5.1" >nul

if ERRORLEVEL 1 goto detectvista
if ERRORLEVEL 0 goto warning

:detectvista
ver >nul | find "6.0" >nul

if ERRORLEVEL 1 goto detect7
if ERRORLEVEL 0 goto blazeinit 

:detect7
ver >nul | find "6.1" >nul

if ERRORLEVEL 1 goto detect8
if ERRORLEVEL 0 goto blazeinit 

:detect8
ver >nul | find "6.2" >nul

if ERRORLEVEL 1 goto detect81
if ERRORLEVEL 0 goto blazeinit 

:detect81
ver >nul | find "6.3" >nul

if ERRORLEVEL 1 goto detect10
if ERRORLEVEL 0 goto blazeinit 

:detect10
ver >nul | find "10.0" >nul

if ERRORLEVEL 1 goto blazeinit
if ERRORLEVEL 0 goto blazeinit 

:warning
color 0d
echo Warning - your operating system may not support all of the advanced features of Blaze. Continue?
set /p exit2=
REM so windows xp works
if %exit2%==Y goto blazeinit 
if %exit2%==N exit

:blazeinit
echo Blaze intializing...

echo Checking Blaze integrity...

:chk1
if exist API\ ( goto chk2 ) ELSE ( goto :error )


:chk2
if exist program_files\ ( goto blazemenu ) ELSE (goto :error_program_files )

:error
color 0d
echo Fatal Error
echo Blaze API is missing
echo You must reinstall Blaze (Error #0001)
echo Press any key to exit

pause >nul
exit
:error_program_files
color 0d
echo Fatal Error
echo Blaze Program Files are missing
echo You must reinstall Blaze (Error #0002)
echo Press any key to exit

pause >nul
exit
:blazemenu
cls
title Blaze %version% - API v%apiversion%
echo Blaze %version% - API v%apiversion%
echo 1) Blaze File Manager
echo 2) Blaze Application Manager
echo 3) Set Window Colour
echo 4) Exit to Windows
IF EXIST developer.blaze echo 9) Developer Tools
set /p blaze_menu=
if %blaze_menu%==1 goto blazefm
if %blaze_menu%==2 goto blazeam
if %blaze_menu%==3 goto blaze_set_window_color
if %blaze_menu%==4 goto exit_to_system
if %blaze_menu%==9 goto developer_tools

:exit_to_system
exit

echo Incorrect choice!
pause >nul
goto blazemenu
:blazefm
call blazefm.bat kickstart
goto blazemenu

:blazeam
call blazeam.bat kickstart
:developer_tools
cls
echo Blaze Developer Tools
echo 1) Create Application Template
echo 2) Delete Application
echo 3) Create Application Metadata
echo 4) Delete all .txt files
echo 5) Return to Main Menu
echo 6) Exit to Windows
set /p developer_tools=
if %developer_tools%==1 goto createapp
if %developer_tools%==2 goto delete_application
if %developer_tools%==3 goto create_app_metadata
if %developer_tools%==4 goto delete_txt_files
if %developer_tools%==5 goto menu
if %developer_tools%==6 goto exit_to_system
:delete_application
echo You can do this in BlazeAM.
pause
goto developer_tools
:create_app_metadata
cd program_files
dir /b
echo What app?
set /p appmeta=
cd %appmeta%
cd metadata
echo. > appname.blaze
echo. > appdesc.blaze
echo. > appminimum.blaze
echo. > apiminimum.blaze
echo. > author.blaze
echo. > appversion.blaze
echo Metadata created in program_files/appname/metadata/
cd..
cd..
cd..
goto developer_tools

:delete_txt_files
echo Are you sure? [Y/N]
set /p del=
if %del%==y goto delete_files
if %del%==n goto developer_tools

goto :delete_txt_files
:delete_files
echo Deleting all text files...
del *.txt
echo Done!

:createapp
echo Creating Blaze application template in /application_templates
IF EXIST application_templates/ ( cd application_templates ) ELSE ( md application_templates )
set app=%random%
echo ::Blaze Application Template>testapp_%app%.bat
echo ::for Blaze 1.0>>testapp_%app%.bat
echo :main>>testapp_%app%.bat
echo ::your application goes here. Blaze will handle the application metadata and stuff.>>testapp_%app%.bat
echo ::Make sure to read the Blaze Documentation! >>testapp_%app%.bat

echo Your filename is testapp_%app%.bat in the /application_templates/ folder. 
cd..
echo Press a key to go back.
pause >nul
goto developer_tools

:blaze_settings
REM not used after Beta1
goto :blaze_set_window_color
:blaze_set_window_color
echo Type in a CMD colour to use...
set /p set_window_color=
cd settings
echo %set_window_color%>windowcolor.blaze
cd..
echo You will need to restart to see the changes. Restart? (Y/N)
set /p blaze_set_restart=
if %blaze_set_restart%==Y goto blaze_restart
if %blaze_set_restart%==y goto blaze_restart
if %blaze_set_restart%==N goto menu
if %blaze_set_restart%==n goto menu
goto blaze_set_window_color

:blaze_restart
echo Restarting...
start Blaze.bat
exit
