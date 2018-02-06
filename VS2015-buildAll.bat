
:: build VS2015 solution
:: usage: VC2015-buildAll.bat <.sln path> <config[:config]> [<out log dir>]

@if "%VS140COMNTOOLS%"=="" (
    call colstr 0c "Error - VS2015 is not found! Check the value of ENV 'VS140COMNTOOLS'."
    echo.&pause&goto:eof
)

@set VS2015=%VS140COMNTOOLS%..\IDE\devenv

@echo build solution %~n1 ...

@set CONFIGS="%~2"
:LOOP
@for /f "delims=:, tokens=1,*" %%i in (%CONFIGS%) do @(
    call :VS2015_buildAllConfig "%~f1" %%i "%3"
    set CONFIGS="%%j"
    goto :LOOP
)

@echo build solution %~n1 ... DONE

@goto:eof


:VS2015_buildAllConfig
@echo build solution %~n1 %~2 ...

@set CONFIG=%~2
@set CONFIG_BUILD=%CONFIG:-=^|%

@if "%~3" == "" (
    "%VS2015%" "%~f1" /build "%CONFIG_BUILD%"
) else (
    "%VS2015%" "%~f1" /build "%CONFIG_BUILD%" /out "%~3\%~n1-%CONFIG:%.log" >nul 2>nul
)

@if %errorlevel% EQU 0 (
    echo build solution %~n1 %~2 ... OK
) else (
    call colstr 0c "build solution %~n1 %~2 ... FAIL"
    exit /b 1
)
@goto:eof
