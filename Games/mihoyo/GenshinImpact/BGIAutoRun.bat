@echo off
:: 设置代码页为UTF-8
chcp 65001

::管理员权限检测
NET SESSION >nul 2>&1
if %errorlevel% neq 0 (
    echo 请右键以管理员身份运行此脚本！
    pause
    exit
)
:: 切换到指定目录
e:
cd /d E:\Games\BetterGI\

:: 将系统静音
set srv=Audiosrv
net start | find "Windows Audio" >nul
if %errorlevel% equ 0 (
    net stop "%srv%" >nul && echo 已静音
) else (
    echo 当前已静音，无需操作
)

:: 调节亮度为1
WMIC /NAMESPACE:\\root\wmi PATH WmiMonitorBrightnessMethods WHERE "Active=TRUE" CALL WmiSetBrightness Brightness=1 Timeout=0

:: 执行BetterGI.exe程序
.\BetterGI.exe --startOneDragon

:: 调节亮度为50
WMIC /NAMESPACE:\\root\wmi PATH WmiMonitorBrightnessMethods WHERE "Active=TRUE" CALL WmiSetBrightness Brightness=50 Timeout=0

:: 取消系统静音
net start "Audiosrv"
cmd

:: 休眠
shutdown -h
