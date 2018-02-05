
:: rebuild VC++6.0 workspace
:: usage: VC6-rebuildAll.bat <.dsw path> [<out log dir>]

@if "%MSDevDir%"=="" (
    call colstr 0c "Error - VC6 is not found! Check the value of ENV 'MSDevDir'."
    echo.&pause&goto:eof
)

@set VC6=%MSDevDir%\Bin\msdev


@echo rebuild solution %~n1 ...

@if "%2" == "" (
    "%VC6%" "%~f1" /make all /rebuild
) else (
    "%VC6%" "%~f1" /make all /rebuild /out "%2\%~n1.log"
)

@if %errorlevel% EQU 0 (
    echo rebuild solution %~n1 ... OK
) else (
    call colstr 0c "rebuild solution %~n1 ... FAIL"
    exit /b 1
)
