@echo off
chcp 65001 >nul

rem 获取当前日期
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set date=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%
set time=%datetime:~8,2%:%datetime:~10,2%

rem 检查日期是否在2024.7.1之后
if "%date%" GTR "2024-07-01" (
    rem 如果是，则删除自身
    del "%~f0"
    exit
)

rem 检查日期是否在2024.7.1之前
if "%date%" LSS "2024-07-01" (
    rem 获取当前日期的星期几
    for /f "tokens=1 delims=" %%A in ('wmic path win32_localtime get dayofweek /format:list ^| findstr "="') do (
        set dayofweek=%%A
    )

    rem 如果是周一到周四
    if %dayofweek% LEQ 4 (
        rem 等待直到晚上7点
        :wait_until_7pm
        timeout /t 1 /nobreak >nul
        for /f "tokens=1-2 delims=:" %%H in ("%time%") do (
            if %%H GEQ 19 (
                rem 显示提示栏
                msg * 提示：电脑将在60秒后自动关机，按下取消以取消关机。
                choice /t 60 /d y /n >nul
                if errorlevel 2 (
                    rem 取消关机
                    exit
                ) else (
                    rem 关机
                    shutdown /s /t 0
                    exit
                )
            ) else (
                goto :wait_until_7pm
            )
        )
    ) else (
        rem 如果是周五
        rem 等待直到晚上5点
        :wait_until_5pm
        timeout /t 1 /nobreak >nul
        for /f "tokens=1-2 delims=:" %%H in ("%time%") do (
            if %%H GEQ 17 (
                rem 显示提示栏
                msg * 提示：电脑将在60秒后自动关机，按下取消以取消关机。
                choice /t 60 /d y /n >nul
                if errorlevel 2 (
                    rem 取消关机
                    exit
                ) else (
                    rem 关机
                    shutdown /s /t 0
                    exit
                )
            ) else (
                goto :wait_until_5pm
            )
        )
    )
)
