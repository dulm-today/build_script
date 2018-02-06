
:: build VS2010 solution
:: usage: VC2010-buildAll.bat <.sln path> <config[-platform][:config[-platform]]> [<out log dir>]

@if "%VS100COMNTOOLS%"=="" (
    call colstr 0c "Error - VS2010 is not found! Check the value of ENV 'VS100COMNTOOLS'."
    echo.&pause&goto:eof
)

@set VS2010=%VS100COMNTOOLS%..\IDE\devenv

@echo build solution %~n1 ...

@set CONFIGS="%~2"
:LOOP
@for /f "delims=:, tokens=1,*" %%i in (%CONFIGS%) do @(
    call :VS2010_buildAllConfig "%~f1" %%i "%3"
    set CONFIGS="%%j"
    goto :LOOP
)

@echo build solution %~n1 ... DONE

@goto:eof


:VS2010_buildAllConfig
@echo build solution %~n1 %~2 ...

@set CONFIG=%~2
@set CONFIG_BUILD=%CONFIG:-=^|%

@if "%~3" == "" (
    "%VS2010%" "%~f1" /build "%CONFIG_BUILD%"
) else (
    "%VS2010%" "%~f1" /build "%CONFIG_BUILD%" /out "%~3\%~n1-%CONFIG%.log" >nul 2>nul
)

@if %errorlevel% EQU 0 (
    echo build solution %~n1 %~2 ... OK
) else (
    call colstr 0c "build solution %~n1 %~2 ... FAIL"
    exit /b 1
)
@goto:eof
