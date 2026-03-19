# ClawX Watchdog (Portable)

A portable watchdog for **ClawX / OpenClaw** on Windows.

When the local web connection becomes unavailable, it can automatically:
- detect whether **ClawX** is still running
- restart the **gateway** when possible
- restart **ClawX** if needed
- recover the connection with minimal manual work

---

## Why this exists

Sometimes ClawX keeps running, but the local web UI stops responding.
Sometimes ClawX itself exits, or the gateway gets stuck.

This watchdog is meant to handle those situations automatically.

---

## Features

- **Portable**: no hardcoded machine-specific setup required
- **Auto-detects ClawX installation path**
- **Auto-detects `openclaw.cmd` path**
- **Auto-detects port from config**
- **Checks connection every 10 seconds**
- **Restarts gateway first when appropriate**
- **Restarts ClawX if gateway recovery is not enough**
- **Auto-cleans logs**
  - max log size: **1 MB**
  - keeps the most recent **500 lines**

---

## Files

```text
ClawX_Watchdog_Portable/
├─ clawx_watchdog.py     # Main watchdog script
├─ start_watchdog.bat    # Launcher for Windows
└─ README.md             # This file
```

---

## How it works

### Normal cycle

1. Check the local ClawX/OpenClaw URL
2. If connection is normal → keep monitoring
3. If connection fails repeatedly:
   - check whether **ClawX.exe** is still running
   - if ClawX is not running → start ClawX first
   - if ClawX is running → try restarting the gateway
   - if gateway restart is not enough → restart ClawX + gateway

### Recovery strategy

The watchdog tries to avoid unnecessary restarts:

- If ClawX restarts and the connection comes back quickly, it **does not continue forcing extra restart steps**
- It uses a **cooldown period** to avoid rapid restart loops
- It limits repeated restart attempts for safety

---

## Requirements

- **Windows 10 / 11**
- **ClawX installed**
- A working local ClawX/OpenClaw environment

---

## Usage

### Start the watchdog

Double-click:

```bat
start_watchdog.bat
```

### Stop the watchdog

Close the watchdog window.

> Closing the watchdog window should **not** close ClawX itself.

---

## Log file

The watchdog writes logs to:

```text
clawx_watchdog.log
```

The log file is created in the same folder as the script.

### Log cleanup behavior

On startup, if the log becomes too large:
- it trims the file automatically
- keeps only the most recent 500 lines

---

## Portability

This version is designed to be moved to another Windows PC.

You can copy the whole folder to another machine with ClawX installed, then run:

```bat
start_watchdog.bat
```

The script will try to auto-detect:
- ClawX installation path
- OpenClaw CLI path
- local port configuration

---

## Notes

- This project is intended for **local desktop recovery**, not server deployment
- It is designed around **ClawX on Windows**
- If your local setup is heavily customized, you may still want to adjust paths manually

---

## Roadmap

Possible future improvements:

- tray icon / background mode
- configurable intervals from a settings file
- optional desktop notifications
- better multi-installation detection
- exportable release package

---

## License

No license has been added yet.

If you want to open-source it properly, consider adding one such as:
- MIT
- Apache-2.0
- GPL-3.0

---

## Repository

GitHub:

**https://github.com/Huoxing999/ClawX-Watchdog**
