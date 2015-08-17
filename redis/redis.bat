@echo off
title Redis
:MAIN
CLS
echo.
echo  .___  .____  .___   _   _____
echo  /   \ /      /   `  ^|  (
echo  ^|__-' ^|__.   ^|    ^| ^|   `--.
echo  ^|  \  ^|      ^|    ^| ^|      ^|
echo  /   \ /----/ /---/  / \___.'
echo.
echo ...............................................
echo PRESS 1, 2, 3 OR 4 to select your task, or 5 to EXIT.
echo ...............................................
echo.
echo 1 - Install Redis Service
echo 2 - Start Redis
echo 3 - Stop Redis
echo 4 - Uninstall Redis Service
echo 5 - EXIT
echo.
SET /P M=Type 1, 2, 3, 4, or 5 then press ENTER:
IF %M%==1 GOTO INSTALL
IF %M%==2 GOTO REDSTART
IF %M%==3 GOTO REDSTOP
IF %M%==4 GOTO UNINSTALL
IF %M%==5 GOTO EOF

:INSTALL
SC QUERY redis > NUL
IF ERRORLEVEL 1060 (
cd /d %~dp0
redis-server --service-install redis.windows.conf --loglevel verbose
ping 192.0.2.2 -n 1 -w 3000 > nul
GOTO MAIN
) else (
echo # Redis service already installed.
ping 192.0.2.2 -n 1 -w 1000 > nul
echo Aborted.
ping 192.0.2.2 -n 1 -w 1000 > nul
GOTO MAIN
)

:REDSTART
tasklist /FI "IMAGENAME eq redis-server.exe" 2> nul | find /I /N "redis-server.exe" > nul
IF "%ERRORLEVEL%"=="0" (
echo # Redis already started.
ping 192.0.2.2 -n 1 -w 2000 > nul
echo Aborted.
ping 192.0.2.2 -n 1 -w 1000 > nul
GOTO MAIN
) else (
    SC QUERY redis > NUL
    IF ERRORLEVEL 1060 (
    echo # You must first install Redis service.
    ping 192.0.2.2 -n 1 -w 2000 > nul
    echo Aborted.
    ping 192.0.2.2 -n 1 -w 1000 > nul
    GOTO MAIN
    ) else (
    cd /d %~dp0
    redis-server --service-start
    ping 192.0.2.2 -n 1 -w 3000 > nul
    GOTO MAIN
    )
)

:REDSTOP
tasklist /FI "IMAGENAME eq redis-server.exe" 2> nul | find /I /N "redis-server.exe" > nul
IF "%ERRORLEVEL%"=="0" (
cd /d %~dp0
redis-server --service-stop
ping 192.0.2.2 -n 1 -w 3000 > nul
GOTO MAIN
) else (
echo # Redis is not running.
ping 192.0.2.2 -n 1 -w 2000 > nul
echo Aborted.
ping 192.0.2.2 -n 1 -w 1000 > nul
GOTO MAIN
)

:UNINSTALL
SC QUERY redis > NUL
IF ERRORLEVEL 1060 (
echo # Redis service currently not installed.
ping 192.0.2.2 -n 1 -w 2000 > nul
echo Aborted.
ping 192.0.2.2 -n 1 -w 1000 > nul
GOTO MAIN
) else (
cd /d %~dp0
redis-server --service-uninstall
ping 192.0.2.2 -n 1 -w 3000 > nul
GOTO MAIN
)

:EOF
echo bye..
ping 192.0.2.2 -n 1 -w 1000 > nul
exit