@echo off
chcp 932 >nul
rem ===== モバイル採用HP かんたん公開 =====
rem このファイルをダブルクリックすると、
rem  (1) 採用HPの開発サーバー(localhost:4322)
rem  (2) ngrok外部公開(operate-luridness-graceful.ngrok-free.dev)
rem の2つが別ウィンドウで立ち上がります。
rem 閉じるときは、それぞれのウィンドウで Ctrl+C → ウィンドウを閉じる。

rem このバットファイルがある場所(=採用HPフォルダ)に移動
cd /d "%~dp0"

rem (1) 開発サーバーを別ウィンドウで起動
start "saiyo-HP dev (4322)" cmd /k npm run dev

rem (2) ngrokトンネルを別ウィンドウで起動
start "ngrok publish" cmd /k ngrok start mobile-hp

echo.
echo  2つのウィンドウを起動しました。
echo   - localhost:4322 ... 自分の確認用
echo   - operate-luridness-graceful.ngrok-free.dev ... 外部公開用
echo.
echo  このウィンドウは閉じてOKです。
timeout /t 5 >nul
