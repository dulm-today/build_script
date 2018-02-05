
@echo off

set SHELL=%ProgramFiles%\\Git\\bin\\sh.exe
set USER=%~1
set HOST=%~2
set OS=%~3
shift
shift
shift

:: get args without %1
set "args="
:parse
if "%~1" neq "" (
  set args=%args% %1
  shift
  goto :parse
)
if defined args set args=%args:~1%

if "%OS%" == "linux" (
    "%SHELL%" -c "ssh %USER%@%HOST% \"%args%\""
) else (
    "%SHELL%" -c "ssh %USER%@%HOST% cmd.exe /c %args%"
)
