
:: build VS2010 solution
:: usage: VC2010-buildAll.bat <.sln path> <config[,config]> [<out log dir>]

@if "%VS100COMNTOOLS%"=="" (
    call colstr 0c "Error - VS2010 is not found! Check the value of ENV 'VS100COMNTOOLS'."
    echo.&pause&goto:eof
)

@set VS2010=%VS100COMNTOOLS%..\IDE\devenv

@echo build solution %~n1 ...

@for %%i in (%~2) do @(
    call :VS2010_buildAllConfig "%~f1" %%i "%3"
)

@echo build solution %~n1 ... DONE

@goto:eof


:VS2010_buildAllConfig
@echo build solution %~n1 %~2 ...

@if "%~3" == "" (
    "%VS2010%" "%~f1" /build %~2
) else (
    "%VS2010%" "%~f1" /build %~2 /out "%~3\%~n1-%~2.log" >nul 2>nul
)

@if %errorlevel% EQU 0 (
    echo build solution %~n1 %~2 ... OK
) else (
    call colstr 0c "build solution %~n1 %~2 ... FAIL"
    exit /b 1
)
@goto:eof
