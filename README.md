# ClawX Watchdog (Portable)

Auto-restart ClawX when connection fails.

## Features
- Auto-detect ClawX installation path
- Auto-detect OpenClaw port from config
- Auto-detect Python/uv executable
- Auto-clean log files (keep last 500 lines, max 1MB)

## Usage
1. Double-click `start_watchdog.bat`
2. The watchdog will auto-detect your ClawX installation
3. Close the window to stop the watchdog (ClawX will keep running)

## How it works
1. Check connection every 10 seconds
2. If connection fails 3 times:
   - Check if ClawX process is running
   - If not running: start ClawX
   - If running: restart gateway
3. If gateway restart fails: restart ClawX + gateway

## Tested on
- Windows 10/11
- ClawX 0.2.4+

## Note
This portable version auto-detects all paths.
You can copy this folder to any computer with ClawX installed.
