# TortoiseCVS (G-CVSNT x64) — Windows 11 x64 対応版

## 概要

元の TortoiseCVS + CVSNT を Windows 11 x64 環境で動作するよう改修したフォークです。

主な改修内容：

- Windows 11 x64 対応（GetVersionEx 修正）
- 日本語ファイル名対応
- コンフリクト表示修正
- オーバーレイアイコン表示対応
- Inno Setup インストーラ作成

## 動作要件

- Windows 10 / 11 x64
- TortoiseGit または TortoiseSVN（推奨）  
  ※ なくても動作しますが、オーバーレイアイコンの表示には TortoiseGit/SVN が推奨されます
- 管理者権限（インストール時）

## インストール方法

1. [GitHub Releases](https://github.com/iwadjp/G-CVSNT/releases/tag/v2.5.05.3744-win11-x64) から `TortoiseCVS-x64-Setup.exe` をダウンロード
2. `TortoiseCVS-x64-Setup.exe` を実行
3. インストール完了後、エクスプローラーを再起動（またはPCを再起動）
4. エクスプローラーで CVS 管理フォルダを右クリックし、TortoiseCVS のメニューが表示されれば完了

## アンインストール方法

「アプリと機能」から **TortoiseCVS (G-CVSNT x64)** をアンインストール後、PCを再起動してください。

## 主な修正内容

[PROGRESS.md](PROGRESS.md) を参照してください。

## ライセンス

- TortoiseCVS: GNU GPL v2
- CVSNT: GNU GPL v2
- TortoiseOverlays: TortoiseSVN Project ライセンス（License.txt 参照）

---

# TortoiseCVS (G-CVSNT x64) — Windows 11 x64 Compatible Fork

## Overview

A fork of TortoiseCVS + CVSNT modified to work on Windows 11 x64.

Key changes:

- Windows 11 x64 compatibility (GetVersionEx fix)
- Japanese filename support
- Conflict display fix
- Overlay icon support
- Inno Setup installer

## Requirements

- Windows 10 / 11 x64
- TortoiseGit or TortoiseSVN (recommended)  
  \* Overlay icons require TortoiseGit/SVN
- Administrator privileges (for installation)

## Installation

1. Download `TortoiseCVS-x64-Setup.exe` from [GitHub Releases](https://github.com/iwadjp/G-CVSNT/releases/tag/v2.5.05.3744-win11-x64)
2. Run `TortoiseCVS-x64-Setup.exe`
3. Restart Explorer (or reboot PC) after installation
4. Right-click a CVS-managed folder in Explorer — verify that the TortoiseCVS menu appears

## Uninstallation

Uninstall **TortoiseCVS (G-CVSNT x64)** from "Apps & Features", then reboot.

## Changes

See [PROGRESS.md](PROGRESS.md) for details.

## License

- TortoiseCVS: GNU GPL v2
- CVSNT: GNU GPL v2
- TortoiseOverlays: TortoiseSVN Project License (see License.txt)
