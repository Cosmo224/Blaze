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
REM set /p display_application_name_on_startup=<displayappstart.blaze
REM set /p display_app_names=<displayappnames.blaze
REM set /p enable_change_directory=<enablecd.blaze
REM set /p enable_development_tools=<enabledevtools.blaze
REM set /p start_in_fullscreen=<startfullscreen.blaze
color %window_color%
cd..
goto windetect
:blazeinitvars

REM title Warning

goto blazeinitvars
:windetect
title Blaze (Developer Release)
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
REM if exist API\ ( goto chk1 ) ELSE ( goto :error )
REM if exist program_files\ ( goto chk2 ) ELSE (goto :error_programfiles )

goto :blazemenu
:error
color 0d
echo Fatal Error
echo Blaze API is missing
echo You must reinstall Blaze (Error #0001)
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
IF EXIST developer.blaze echo 9) Developer Tools
set /p blaze_menu=
if %blaze_menu%==1 goto blazefm
if %blaze_menu%==2 goto blazeam
if %blaze_menu%==3 goto blaze_set_window_color
if %blaze_menu%==9 goto developer_tools

echo Incorrect!
goto blazemenu
:blazefm
call blazefm.bat kickstart
goto blazemenu

:blazeam
call blazeam.bat kickstart
:developer_tools
echo Jumped to :developer_tools >> log.txt
echo Blaze Developer Tools
echo 1) Create Application Template
echo 2) Copy Application to the Blaze Program Files
echo 3) Delete Application
echo 4) Create Application Metadata
echo 5) Delete all .txt files
choice /c 12345

if ERRORLEVEL 1 goto :createapp
if ERRORLEVEL 2 goto :copyapprg
if ERRORLEVEL 3 goto :delapp
if ERRORLEVEL 4 goto :create_app_metadata
if ERRORLEVEL 5 goto :delete_txt_files

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
:debug_menu
set /p version=<version.txt
set /p apiversion=<apiversion.txt
set /a blazekey=%random%

echo Blaze Debug (Developer Release 1)
echo If your name isn't Xeno or you aren't a member of Leaf Computer, get the hell outta' here.
echo Choose an option
echo 1) Echo Blaze version
echo 2) Echo API version
echo 3) Delete API
echo 4) Delete program files
echo 5) Delete API command

choice /c 12345
if ERRORLEVEL 1 goto e1
if ERRORLEVEL 2 goto e2
if ERRORLEVEL 3 goto delapi
if ERRORLEVEL 4 goto delprg
if ERRORLEVEL 5 goto delete_api_command
:e1
echo %version%
pause
goto debug
:e2
echo %apiversion%
pause
goto debug
:delapi
cd API
del *.*
cd..
pause
goto debug
:delprg
cd program_files
del *.*
rd /s /q *.*
cd..
pause
goto debug
:delete_api_command
cd API
dir /b
echo Choose an API to delete (please don't put an extension)
set /p debug_delapi
del %debug_delapi%.bat
echo Done!
goto debug_menu
:blaze_settings
cls
echo Blaze Settings
title Blaze Settings
echo 1) Blaze Window Color
echo 2) Application Settings
REM echo 3) BlazeFM Settings
echo 3) Advanced Settings
set /p blaze_settings=
if %blaze_settings%==1 goto blaze_set_window_color
if %blaze_settings%==2 goto blaze_application_settings
REM if %blaze_settings%==3 goto blaze_file_manager_settings
if %blaze_settings%==3 goto blaze_advanced_settings

goto blaze_settings
:blaze_set_window_color
echo Type in a CMD colour to use...
set /p set_window_color=
cd settings
echo %set_window_color%>windowcolor.blaze
cd..
echo You will need to restart to see the changes. Restart?
set /p blaze_set_restart=
if %blaze_set_restart%==Y goto :blaze_restart
if %blaze_set_restart%==N goto menu
goto blaze_set_window_color

:blaze_restart
start Blaze.bat
exit
:blaze_application_settings
echo 1) Display application names
REM echo 1) Display application name on startup of application

set /p blaze_application_settings=
if %blaze_file_manager_settings%==1 goto display_app_name
REM if %blaze_file_manager_settings%==2 goto display_app_start_name

goto blaze_application_settings
:display_app_names
echo 1) Enabled
echo 2) Disabled
set /p display_app_names
if %blaze_file_manager_settings%==1 goto display_app_names_enable
if %blaze_file_manager_settings%==2 goto display_app_names_disable

goto display_app_names
:enable_change_directory 
REM cd settings
REM echo true > enablecd.blaze
REM cd..
:disable_change_directory
REM cd settings
REM echo true > enablecd.blaze
REM cd..
:blaze_advanced_settings
echo 1) Enable/disable developer tools
set /p display_developer_tools=
if %display_developer_tools%==1 goto display_developer_tools

:display_developer_tools
echo 1) Enabled
echo 2) Disabled
set /p enable_developer_tools=
if %enable_developer_tools%==1 goto enable_developer_tools
if %enable_developer_tools%==2 goto disable_developer_tools

:enable_developer_tools
cd settings
echo true > enabledevtools.blaze
cd..
goto blaze_settings

:settings_creator
IF NOT EXIST settings md settings
cd settings
echo true > displaydevtools.blaze
echo 0f > windowcolor.blaze
echo false > enablecd.blaze
echo true > disableappnames.blaze
echo true > startfullscreen.blaze
echo true > displayappstart.blaze