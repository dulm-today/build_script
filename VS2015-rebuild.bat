
:: rebuild VS2015 project
:: usage: VC2015-build.bat <.sln path> <project> <platform> <config> [<out log dir>]

@if "%VS140COMNTOOLS%"=="" (
    call colstr 0c "Error - VS2015 is not found! Check the value of ENV 'VS140COMNTOOLS'."
    echo.&pause&goto:eof
)

@set VS2015=%VS140COMNTOOLS%..\IDE\devenv

@echo rebuild solution %~n1 %2 - %3 %4 ...

@if "%~5" == "" (
    "%VS2015%" "%~f1" /rebuild %4 /project %2 /projectconfig "%4|%3"
) else (
    "%VS2015%" "%~f1" /rebuild %4 /project %2 /projectconfig "%4|%3" /out "%OUT%\%~n1-%2.%3.%4.log" >nul 2>nul
)

@if %errorlevel% EQU 0 (
    echo rebuild solution %~n1 %2 - %3 %4 ... OK
) else (
    call colstr 0c "rebuild solution %~n1 %2 - %3 %4 ... FAIL"
    exit /b 1
)
