
@echo off

set SRC=%~f1
set SRCDIR=%~dp1

rd /s /q "%SRCDIR%\\.build%"
