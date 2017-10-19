@echo off
cls
if %1==kickstart goto menu
:menu
color
cls
title Blaze Application Manager %version%
cls
echo Blaze Application Manager %version%
echo Menu
echo 1) Launch applications
echo 2) Manage applications
echo 3) View application information
set /p choice7=
if %choice7%==1 goto :app_launch
if %choice7%==2 goto :app_manage
if %choice7%==3 goto :view_app_info

:app_launch
cd program_files
dir /b
echo Choose an application to launch
set /p applaunch=

goto get_metadata

:get_metadata
REM get app metadata
cd %applaunch%
cd metadata
set /p appname=<appname.blaze
set /p appdesc=<appdesc.blaze
set /p minimumversion=<appminimum.blaze
set /p minimumapiver=<apiminimum.blaze
set /p author=<author.blaze
set /p appversion=<appversion.blaze
REM set /p systemcompatible=<systemcompatible.blaze
cd..
cd..
set /a apiversion=%apiversion%
if %apiversion% lss %minimumapiver% goto not_compatible_api
if %version% lss %minimumversion% goto not_compatible#
goto call_application
:not_compatible
echo Fatal Error
echo This application requires a newer version of Blaze. (%version% vs %minimumversion%)
echo Press any key to abort startup...
pause >nul
goto menu
:not_compatible_api
echo Fatal Error
echo This application requires a newer version of the Blaze API. (%version% vs %minimumapiver%)
echo Press any key to abort
:call_application
cd %applaunch%
title %appname% %appversion% - %appdesc%
call index.bat
:app_manage
title Blaze Application Manager - Manage Applications
echo 1) Delete Application
echo 2) Delete All Applications
echo 3) Create Dummy Metadata (if the metadata gets corrupted)

set /p managechoice=
if %managechoice%==1 goto delete_app
if %managechoice%==2 goto delete_all
if %managechoice%==3 goto dummy_metadata


goto :app_manage

:delete_app
cd program_files
dir /b

echo Which app to delete?

set /p deletechoice=

cd %deletechoice%
del *.*
rd /s /q *.*
cd..
cd..
echo Deletion complete.
pause >nul
goto menu
:delete_all
cd..
cd program_files
color 0d
echo Warning
echo All applications will be removed. 
echo Are you sure? (y/n)
set /p areyousure=
if %areyousure%=y goto delete_all_apps
if %areyousure%=n goto menu 
color 00
:delete_all_apps
del *.*
rd /s /q *.*
color
echo Done.
cd..
goto menu
:dummy_metadata
echo Metadata Creator
echo This will create dummy metadata for an app. Use this if an app's metadata gets corrupted.
cd program_files
dir /b
echo Select an app to create dummy metadata for
set /p metadata=
cd %metadata%
cd metadata
echo Application > appname.blaze
echo Description > appdesc.blaze
echo 1 > appminimum.blaze
echo 1 > apiminimum.blaze
echo Blaze Dummy Metadata Creator/Application Rescuer > author.blaze
echo 1.0 > appversion.blaze

echo Done!
pause >nul
goto menu

:view_app_info
echo View Application Info
cd program_files
dir /b
echo Choose an application to view the information of.
set /p file_info=
cd %file_info%
cd metadata
echo Application Name:
type appname.blaze
echo Application Description:
type appdesc.blaze
echo Minimum Blaze version required:
type appminimum.blaze
echo Minimum API version required:
type apiminimum.blaze
echo Application Author:
type author.blaze
echo Application Version:
type appversion.blaze
echo Press any key to go back...
pause >nul
goto menu
