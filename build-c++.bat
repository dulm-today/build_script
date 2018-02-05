@echo off

set MSC_VER=

if /i "%~1" == "VC6" (
    call "%MSDevDir%\\..\\..\\VC98\\Bin\\vcvars32.bat"
    set MSC_VER=1200
)

if /i "%~1" == "VS2010" (
    call "%VS100COMNTOOLS%..\\..\\VC\\vcvarsall.bat" x86
    set MSC_VER=1600
)

if /i "%~1" == "VS2015" (
    call "%VS140COMNTOOLS%..\\..\\VC\\vcvarsall.bat" x86
    set MSC_VER=1900
)

if "%MSC_VER%" == "" (
    call colstr 0c "Error: no parameter for compiler version"
    echo.&pause&goto:eof
)

set SRC=%~f2
set SRCDIR=%~dp2
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

set CURDIR=%cd%

mkdir "%SRCDIR%\\.build"
cd "%SRCDIR%\\.build"

cl /EHsc /Zi %args% "%SRC%"

cd "%CURDIR%"
