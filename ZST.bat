@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title ZPAQ Smart Toolkit by Aevitas

:: === Disclaimer ===
cls
echo ========================================================
echo            WARNING: USE AT YOUR OWN RISK
echo --------------------------------------------------------
echo This compression tool can heavily use CPU and RAM.
echo On some systems, it may cause freezing, lag, or crashes.
echo(
echo The creator (Aevitas) is NOT responsible for any
echo data loss, system damage, or hardware issues.
echo( 
echo By using this tool, you accept full responsibility.
echo ========================================================
pause

:: === COMPRESSED FORMATS TO FLAG ===
set "compressed_ext=jpg jpeg png gif mp4 mkv webm mp3 ogg flac wav zip rar 7z zpaq iso pdf docx pptx xlsx exe dll bin"

:: === Hardware Detection (PowerShell) ===
cls
echo Detecting system hardware...

:: CPU Name
for /f "usebackq tokens=*" %%A in (`powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"`) do set "cpu=%%A"

:: Thread Count
for /f "usebackq tokens=*" %%A in (`powershell -NoProfile -Command "(Get-CimInstance Win32_Processor | Measure-Object -Property NumberOfLogicalProcessors -Sum).Sum"`) do set "threads=%%A"

:: RAM in MB
for /f "usebackq tokens=*" %%A in (`powershell -NoProfile -Command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1MB)"`) do set "ramMB=%%A"

:: ==== Show values or warn (safe) ====
setlocal enabledelayedexpansion
echo(
echo ======== Detected Hardware ========
if defined cpu (
    echo CPU    : !cpu!
) else (
    echo CPU    : [UNKNOWN]
)
if defined threads (
    echo Cores  : !threads!
) else (
    echo Cores  : [UNKNOWN]
)
if defined ramMB (
    echo RAM    : !ramMB! MB
) else (
    echo RAM    : [UNKNOWN]
)
echo ===================================
endlocal



:: === Set Smart Defaults Based on Threads and RAM ===
setlocal enabledelayedexpansion
set "method=1"
set "zthreads=1"

if defined threads if defined ramMB (
    if !threads! GEQ 8 if !ramMB! GEQ 8000 (
        set "method=3"
        set "zthreads=2"
    )
    if !threads! GEQ 12 if !ramMB! GEQ 16000 (
        set "method=5"
        set "zthreads=4"
    )
)

echo(
echo ====== Recommended Settings ======
echo Compression method : !method!
echo Thread count       : !zthreads!
echo ==================================
echo(
choice /m "Do you want to override these settings?"
if errorlevel 2 (
    endlocal & set "method=%method%" & set "zthreads=%zthreads%" & goto settings_applied
)

:: === Manual Override ===
echo(
echo WARNING: Choosing overly high settings on low-end systems
echo may cause crashes, freezing, or system instability.
echo Proceed with caution.
echo(
set /p "method=Enter compression method (0-5): "
set /p "zthreads=Enter number of threads to use: "
endlocal & set "method=%method%" & set "zthreads=%zthreads%"

:settings_applied
echo(
echo Final settings:
echo -method %method%
echo -threads %zthreads%
pause

:: === DRAG & DROP MODE ===
if not "%~1"=="" (
    echo === Drag and drop detected ===
    set "targets=%*"
    goto analyze
)

:mainmenu
cls
echo =============================================
echo  ZPAQ SMART TOOLKIT MENU by Aevitas (v1.1.2^)
echo =============================================
echo [1] Compress file or folder
echo [2] List archive contents
echo [3] Extract full archive
echo [4] Extract a single file
echo [5] Exit
echo =============================================
choice /c 12345 /n /m "Choose an option: "
if errorlevel 5 exit
if errorlevel 4 goto extractsingle
if errorlevel 3 goto extractfull
if errorlevel 2 goto list
if errorlevel 1 goto manualcompress

:: === MANUAL FILE/FOLDER COMPRESSION ===
:manualcompress
cls
echo === Manual Compression ===
set /p "targets=Enter path to file or folder to compress: "
if not exist "%targets%" (
    echo Target does not exist.
    pause
    goto mainmenu
)

:analyze
cls
echo Analyzing files...
set /a total=0
set /a compressed=0

:: Handle each input (dragged or manually typed)
for %%T in (%targets%) do (
    set "this=%%~fT"
    call :analyze_item "!this!"
)

if %total%==0 (
    echo No files found to analyze.
    pause
    goto mainmenu
)

set /a percent=compressed*100/total
echo -----------------------------------------
echo Total files: %total%
echo Already-compressed files: %compressed% (%percent%%)
echo -----------------------------------------

if %percent% GEQ 70 (
    echo High presence of compressed files detected.
    echo [1] Proceed with ZPAQ compression (Using -method %method% and -threads %zthreads%^)
    echo [2] Cancel
    echo [3] Archive without compression (Override method and thread settings^)
    choice /c 123 /n /m "Choose action: "
    if errorlevel 3 goto nocomp
    if errorlevel 2 goto mainmenu
    if errorlevel 1 goto compress
) else (
    goto compress
)

goto mainmenu

:: === ZPAQ COMPRESSION ===
:compress
cls
echo === ZPAQ Compression ===
:ask_archive
echo [WARNING: Naming an archive with an existing one will overwrite it^!]
set /p "archive=Enter archive name (e.g. backup.zpaq): "
if "%archive%"=="" goto ask_archive
if /i not "%archive:~-5%"==".zpaq" set "archive=%archive%.zpaq"
if exist "%archive%" (
    echo WARNING: The archive "%archive%" already exists and will be overwritten!
    choice /m "Are you sure you want to continue?"
    if errorlevel 2 goto ask_archive
)
::set "method=3"
::set "threads=2"
echo Compressing with -method %method% -threads %zthreads% ...
zpaq add "%archive%" %targets% -method %method% -threads %zthreads%
echo Done compressing.
pause
goto mainmenu

:: === ARCHIVE WITHOUT COMPRESSION ===
:nocomp
cls
set /p "archive=Enter archive name (e.g. backup.zpaq): "
if /i not "%archive:~-5%"==".zpaq" set "archive=%archive%.zpaq"
echo Archiving without compression using -method 0 ...
zpaq add "%archive%" %targets% -method 0 -threads 1
echo Done archiving with no compression.
pause
goto mainmenu

:: === LIST ARCHIVE CONTENTS ===
:list
cls
set /p "archive=Enter archive name to list: "
zpaq list "%archive%"
pause
goto mainmenu

:: === FULL EXTRACTION ===
:extractfull
cls
set /p "archive=Enter archive to extract: "
zpaq extract "%archive%"
pause
goto mainmenu

:: === SINGLE FILE EXTRACT ===
:extractsingle
cls
set /p "archive=Enter archive name: "
zpaq list "%archive%"
echo -------------------------------
set /p "file=Enter exact file path to extract: "
zpaq extract "%archive%" "%file%"
pause
goto mainmenu

:analyze_item
set "item=%~1"
if exist "%item%\" (
    :: It's a folder
    for /R "%item%" %%F in (*) do call :checkfile "%%F"
) else if exist "%item%" (
    :: It's a file
    call :checkfile "%item%"
)
exit /b


:checkfile
set "file=%~1"
set /a total+=1
set "ext=%~x1"
set "ext=!ext:~1!"
for %%E in (%compressed_ext%) do (
    if /i "!ext!"=="%%E" set /a compressed+=1
)
exit /b


