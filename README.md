# ClawX Watchdog (Portable)

[中文](#中文说明) | [English](#english)

---

## 中文说明

一个面向 **Windows 上 ClawX / OpenClaw** 的便携式守护程序。

当本地网页连接失效时，它可以自动：
- 检测 **ClawX** 是否仍在运行
- 在合适的时候重启 **gateway**
- 必要时重启 **ClawX**
- 尽量用更少的人工干预恢复连接

---

### 为什么要做这个

有时 ClawX 还在运行，但本地网页已经打不开了。  
有时 ClawX 本体退出了，或者 gateway 卡住了。  

这个 watchdog 的目的，就是自动处理这些常见故障场景。

---

### 功能特性

- **便携**：尽量不依赖机器专属配置
- **自动检测 ClawX 安装路径**
- **自动检测 `openclaw.cmd` 路径**
- **自动检测端口配置**
- **每 10 秒检测一次连接状态**
- **优先尝试重启 gateway**
- **必要时重启 ClawX**
- **自动清理日志**
  - 最大日志大小：**1 MB**
  - 仅保留最近 **500 行**

---

### 文件结构

```text
ClawX_Watchdog_Portable/
├─ clawx_watchdog.py     # 主程序
├─ start_watchdog.bat    # Windows 启动器
└─ README.md             # 说明文档
```

---

### 工作原理

#### 正常流程

1. 检查本地 ClawX/OpenClaw URL 是否可访问
2. 如果连接正常 → 继续监控
3. 如果连接连续失败：
   - 检查 **ClawX.exe** 是否仍在运行
   - 如果 ClawX 不在运行 → 先启动 ClawX
   - 如果 ClawX 在运行 → 先尝试重启 gateway
   - 如果仅重启 gateway 不够 → 再重启 ClawX + gateway

#### 恢复策略

Watchdog 会尽量避免无意义的重复重启：

- 如果 ClawX 启动后连接已经恢复，就**不会继续执行额外的重启流程**
- 使用 **cooldown 冷却时间**，避免短时间内重复触发
- 对重启尝试次数做限制，避免无限循环

---

### 运行环境

- **Windows 10 / 11**
- 已安装 **ClawX**
- 本地可运行的 ClawX / OpenClaw 环境

---

### 使用方法

#### 启动 watchdog

双击：

```bat
start_watchdog.bat
```

#### 停止 watchdog

直接关闭 watchdog 窗口即可。

> 关闭 watchdog 窗口后，**不应该**把 ClawX 一起关掉。

---

### 日志文件

日志会写入：

```text
clawx_watchdog.log
```

日志文件和脚本放在同一个目录下。

#### 日志清理策略

程序启动时，如果日志过大：
- 会自动裁剪
- 只保留最近 500 行

---

### 可移植性

这个版本设计目标就是：**换一台 Windows 电脑也尽量能直接跑**。

你可以把整个文件夹复制到另一台装有 ClawX 的电脑上，然后直接运行：

```bat
start_watchdog.bat
```

脚本会自动尝试检测：
- ClawX 安装位置
- OpenClaw CLI 路径
- 本地端口配置

---

### 注意事项

- 这个项目主要用于 **本地桌面恢复**，不是面向服务器部署
- 逻辑是围绕 **Windows + ClawX** 设计的
- 如果你的安装方式很特殊，可能仍需要手动调整路径

---

### 后续计划

后续可以考虑加入：

- 托盘图标 / 后台模式
- 从配置文件读取检测参数
- 桌面通知
- 更完善的多安装路径识别
- 可直接发布的 release 打包

---

### 许可证

目前仓库里**还没有添加 license**。

如果你准备正式开源，可以考虑：
- MIT
- Apache-2.0
- GPL-3.0

---

### 仓库地址

GitHub：

**https://github.com/Huoxing999/ClawX-Watchdog**

---

## English

A portable watchdog for **ClawX / OpenClaw on Windows**.

When the local web connection becomes unavailable, it can automatically:
- detect whether **ClawX** is still running
- restart the **gateway** when appropriate
- restart **ClawX** if necessary
- recover the connection with minimal manual work

---

### Why this exists

Sometimes ClawX is still running, but the local web UI stops responding.  
Sometimes ClawX itself exits, or the gateway gets stuck.  

This watchdog is meant to handle those common recovery scenarios automatically.

---

### Features

- **Portable**: avoids machine-specific hardcoding as much as possible
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

### Files

```text
ClawX_Watchdog_Portable/
├─ clawx_watchdog.py     # Main watchdog script
├─ start_watchdog.bat    # Windows launcher
└─ README.md             # Documentation
```

---

### How it works

#### Normal flow

1. Check whether the local ClawX/OpenClaw URL is reachable
2. If the connection is healthy → keep monitoring
3. If the connection fails repeatedly:
   - check whether **ClawX.exe** is still running
   - if ClawX is not running → start ClawX first
   - if ClawX is running → try restarting the gateway first
   - if gateway recovery is not enough → restart ClawX + gateway

#### Recovery strategy

The watchdog tries to avoid unnecessary restart loops:

- If ClawX starts and the connection recovers quickly, it **does not continue forcing extra recovery steps**
- It uses a **cooldown period** to avoid repeated rapid triggers
- It limits restart attempts for safety

---

### Requirements

- **Windows 10 / 11**
- **ClawX installed**
- A working local ClawX / OpenClaw environment

---

### Usage

#### Start the watchdog

Double-click:

```bat
start_watchdog.bat
```

#### Stop the watchdog

Close the watchdog window.

> Closing the watchdog window should **not** close ClawX itself.

---

### Log file

The watchdog writes logs to:

```text
clawx_watchdog.log
```

The log file is stored in the same folder as the script.

#### Log cleanup behavior

On startup, if the log becomes too large:
- it trims the file automatically
- keeps only the latest 500 lines

---

### Portability

This version is designed to be **moved to another Windows PC and still work**.

You can copy the whole folder to another machine with ClawX installed, then run:

```bat
start_watchdog.bat
```

The script will try to auto-detect:
- ClawX installation path
- OpenClaw CLI path
- local port configuration

---

### Notes

- This project is mainly intended for **local desktop recovery**, not server deployment
- It is designed around **Windows + ClawX**
- If your setup is heavily customized, you may still want to adjust paths manually

---

### Roadmap

Possible future improvements:

- tray icon / background mode
- configurable intervals from a settings file
- desktop notifications
- better multi-installation detection
- releasable packaged builds

---

### License

No license has been added yet.

If you want to open-source it more formally, consider adding one such as:
- MIT
- Apache-2.0
- GPL-3.0

---

### Repository

GitHub:

**https://github.com/Huoxing999/ClawX-Watchdog**
