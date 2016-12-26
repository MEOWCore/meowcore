@echo off

rem Generate solutions
utils\premake5 install_data
utils\premake5 install_resources
pause
