
@echo off

set SHELL=%ProgramFiles%\\Git\\bin\\sh.exe
set USER=
set HOST=
set SYS=
set LOCAL=
set REMOTE=
set ARGS=

goto:parse

:usage
echo %0 -u ^<user^> -h ^<host^> -s ^<windows^|linux^> [-l ^<local^> -r ^<remote^>] ^<command^>
goto:eof

:parse
if "%~1" neq "" (
    if "%~1" == "-u" (set opt="USER"&goto:parse_value)
    if "%~1" == "-h" (set opt="HOST"&goto:parse_value)
    if "%~1" == "-s" (set opt="SYS"&goto:parse_value)
    if "%~1" == "-l" (set opt="LOCAL"&goto:parse_value)
    if "%~1" == "-r" (set opt="REMOTE"&goto:parse_value)
    if "%~1" == "--help" (goto:usage)
    set ARGS=%ARGS% %~1
    shift
    goto:parse
)
goto:parse_end

:parse_value
if "%~2" neq "" (
    if %opt% == "USER" (set USER=%~2&shift&shift&goto:parse)
    if %opt% == "HOST" (set HOST=%~2&shift&shift&goto:parse)
    if %opt% == "SYS" (set SYS=%~2&shift&shift&goto:parse)
    if %opt% == "LOCAL" (set LOCAL=%~2&shift&shift&goto:parse)
    if %opt% == "REMOTE" (set REMOTE=%~2&shift&shift&goto:parse)
    echo Error - unknow opt: %opt%&goto:eof
) else (
    echo Error - opt %opt% without value&goto:eof
)
:parse_end
if defined ARGS set ARGS=%ARGS:~1%

if "%USER%" == "" echo Error - no user&goto:eof
if "%HOST%" == "" echo Error - no host&goto:eof
if "%SYS%" == "" echo Warning - no system, use Windows as default

if /i "%SYS%" == "linux" (
    if "%REMOTE%" neq "" (
        "%SHELL%" -c "ssh %USER%@%HOST% %ARGS% | sed s#%REMOTE%#%LOCAL%#g"
    ) else (
        "%SHELL%" -c "ssh %USER%@%HOST% %ARGS%"
    )
) else (
    if "%REMOTE%" neq "" (
        "%SHELL%" -c "ssh %USER%@%HOST% cmd.exe /c %ARGS% | tr '\\\\' '/' | sed s#%REMOTE%#%LOCAL%#g"
    ) else (
        "%SHELL%" -c "ssh %USER%@%HOST% cmd.exe /c %ARGS%"
    )
)
