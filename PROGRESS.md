# G-CVSNT ビルド進捗メモ

**作業日**: 2026-04-13  
**対象リポジトリ**: G-CVSNT (Gaijin/Gamedev 向け CVSNT 改良版)  
**ソースバージョン**: cvsnt-2.5.05.3744

---

## 1. ビルド成功ファイルと場所

### CVSNT コアコンポーネント

ビルド出力先: `cvsnt/cvsnt-2.5.05.3744/Releasex64/`

#### メイン DLL / EXE

| ファイル | 種別 | 説明 |
|---------|------|------|
| `cvsapi.dll` | DLL | CVSNT コア API |
| `cvsservice.dll` | DLL | Windows サービス本体 |
| `cvstools.dll` | DLL | ユーティリティライブラリ |
| `cvsntcpl.dll` | DLL | コントロールパネルアプレット |
| `genkey.dll` | DLL | キー生成 |
| `installer.dll` | DLL | インストーラカスタムアクション (WiX 用) |
| `mdnsclient.dll` | DLL | mDNS クライアント |
| `plink.dll` | DLL | PuTTY Link ライブラリ |
| `cvsagent.exe` | EXE | CVS エージェント |
| `cvsdiag.exe` | EXE | 診断ツール |
| `cvslock.exe` | EXE | ロックサーバー |
| `extnt.exe` | EXE | 拡張 NT 認証 |
| `postinst.exe` | EXE | インストール後処理 (レジストリ移行等) |
| `rcsdiff.exe` | EXE | RCS diff ツール |
| `rcs_convert.exe` | EXE | RCS 変換ツール |
| `rlog.exe` | EXE | リポジトリログ表示 |
| `cafs_proxy.exe` | EXE | CA ファイルシステムプロキシ |
| `co.exe` | EXE | RCS チェックアウト |
| `uninsthlp.exe` | EXE | アンインストールヘルパー |

> **注意**: メインクライアント `cvs.exe` が `Releasex64/` に存在しない。  
> `cvsnt.vcxproj` の出力名は `cvs.exe` になっているが、ビルド未完了の可能性あり。要確認。

#### プロトコルプラグイン (`Releasex64/protocols/`)

| ファイル | 説明 |
|---------|------|
| `enum.dll` | プロトコル列挙 |
| `ext.dll` | ext (SSH 外部) プロトコル |
| `fork.dll` | fork プロトコル |
| `gserver.dll` | GSSAPI サーバー |
| `pserver.dll` | pserver プロトコル |
| `server.dll` | ローカルサーバー |
| `sserver.dll` | SSL サーバー |
| `ssh.dll` | SSH プロトコル |
| `sspi.dll` | Windows SSPI 認証 |

#### トリガープラグイン (`Releasex64/triggers/`)

| ファイル | 説明 |
|---------|------|
| `audit.dll` | 監査ログトリガー |
| `checkout.dll` | チェックアウトトリガー |
| `email.dll` | メール通知トリガー |
| `info.dll` | 情報トリガー |
| `script.dll` | スクリプトトリガー |

#### データベースプラグイン (`Releasex64/database/`)

| ファイル | 説明 |
|---------|------|
| `odbc.dll` | ODBC データベースバックエンド |
| `sqlite.dll` | SQLite バックエンド |

#### mDNS プラグイン (`Releasex64/mdns/`)

| ファイル | 説明 |
|---------|------|
| `apple.dll` | Apple Bonjour mDNS |
| `mini.dll` | miniDNS |

#### xdiff プラグイン (`Releasex64/xdiff/`)

| ファイル | 説明 |
|---------|------|
| `xml.dll` | XML diff |

---

### コントロールパネル / ユーティリティ

ビルド出力先: `cvsnt/cvsnt-2.5.05.3744/x64/Release/`

| ファイル | 説明 |
|---------|------|
| `cvscontrol.exe` | CVSNT コントロールパネル GUI |
| `genbuild.exe` | ビルドメタデータ生成 |
| `setuid.dll` | UID 設定ライブラリ |

---

### TortoiseCVS (x64 シェル拡張)

ビルド出力先: `cvsnt/tortoiseCVS/TortoiseCVS/build/vc18x64/<各サブプロジェクト>/Release/`

| ファイル | パス | 説明 |
|---------|------|------|
| `TortoiseShell.dll` | `TortoiseShell/Release/` | シェル拡張 DLL (32/64bit 兼用ビルド) |
| `TortoiseAct.exe` | `TortoiseAct/Release/` | アクション実行ツール |
| `TortoisePlink.exe` | `TortoisePlink/Release/` | PuTTY Link (SSH) |
| `PostInst.exe` | `PostInst/Release/` | インストール後処理 |
| `RunTimeInstaller.exe` | `RunTimeInstaller/Release/` | VC ランタイムインストーラ起動 |
| `TortoiseSetupHelper.exe` | `TortoiseSetupHelper/Release/` | セットアップヘルパー |
| `TranslateIss.exe` | `TranslateIss/Release/` | ISS 翻訳ツール |

---

### 外部ライブラリ (OpenSSL)

場所: `cvsnt/cvsnt-2.5.05.3744/external_libs/x64/dll/`

| ファイル | 説明 |
|---------|------|
| `libcrypto-1_1-x64.dll` | OpenSSL 1.1 暗号ライブラリ (x64) |
| `libssl-1_1-x64.dll` | OpenSSL 1.1 SSL ライブラリ (x64) |

---

## 2. レジストリ設定内容

### TortoiseCVS シェル拡張の登録

設定ファイル: `cvsnt/tortoiseCVS/TortoiseCVS/build/install64.reg`  
（手動適用用 `.reg` ファイル）

#### COM オブジェクト登録 (HKEY_CLASSES_ROOT)

| CLSID | 用途 | DLL |
|-------|------|-----|
| `{5d1cb710-...}` | Normal (アイコンオーバーレイ) | `TrtseShl64.dll` |
| `{5d1cb711-...}` | Modified | `TrtseShl64.dll` |
| `{5d1cb712-...}` | Conflict | `TrtseShl64.dll` |
| `{5d1cb713-...}` | Ignored | `TrtseShl64.dll` |
| `{5d1cb714-...}` | ReadOnly | `TrtseShl64.dll` |
| `{5d1cb715-...}` | Added | `TrtseShl64.dll` |
| `{5d1cb716-...}` | Unversioned | `TrtseShl64.dll` |

各エントリの `InProcServer32` に DLL パスと `ThreadingModel=Apartment` を設定。

#### シェルアイコンオーバーレイ識別子 (HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers)

```
TortoiseCVS0 ~ TortoiseCVS6  →  上記 CLSID を対応付け
```

#### シェルコンテキストメニュー拡張

以下のクラスに `ContextMenuHandlers\TortoiseCVS` を追加:
- `HKCR\Directory\shellex`
- `HKCR\Directory\Background\shellex`
- `HKCR\Drive\shellex`
- `HKCR\Folder\shellex`
- `HKCR\*\shellex` (全ファイル)
- `HKCR\InternetShortcut\shellex`
- `HKCR\lnkfile\shellex`

#### プロパティシートハンドラー

- `HKCR\*\shellex\PropertySheetHandlers\TortoiseCVS`
- `HKCR\Folder\shellex\PropertySheetHandlers\TortoiseCVS`
- `HKCR\Folder\shellex\ColumnHandlers\{5d1cb710-...}`

#### CVS URL プロトコルハンドラー

```
HKCR\CVS  →  "URL:CVS Protocol"
HKCR\CVS\shell\open\command  →  TortoiseAct.exe -u "%1"
```

#### TortoiseCVS インストール情報

```
HKLM\SOFTWARE\TortoiseCVS
  RootDir = "D:\Program Files (x86)\TortoiseCVS\"

HKLM\SOFTWARE\TortoiseCVS\Languages
  en_GB, de_DE, fr_FR, it_IT, ja_JP, ... (dword:1)
```

#### Inno Setup インストーラ版レジストリ設定

Inno Setup スクリプト `build/registry.iss` では:
- 32bit: `HKCR32` に `TortoiseShell.dll` を登録
- 64bit: `HKCR64` に `TortoiseShell64.dll` を登録 (IsWin64 条件付き)

---

## 3. 配布パッケージに必要なファイル一覧

### CVSNT サーバー/クライアント パッケージ

インストール先例: `C:\Program Files\CVSNT\`

```
CVSNT\
├── cvs.exe                    ← メインクライアント (要ビルド確認)
├── cvsagent.exe
├── cvsdiag.exe
├── cvslock.exe
├── extnt.exe
├── postinst.exe
├── rcsdiff.exe
├── rcs_convert.exe
├── rlog.exe
├── cafs_proxy.exe
├── co.exe
├── uninsthlp.exe
├── cvsapi.dll
├── cvsservice.dll
├── cvstools.dll
├── cvsntcpl.dll
├── genkey.dll
├── installer.dll
├── mdnsclient.dll
├── plink.dll
├── libcrypto-1_1-x64.dll      ← external_libs/x64/dll/ から
├── libssl-1_1-x64.dll         ← external_libs/x64/dll/ から
├── protocols\
│   ├── enum.dll
│   ├── ext.dll
│   ├── fork.dll
│   ├── gserver.dll
│   ├── pserver.dll
│   ├── server.dll
│   ├── sserver.dll
│   ├── ssh.dll
│   └── sspi.dll
├── triggers\
│   ├── audit.dll
│   ├── checkout.dll
│   ├── email.dll
│   ├── info.dll
│   └── script.dll
├── database\
│   ├── odbc.dll
│   └── sqlite.dll
├── mdns\
│   ├── apple.dll
│   └── mini.dll
└── xdiff\
    └── xml.dll
```

コントロールパネル (別途):
```
CVSNT\
├── cvscontrol.exe             ← x64/Release/ から
└── setuid.dll                 ← x64/Release/ から
```

### TortoiseCVS パッケージ

インストール先例: `C:\Program Files (x86)\TortoiseCVS\`

```
TortoiseCVS\
├── TortoiseAct.exe
├── TortoisePlink.exe
├── TortoiseShell.dll          ← 32bit シェル拡張
├── TortoiseShell64.dll        ← 64bit シェル拡張 (要確認: build/vc18x64 の出力を確認)
├── PostInst.exe
├── RunTimeInstaller.exe
├── TortoiseSetupHelper.exe
├── TranslateIss.exe
├── gdiplus.dll                ← src/SharedDlls/ から
└── cvs.exe                    ← CVSNT クライアントへのコピーまたはシムリンク
```

外部ランタイム (同梱または事前インストール要):
```
├── vcredist_x64.exe           ← VC++ 2022 再頒布可能パッケージ
└── vcredist_x86.exe
```

---

## 4. 次回やること（配布パッケージ整備の手順）

### Step 1: `cvs.exe` ビルドを確認・修正 ✅ 完了 (2026-04-13)

- [x] ビルドエラーの原因を特定  
  - `cvsnt.vcxproj` の TargetName が "cvsnt" のまま、OutputFile が "cvs.exe" で不一致  
  - → `mt.exe` (マニフェスト埋め込み) が存在しない `cvsnt.exe` を探してエラー  
  - `longfilenames.xml` マニフェストが参照されているが未存在  
- [x] 修正: 全4構成 (Release/x64, Release/Win32, Debug/x64, Debug/Win32) に `<TargetName>cvs</TargetName>` を追加  
- [x] 修正: `longfilenames.xml` を新規作成 (Windows 10 長いパスサポート用マニフェスト)  
- [x] ビルド成功: `Releasex64\cvs.exe` (1,893,376 bytes) が生成  
- [x] 動作確認: `cvs version` → `CVSNT 3.5.24 (Gan + [Gaijin -kB/-kBz patch]) Build 9605 (client/server)`  
  - 実行には `Releasex64\` と `external_libs\x64\dll\` を PATH に追加が必要

### Step 2: TortoiseCVS の `TortoiseShell64.dll` を確認 ✅ 完了 (2026-04-13)

#### 調査結果

| ファイル | 参照 DLL 名 | パス | 状態 |
|---------|------------|------|------|
| ビルド出力 | `TortoiseShell.dll` (1,708,032 bytes) | `build/vc18x64/TortoiseShell/Release/` | ✅ 正常 |
| `shell64.iss` / Inno Setup | `TortoiseShell64.dll` (DestName でリネーム配置) | `{app}\` | ✅ 設計どおり |
| `registry.iss` | `TortoiseShell64.dll` | `{app}\` | ✅ Inno Setup と整合 |
| `install64.reg` (修正前) | `TrtseShl64.dll` (旧名) | `D:\Program Files (x86)\TortoiseCVS\` (誤) | ❌ 修正済み |
| 現動作環境 | `TortoiseShell.dll` (リネームなし) | `C:\Ap\TortoiseCVS64\` | ⚠️ 開発用として許容 |

#### DLL 命名の設計

- CMakeLists.txt がビルド出力を `TortoiseShell.dll` として生成
- Inno Setup (`shell64.iss`) が配布時に `DestName: TortoiseShell64.dll` でリネームして配置
- 手動インストール用 `install64.reg` は `TortoiseShell64.dll` を参照する必要がある

#### 修正内容

- [x] `install64.reg` を修正:
  - DLL 名: `TrtseShl64.dll` → `TortoiseShell64.dll`
  - パス: `D:\Program Files (x86)\TortoiseCVS\` → `C:\Program Files\TortoiseCVS\`
  - 全7 CLSID エントリを更新、コメント追記
- [x] 配布パッケージ作成時の対応方針:
  - ビルド出力 `TortoiseShell.dll` を **`TortoiseShell64.dll`** にリネームして配置 (Inno Setup 標準)
  - 手動配置スクリプトでリネームを行う (Step 3 で実装)

### Step 3: 配布ディレクトリを整備 ✅ 完了 (2026-04-13)

配布先: `D:/iwa/AI/Claude/cvs_app/dist/`

#### CVSNT-2.5.05.3744-x64/ (全ファイルコピー済み)

- [x] `Releasex64/` の全 EXE・DLL をコピー (cvs.exe, cvsagent.exe, cvsapi.dll 等 12 EXE + 8 DLL)
- [x] `external_libs/x64/dll/` から `libcrypto-1_1-x64.dll`, `libssl-1_1-x64.dll` をコピー
- [x] `x64/Release/` から `cvscontrol.exe`, `setuid.dll` をコピー
- [x] `Releasex64/protocols/` → `protocols/` (9 DLL)
- [x] `Releasex64/triggers/` → `triggers/` (5 DLL)
- [x] `Releasex64/database/` → `database/` (2 DLL)
- [x] `Releasex64/mdns/` → `mdns/` (2 DLL)
- [x] `Releasex64/xdiff/` → `xdiff/` (1 DLL)

#### TortoiseCVS-x64/ (全ファイルコピー済み)

- [x] `TortoiseAct.exe`, `TortoisePlink.exe`, `PostInst.exe`, `RunTimeInstaller.exe`
- [x] `TortoiseSetupHelper.exe`, `TranslateIss.exe`
- [x] `TortoiseShell.dll` → **`TortoiseShell64.dll`** としてリネームしてコピー (Inno Setup 標準)
- [x] `gdiplus.dll` (src/SharedDlls/ から)
- [x] `cvs.exe` (CVSNT-2.5.05.3744-x64/ からコピー)
- [x] `install64.reg` (手動インストール用、パス修正済み)

#### 備考

- **32bit `TortoiseShell.dll` は未ビルド**: vc18x64 ビルドのみのため x64 版のみ
- `vcredist_x64.exe` は未同梱 (別途 Visual Studio 2022 再頒布可能パッケージを用意すること)

### Step 4: レジストリファイルの最終化 ✅ 完了 (2026-04-13)

- [x] `install64.reg` のパスを配布先 `D:\iwa\AI\Claude\cvs_app\dist\TortoiseCVS-x64\` に更新
  - 全 7 CLSID エントリの InProcServer32 パスを修正
  - TortoiseAct.exe パス、RootDir を修正
  - 別パスへインストールする場合の PowerShell 一括置換コマンドを Install-Guide.md に記載
- [x] `dist\Install-Guide.md` を新規作成
  - Step 1: vcredist_x64.exe のインストール方法
  - Step 2: ファイルのコピー手順 (CVSNT / TortoiseCVS 別)
  - Step 3: install64.reg の適用手順 (パス書き換えコマンド含む)
  - Step 4: 動作確認手順 (`cvs version`, シェル拡張, コントロールパネル)
  - トラブルシューティング・アンインストール手順も記載
- [ ] `postinst.exe` の実行は Step 6 (動作確認) で必要になった場合に実施

### Step 5: インストーラの作成 (任意)

- **CVSNT**: WiX toolset で `installer/cvsnt-client.wxs` or `cvsnt-server.wxs` を使ってインストーラをビルド  
  ```bash
  candle.exe -dCVSNT_VERSION=2.5.05.3744 -dCVSNT_BASE=Releasex64 cvsnt-client.wxs
  light.exe -o cvsnt-client.msi cvsnt-client.wixobj
  ```
- **TortoiseCVS**: Inno Setup で `build/TortoiseCVS.iss` をコンパイル  
  ```bash
  ISCC.exe TortoiseCVS.iss
  ```

### Step 6: 動作確認 ✅ 完了 (2026-04-13)

開発 PC (`D:\iwa\AI\Claude\cvs_app\dist\TortoiseCVS-x64\`) でクリーン再インストールして検証。

#### 事前クリーンアップ
- 旧登録 (`C:\Ap\TortoiseCVS64\` 向け) を HKLM から完全削除  
- スクリプト: `C:\Temp\tortoise_cleanup2.ps1` (要管理者権限)

#### レジストリ登録結果
- `HKCR\CLSID\{5d1cb710...}\InProcServer32` → `...\dist\TortoiseCVS-x64\TortoiseShell64.dll` ✅
- `HKLM\SOFTWARE\TortoiseCVS\RootDir` → `...\dist\TortoiseCVS-x64\` ✅
- `ShellIconOverlayIdentifiers\TortoiseCVS0〜6` → 登録済み ✅

#### 確認項目

- [x] **cvs --version が通ること**  
  ```
  Concurrent Versions System (CVSNT) 3.5.24 (Gan + [Gaijin -kB/-kBz patch]) Build 9605 (client/server)
  ```
- [x] **エクスプローラのコンテキストメニューに TortoiseCVS が表示されること** ← ユーザー確認済み ✅
- [x] **ローカルリポジトリへの checkout が動作すること**  
  `:local:C:/Ap/TortoiseCVS64/test-cvsroot` → `test.txt` checkout 成功 (ExitCode: 0)
- [x] **update が動作すること** — ExitCode: 0
- [x] **commit が動作すること**  
  `test.txt` を 1.11 → 1.12 にコミット成功 (コミットID: `494869dcb2e17ab7`)
- [x] **コントロールパネルの動作確認**  
  - `cvscontrol.exe` は **Console サービスデーモン** (GUI ではない)  
    → `cvscontrol.exe -v` で `CVSNT Control Panel 3.5.24 Build 9605` を表示 ✅  
    → サービス登録: `cvscontrol.exe -i` (管理者権限で実行、サーバー用途時のみ必要)  
  - GUI コントロールパネルは `cvsntcpl.dll` (CPL アプレット)  
    → `rundll32.exe cvsntcpl.dll,Control_RunDLL` で起動 ✅ (PID 確認済み)

#### 未確認 (サーバー用途時のみ必要)
- pserver / ssh 接続 (cvscontrol.exe -i でサービス登録後に確認)

---

## 補足: ビルド環境

| 項目 | 内容 |
|------|------|
| OS | Windows 10 Pro (10.0.19045) |
| コンパイラ | Visual Studio 2022 (vc18) |
| ターゲット | x64 Release |
| CVSNT ソース | `cvsnt/cvsnt-2.5.05.3744/cvsnt.sln` |
| TortoiseCVS | `cvsnt/tortoiseCVS/TortoiseCVS/build/vc18x64/TortoiseCVS.slnx` |
| CMake ビルド | `build/vc18x64/` (TortoiseCVS) |
