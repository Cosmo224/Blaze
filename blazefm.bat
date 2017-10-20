@echo off
cls
REM BlazeFM Kickstart Protection System
if %1==kickstart goto menu

:menu
echo Blaze File Manager %version% 
echo 1) View Files
echo 2) File Control
echo 3) Exit to main menu
echo 4) Exit Blaze entirely

set /p fm_menu=
if %fm_menu%==1 goto view_files
if %fm_menu%==2 goto file_control_menu
if %fm_menu%==3 goto exit_blaze_fm
if %fm_menu%==4 goto exit_blaze_to_system
:exit_blaze_fm
call Blaze.bat
goto menu
:exit_blaze_to_system
exit
:view_files
dir
echo Press any key to return to the menu.
pause >nul
goto menu
:file_control_menu
echo File Control Menu
echo 1) File manipulation commands
echo 2) Folder manipulation commands
echo 3) Create or delete files
echo 4) Create or delete folders
echo 5) Attribute management
echo 6) View current directory
echo 7) Run Windows Program
echo 8) Change directory
echo 9) Return to main menu
set /p fc_menu=
if %fc_menu%==1 goto file_manipulation
if %fc_menu%==2 goto folder_manipulation
if %fc_menu%==3 goto create_delete_files
if %fc_menu%==4 goto create_delete_folders
if %fc_menu%==5 goto attribute_management
if %fc_menu%==6 call :view_current_directory file_control_menu
if %fc_menu%==7 goto run_windows_program
if %fc_menu%==8 goto change_directory
if %fc_menu%==9 goto menu

goto file_control_menu
:view_current_directory
cd
pause
goto %1
:file_manipulation
echo File Manipulation Menu
echo 1) Copy files
echo 2) Move files
echo 3) View current directory
echo 9) Return to File Control Menu
set /p fi_menu=
if %fi_menu%==1 goto copy_file
if %fi_menu%==2 goto move_file
if %fi_menu%==3 call :view_current_directory file_manipulation
if %fi_menu%==9 goto file_control_menu

:copy_file

echo Type the name of the file to copy (use the location of the file e.g c:/folder1/folder2/file1.txt)
set /p copy_file1=
echo Type the destination (use the location of the file e.g c:/folder3/file1.txt)
set /p copy_file2=
copy %copy_file1% %copy_file2%
echo Done!
pause >nul
goto file_control_menu

:move_file

echo Type the name of the file to move (use the location of the file e.g c:/folder1/folder2/file1.txt)
set /p move_file1=
echo Type the destination (use the location of the file e.g c:/folder3/file1.txt). The original file will be deleted.
set /p move_file2=
move %move_file1% %move_file2%
echo Done!
pause >nul
goto file_control_menu

:folder_manipulation
echo Folder Manipulation Menu
echo 1) Copy folders
echo 2) Move folders
echo 3) View current directory
echo 9) Return to File Control Menu
set /p fo_menu=
if %fo_menu%==1 goto copy_folder
if %fo_menu%==2 goto move_folder
if %fo_menu%==3 call :view_current_directory folder_manipulation
if %fo_menu%==9 goto file_control_menu

:copy_folder

echo Type the name of the folder to copy
set /p copy_folder1=
echo Type the destination
set /p copy_folder2=
xcopy /e %copy_folder1% %copy_folder2%
echo Done!
pause >nul
goto file_control_menu

:move_folder

set /p move_folder1=
echo Type the destination 
set /p move_folder2=
ROBOCOPY %move_folder1% %move_folder2% /MOVE >nul
echo Done!
pause >nul

goto file_control_menu

:create_delete_files
echo File Creation/Deletion Menu
echo 1) Create files
echo 2) Delete files
echo 3) View current directory
echo 9) Return to File Control Menu
set /p cd_menu=
if %cd_menu%==1 goto create_file
if %cd_menu%==2 goto delete_file
if %cd_menu%==3 call :view_current_directory create_delete_files
if %cd_menu%==9 goto file_control_menu

:create_file

echo Type the content of the file to create (will be created in the current directory)
set /p create_file1=
echo Type the name of the file
set /p create_file2=
echo Type the extension of the file
set /p create_file3=
echo %create_file1%>%create_file2%.%create_file3%
echo Done!
pause >nul

goto file_control_menu

:delete_file

echo Type the name of the file to delete.
set /p delete_file1=

del %delete_file1%
echo Done!
pause >nul

goto file_control_menu

:create_delete_folders
echo Folder Creation/Deletion Menu
echo 1) Create folders
echo 2) Delete folders
echo 3) View current directory
echo 9) Return to File Control Menu
set /p cf_menu=
if %cf_menu%==1 goto create_folder
if %cf_menu%==2 goto delete_folder
if %cf_menu%==3 call :view_current_directory create_delete_folders
if %cf_menu%==9 goto file_control_menu

:create_folder

echo Type the name of the folder to create
set /p create_folder1=
md %create_folder1%
echo Done!
pause >nul
goto file_control_menu

:delete_folder

echo Type the name of the folder to delete.
set /p delete_folder1=
rd %delete_folder1%
echo Done!
pause >nul
goto file_control_menu

:attribute_management
echo File Manipulation Menu
echo 1) Set read only on file
echo 2) Remove read only on file
echo 3) Set hidden on file
echo 4) Remove hidden on file
echo 5) View current directory
echo 9) Return to File Control Menu
set /p am_menu=
if %am_menu%==1 goto set_read_only_file
if %am_menu%==2 goto unset_read_only_file
if %am_menu%==3 goto set_hidden_file
if %am_menu%==4 goto unset_hidden_file
if %am_menu%==5 call :view_current_directory attribute_management
if %am_menu%==9 goto file_control_menu

:set_read_only_file

echo Type the name of the file to set read only.  
set /p set_read_only_file1=

attrib +R %set_read_only_file1% 
echo Done!
pause >nul

goto file_control_menu

:unset_read_only_file

echo Type the name of the file to unset read only. 
set /p unset_read_only_file1=
attrib -R %unset_read_only_file1%
echo Done!
pause >nul

goto file_control_menu

:set_hidden_file

echo Type the name of the file to set hidden.  
set /p set_hidden_file1=

attrib +H %set_hidden_file1%
echo Done!
pause >nul

goto file_control_menu

:unset_hidden_file

echo Type the name of the file to unset hidden.  
set /p unset_hidden_file1=

attrib -H %unset_hidden_file1%
echo Done!
pause >nul

goto file_control_menu

:run_windows_program
echo Run a Windows application. It must be on the Path. (c:/windows, c:/windows/system32 would be examples)
set /p run_windows_app=
start %run_windows_app%
goto file_control_menu 

:change_directory
echo Change Directory
echo Change the directory. Use a path.
set /p change_directory=
cd %change_directory%
echo Done!
goto file_control_menu
