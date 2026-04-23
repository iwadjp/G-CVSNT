# G-CVSNT ビルド進捗メモ

**作業日**: 2026-04-13 / 更新: 2026-04-14  
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
- **`TortoiseMenus.config` を追加 (2026-04-14)**: 右クリックメニュー定義ファイル。未同梱だとメニュー項目が表示されない。`C:\Ap\TortoiseCVS64\` からコピーして `TortoiseCVS-x64\` に追加済み

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

### Step 6 追記: 業務PC展開で判明した追加要件 (2026-04-14)

業務 PC での動作確認で以下の 3 点が必要とわかった。

#### 追加要件 1: TortoiseMenus.config が必須

- **事象**: 配布パッケージに `TortoiseMenus.config` が含まれていないと右クリックメニューが表示されない
- **対処**: `C:\Ap\TortoiseCVS64\TortoiseMenus.config` を `dist\TortoiseCVS-x64\` にコピー済み ✅
- **備考**: Step 3 の備考にも記録済み

#### 追加要件 2: cvslock サービスの起動が必須 (ネットワーク共有リポジトリ)

- **事象**: ネットワーク共有 (UNCパス/ネットワークドライブ) 上のリポジトリへアクセスすると  
  `Couldn't connect to lock server` エラーが発生
- **原因**: `cvslock` サービスが停止/未登録
- **対処手順**:
  ```cmd
  cvslock.exe -i      # Windows サービスとして登録
  net start cvslock   # サービス起動
  ```
- **反映済みファイル**:
  - `dist\Install-Guide.md` — Step 3-2 に手順追加、トラブルシューティングに対処法追加 ✅
  - `dist\register-tortoisecvs.ps1` — cvslock 登録・起動ブロック追加 ✅

#### 追加要件 3: TortoiseCVS の「Allow Network Drives」設定が必要

- **事象**: ネットワークドライブ (`Z:\` 等) 上のフォルダで CVS コンテキストメニューが表示されない
- **対処**: TortoiseCVS の Preferences → Look & Feel → **「Allow Network Drives」をオン**にする
- **反映済みファイル**:
  - `dist\Install-Guide.md` — Step 3-3 に設定手順追加 ✅
  - `dist\register-tortoisecvs.ps1` — 完了メッセージに案内を追記 ✅

---

### Step 7: 日本語ファイル名の文字化け修正 ✅ コード修正完了 / 開発PCはテストデータ再作成が必要 (2026-04-23)

#### 症状
- `cvs update` / `cvs checkout` で日本語ファイル名が文字化けする
- CVS/Entries に日本語名が Shift-JIS (CP932) で格納されているが CVSNT 3.5.24 が UTF-8 として処理するためミスマッチが発生
- 旧動作: `warning: 新しいテキスト ドキュメント.txt is not (any longer) pertinent` → Scratch_Entry → 毎回再チェックアウト

#### 根本原因
`windows-NT/win32.cpp:43` の初期値が `CP_UTF8`:
```c
int win32_global_codepage = CP_UTF8;  // ← 修正前
```
この値が `CFileAccess::Win32SetUtf8Mode()` を経由して `cvsapi/win32/FileAccess.cpp` の `Win32Wide`/`Win32Narrow` (MultiByteToWideChar/WideCharToMultiByte) 全呼び出しのコードページを決定する。CVS 1.11 が CP932 で書いた Entries のファイル名を UTF-8 として変換 → 文字化けの無限ループ。

#### 修正内容
**ファイル**: `windows-NT/win32.cpp` (1箇所のみ)

```c
// 修正前
int win32_global_codepage = CP_UTF8;

// 修正後
int win32_global_codepage = CP_ACP; /* Use system ANSI codepage (CP932 on Japanese Windows) for Shift-JIS filename compatibility */
```

#### 影響範囲
| 箇所 | 変化 |
|------|------|
| `FileAccess.cpp` Win32Wide/Narrow | CP_UTF8 → CP_ACP (m_bUtf8Mode 経由で自動切替) |
| server.cpp コンソール出力 | WriteConsoleW 変換が CP_ACP → 日本語コンソール正常 |
| server/client.cpp プロトコルネゴシエーション | "UTF-8" → "Shift_JIS" 宣言 |
| `cvsapi.dll` の再ビルド | 不要 (m_bUtf8Mode=false がデフォルト値) |

#### 動作確認結果
- CVS 1.11 チェックアウト (CP932 Entries) + CVSNT update: 日本語ファイルが "not pertinent" にならず T_UPTODATE として正常処理 ✅ (業務PC)
- CVSNT 新規 checkout: 日本語ファイル名がディスクに正しく作成、Entries に CP932 で正しく格納 ✅ (業務PC)
- ASCII ファイルの update (1.12→1.13): 引き続き正常 ✅

#### ⚠️ 開発PC 固有の問題 (Step 7b)

開発PC のテストリポジトリは**旧 cvs.exe (CP_UTF8 モード)** で作成したため、`CVS/Entries` のファイル名が UTF-8 でエンコードされている。CP_ACP 修正後の cvs.exe でこのリポジトリを読むと文字化けしてファイルが見つからない。

- **根本原因**: `test-work/cvsnt-cp932-checkout/CVS/Entries` の日本語ファイル名部分のバイト列が `E6 96 B0`（"新" の UTF-8）になっている（CP932 では `90 56`）
- **対処**: テストリポジトリを新 cvs.exe で checkout し直す → CVS/Entries が CP932 で再生成される (→ **Step 7b**)
- **追加メモ**: `SetConsoleOutputCP(win32_global_codepage)` = `SetConsoleOutputCP(0)` はサイレントに失敗。コンソール出力 CP の修正が必要な場合は `SetConsoleOutputCP(GetACP())` に変更すること

#### ビルド・配布
- [x] `cvsnt.sln` / `cvsnt` プロジェクトのみ再ビルド (Release/x64)
- [x] `Releasex64\cvs.exe` (1,893,376 bytes, 2026-04-23) を `dist\TortoiseCVS-x64\cvs.exe` にコピー済み

---

### Step 8: TortoiseAct の cvs.exe パス解決バグ修正 ✅ 完了 (2026-04-23)

#### 調査結果: cvs.exe の呼び出しパス

TortoiseAct.exe が cvs.exe を特定する仕組み (`src/CVSGlue/MakeArgs.cpp`):

1. `HKLM\Software\Cvs\PServer\InstallPath` を読む → **このキーは存在しない** (WOW6432Node 下にリポジトリ設定はあるが InstallPath なし)
2. フォールバック: PATH で `"cvs.exe"` を検索

#### 問題

PATH に `C:\Ap\TortoiseCVS\cvsnt-legacy-20170126\cvs.exe` (CVSNT 2.5.05 Build 6234) が存在し、TortoiseAct が追加する dist ディレクトリより先に見つかる:

```
// TortoiseAct.cpp:135 (修正前) - 末尾に追加するため古いcvs.exeが先に使われる
SetEnvVar("PATH", GetEnvVar("PATH") + ";" + GetTortoiseDirectory());
```

また `src/CVSGlue/CVSStatus.cpp` も MakeArgs を使って cvs.exe を起動する（アイコンオーバーレイ更新用）。

#### 修正内容

**修正1: `src/TortoiseAct/TortoiseAct.cpp:135`** — PATH を末尾追加→先頭追加

```cpp
// 修正前
SetEnvVar("PATH", GetEnvVar("PATH") + ";" + GetTortoiseDirectory());
// 修正後
SetEnvVar("PATH", GetTortoiseDirectory() + ";" + GetEnvVar("PATH"));
```

**修正2: `src/CVSGlue/MakeArgs.cpp`** — TortoiseDirectory の cvs.exe を明示的に優先

```cpp
// 修正後 (HKLM\...\InstallPath も TortoiseDirectory\cvs.exe も見つからない場合の最終フォールバック前に挿入)
if (myOptions.empty())
{
    std::string tortoiseExe = EnsureTrailingDelimiter(GetTortoiseDirectory()) + "cvs.exe";
    if (FileExists(tortoiseExe.c_str()))
        myOptions.push_back(tortoiseExe);
}
if (myOptions.empty())
    myOptions.push_back("cvs.exe");
```

#### ビルド・配布

- [x] `TortoiseAct.exe` 再ビルド → `dist\TortoiseCVS-x64\TortoiseAct.exe` 更新 (2026-04-23)
- [x] `TortoiseShell.dll` 再ビルド → `dist\TortoiseCVS-x64\TortoiseShell64.dll` 更新 (2026-04-23)
- [x] `C:\Ap\TortoiseCVS64\TortoiseShell.dll` も同時更新 (Explorer 再起動して適用済み)
- [x] `GetTortoiseDirectory()` は `HKLM\SOFTWARE\TortoiseCVS\RootDir` を読む (64bit: `dist\TortoiseCVS-x64\`)

#### Process Monitor での確認方法 (業務PC)

TortoiseCVS の update 実行時にどの cvs.exe が呼ばれているかを確認する手順:

1. [Sysinternals Process Monitor](https://learn.microsoft.com/ja-jp/sysinternals/downloads/procmon) を起動
2. フィルタ設定: `Process Name is TortoiseAct.exe` AND `Operation is Process Create`
3. TortoiseCVS から任意のフォルダを右クリック → Update
4. Process Monitor の Detail 列で起動された cvs.exe のフルパスを確認

期待値: `D:\iwa\AI\Claude\cvs_app\dist\TortoiseCVS-x64\cvs.exe` (CVSNT 3.5.24 Build 9605)
問題あり: `C:\Ap\TortoiseCVS\cvsnt-legacy-20170126\cvs.exe` (CVSNT 2.5.05 Build 6234)

---

### Step 9a: ConflictファイルがOutputに表示されない問題 ⚠️ 修正済み・業務PC確認待ち (2026-04-23)

#### 症状

`cvs update` でコンフリクトが発生した際:
- Output ダイアログに `U filename` は表示される ✅
- Tortoise Tip「C マークのファイルを手動でマージしてください」は表示される ✅
- **`C filename` 行が Output 欄に表示されない** ❌
- コンフリクトファイル一覧ダイアログ (`DoConflictListDialog`) が表示されない ❌
- 「Error, CVS operation failed」は表示される (stderr 経由) ✅

#### 調査済みの流れ

```
CVSNT update.cpp
  → RCS_merge でコンフリクト発生 (status=1)
  → time_stamp(file) で T1 を取得
  → Register() で CVS/Entries に ts_conflict=T1 を書き込む
  → error() → cvs_outerr() → CCvsgui::write(isStderr=true)  ← stderr
  → write_letter('C')
      → cvs_output_tagged("text", "C ")
      → cvs_output_tagged("fname", filename)
      → cvs_output_tagged("newline", NULL)
      → cvs_output() → CCvsgui::write(isStderr=false)  ← stdout

TortoiseAct CVSAction.cpp
  → ConsoleOut("C "), ConsoleOut("filename"), ConsoleOut("\n")
  → myStdoutLine に "C filename" を組み立て → myConsoleOutput へ push
  → PipeToGUI():
      stdout: ProcessStdoutLine() → myStdOutStore に格納
              myShowStdout=true → vLines に追加 → Progress Dialog に表示
              GetType("C filename") → TTConflict (赤色) で表示のはず

PerformUpdateMenu()
  → glue.Command() 完了後
  → out = glue.GetStdOutList() = myStdOutStore
  → TortoiseTip が out から "C " を検知 → Tip 表示 ✅
  → ParseConflicts(group, out, conflictFiles):
      line = "C filename"
      line[0]=='C' && line[1]==' ' → 一致
      file = group.myDirectory + "\" + "filename"
      【★ここが疑問点★】
      if (CVSStatus::GetFileStatus(file) == CVSStatus::STATUS_CONFLICT)
          → この条件が false の場合、conflictFiles に追加されない
```

#### 根本原因候補 (未確定)

**候補A**: `CVSStatus::GetFileStatus(file)` が `STATUS_CONFLICT` を返さない

`STATUS_CONFLICT` が返る条件 (`CVSStatus.cpp:625`):
```cpp
else if (data->NeedsMerge())
    status = STATUS_CONFLICT;
```

`NeedsMerge` の設定 (`CvsEntries.cpp:603`):
```cpp
data->SetNeedsMerge(unmodified(finfo, ts_conflict));
```

`unmodified()` は `asctime(gmtime(file.mtime))` と CVS/Entries の `ts_conflict` を文字列比較。
CVSNT が書く `ts_conflict = time_stamp(file, 0) = asctime(gmtime(mtime))` と同じ形式のため
**理論上は一致するはず**。タイミング問題 or CVSNT 3.5.24 固有の書式差異の可能性あり。

**候補B**: `ParseConflicts` のファイルパス構築が間違っている
```cpp
file = EnsureTrailingDelimiter(group.myDirectory) + line.substr(2, i-2);
FindAndReplace(file, "/", "\\");
```
サブディレクトリ内ファイルや日本語パスで不一致が起きる可能性。

**候補C**: `C filename` が stdout に届いているが Progress Dialog に表示されない
`GetType("C filename")` → `TTConflict` (赤色) → 表示はされるはず。
Tortoise Tip が "C " を検知している事実から stdout には存在確認済み。

#### 修正内容

**ファイル**: `src/TortoiseAct/TortoiseAct.cpp` — `ParseConflicts()` (line 2890 付近)

```cpp
// 修正前
if (CVSStatus::GetFileStatus(file) == CVSStatus::STATUS_CONFLICT)
{
    if (!CVSStatus::IsBinary(file))
        conflictFiles.push_back(file);
}

// 修正後
if (FileExists(file.c_str()) && !CVSStatus::IsBinary(file))
{
    bool hasConflictMarker = false;
    std::ifstream ifs(file.c_str());
    if (ifs.is_open())
    {
        std::string markerLine;
        while (std::getline(ifs, markerLine))
        {
            if (markerLine.substr(0, 8) == "<<<<<<< ")
            {
                hasConflictMarker = true;
                break;
            }
        }
    }
    if (hasConflictMarker)
        conflictFiles.push_back(file);
}
```

`STATUS_CONFLICT` 判定 (CVS/Entries の ts_conflict タイムスタンプ ↔ ファイルの mtime の asctime 文字列比較) は CVSNT 3.5.24 との組み合わせで失敗する。conflict marker (`<<<<<<< `) の有無を直接確認する方式に置き換え。

#### ビルド・配布

- [x] `TortoiseAct.exe` 再ビルド (Release/x64, エラーなし) ✅
- [x] `dist\TortoiseCVS-x64\TortoiseAct.exe` 更新 (2026-04-23 18:15) ✅

#### 動作確認 (業務PC で要確認)

- [ ] Output ダイアログに "C filename" が表示される
- [ ] コンフリクトファイル一覧ダイアログが出る
- [ ] 正常ファイル (M, U など) への誤検出がない

---

---

### Step 7b: 開発PC テストデータ再作成 (未着手)

#### 作業内容

開発PC の `test-work/cvsnt-cp932-checkout/` は旧 cvs.exe (CP_UTF8) で作成したため CVS/Entries の日本語ファイル名が UTF-8 になっている。新 cvs.exe で checkout し直して CP932 の Entries を再生成する。

#### 手順

```cmd
cd test-work
rmdir /s /q cvsnt-cp932-checkout
cvs -d :local:C:/Ap/TortoiseCVS64/test-cvsroot checkout <モジュール名>
```

実行後、`CVS/Entries` の日本語ファイル名部分のバイト列が CP932 (`90 56` = "新") になっていることを確認する。

---

### Step 9b: TortoiseOverlay アイコン表示対応 ✅ 完了 (2026-04-23)

#### 背景

Windows Explorer の `ShellIconOverlayIdentifiers` は最大15スロットしか処理しない。TortoiseGit 等が先に登録するため TortoiseCVS 独自のスロット (TortoiseCVS0〜6) は枯渇し、アイコンオーバーレイが表示されない。

#### 解決方式：TortoiseOverlays.dll 公式相乗り

TortoiseOverlays.dll は `HKLM\SOFTWARE\TortoiseOverlays\{種別}\{クライアント}` に登録された CLSID を読み取り、各クライアント DLL の `IsMemberOf()` を呼び出してオーバーレイを決定する設計。TortoiseGit のスロット (Tortoise0〜9) 経由で TortoiseOverlays.dll が動作するため、TortoiseCVS はそこに相乗りすれば15スロット制限を回避できる。

#### 修正内容

**1. `src/TortoiseShell/ShellExt.h`** — CVS 用 TortoiseOverlays CLSID 7個を DEFINE_GUID で定義

```cpp
// CLSIDs registered under HKLM\SOFTWARE\TortoiseOverlays\*\CVS for shared overlay via TortoiseOverlays.dll
DEFINE_GUID(CLSID_TortoiseCVSOverlay_Normal,      0x06367927, 0x6A25, 0x4087, 0x97, 0xBC, 0x22, 0xE4, 0xC8, 0x19, 0xD7, 0xD3);
DEFINE_GUID(CLSID_TortoiseCVSOverlay_Modified,    0xDD9F1BBF, 0x004E, 0x4D7E, 0x82, 0xBC, 0x50, 0x9A, 0x79, 0x10, 0x1C, 0x65);
DEFINE_GUID(CLSID_TortoiseCVSOverlay_Conflict,    0xF2CBE515, 0xCAFA, 0x465B, 0x9E, 0x2C, 0xAB, 0x80, 0x6F, 0x3F, 0x31, 0x3F);
DEFINE_GUID(CLSID_TortoiseCVSOverlay_Added,       0x3B8D1AB7, 0xE0FD, 0x4C0A, 0xB7, 0x49, 0x0B, 0x5F, 0xCF, 0x8C, 0x13, 0x5B);
DEFINE_GUID(CLSID_TortoiseCVSOverlay_Ignored,     0x17F29A72, 0xFE71, 0x4A44, 0xB6, 0x4F, 0xB9, 0xF3, 0xA6, 0x0E, 0x3D, 0x94);
DEFINE_GUID(CLSID_TortoiseCVSOverlay_ReadOnly,    0x407086D3, 0xBB16, 0x4B50, 0xA3, 0xB2, 0xA9, 0x65, 0xC0, 0x02, 0xD7, 0xCF);
DEFINE_GUID(CLSID_TortoiseCVSOverlay_Unversioned, 0x488E3E10, 0x3D35, 0x4F85, 0x9C, 0x38, 0x14, 0x3E, 0x8D, 0x43, 0x96, 0xC7);
```

**2. `src/TortoiseShell/ShellExt.cpp` (DllGetClassObject)** — 7 CLSID に対応する CShellExtClassFactory 生成処理を追加

```cpp
// TortoiseOverlays.dll shared overlay CLSIDs (HKLM\SOFTWARE\TortoiseOverlays\*\CVS)
else if (IsEqualIID(rclsid, CLSID_TortoiseCVSOverlay_Normal))
    whichClass = TORTOISE_OLE_INCVS;
else if (IsEqualIID(rclsid, CLSID_TortoiseCVSOverlay_Modified))
    whichClass = TORTOISE_OLE_CHANGED;
else if (IsEqualIID(rclsid, CLSID_TortoiseCVSOverlay_Conflict))
    whichClass = TORTOISE_OLE_CONFLICT;
else if (IsEqualIID(rclsid, CLSID_TortoiseCVSOverlay_Added))
    whichClass = TORTOISE_OLE_ADDED;
else if (IsEqualIID(rclsid, CLSID_TortoiseCVSOverlay_Ignored))
    whichClass = TORTOISE_OLE_IGNORED;
else if (IsEqualIID(rclsid, CLSID_TortoiseCVSOverlay_ReadOnly))
    whichClass = TORTOISE_OLE_INCVSREADONLY;
else if (IsEqualIID(rclsid, CLSID_TortoiseCVSOverlay_Unversioned))
    whichClass = TORTOISE_OLE_NOTINCVS;
```

**3. `build/install64.reg` および `dist/TortoiseCVS-x64/install64.reg`** — 7 CLSID を HKCR\CLSID に COM 登録 + Shell Extensions Approved に追加

#### TortoiseGit への影響

なし。TortoiseGit の CLSID ({C5994560-53D9-4125-87C9-F193FC689CB2} 等) は一切変更していない。

#### ビルド・配布

- [x] `TortoiseShell.dll` 再ビルド → `dist\TortoiseCVS-x64\TortoiseShell64.dll` 更新 (2026-04-23) ✅
- [x] `install64.reg` (build/ および dist/) に 7 CLSID エントリ追加 ✅
- [x] レジストリ適用済み (HKCR 部分は reg import で適用、Shell Extensions Approved は管理者 PowerShell で適用) ✅

#### 動作確認 (業務PC で要確認)

- [ ] エクスプローラーで CVS 管理下フォルダにアイコンオーバーレイが表示される
- [ ] Modified / Conflict / Added / Normal 等の各状態が正しいアイコンで表示される

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
