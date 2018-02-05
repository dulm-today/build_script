
:: print string with color
:: usage: call colstr <color> <string>

@set /p= <nul>%2&findstr /a:%1 .* %2*
@for /l %%i in (1,1,%3) do set /p= <nul
@echo.
@del /q %2*>nul 2>nul&goto :eof