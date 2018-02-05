
:: rebuild VC++6.0 workspace's project
:: usage: VC6-rebuild.bat <.dsw path> <project> <platform> < config> [<out log dir>]

@if "%MSDevDir%"=="" (
    call colstr 0c "Error - VC6 is not found! Check the value of ENV 'MSDevDir'."
    echo.&pause&goto:eof
)

@set VC6=%MSDevDir%\Bin\msdev


@echo rebuild solution %~n1 project %2 - %3 %4 ...

@if "%5" == "" (
    "%VC6%" "%~f1" /make "%2 - %3 %4" /rebuild
) else (
    "%VC6%" "%~f1" /make "%2 - %3 %4" /rebuild /out "%5\%~n1-%2.%3.%4.log"
)

@if %errorlevel% EQU 0 (
    echo rebuild solution %~n1 project %2 - %3 %4 ... OK
) else (
    call colstr 0c "rebuild solution %~n1 project %2 - %3 %4 ... FAIL"
    exit /b 1
)
