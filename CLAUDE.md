# G-CVSNT プロジェクト

## 作業概要
TortoiseCVSをWindows 11 x64対応にするフォークプロジェクト。

## 重要パス
- ソース: D:\iwa\AI\Claude\cvs_app\G-CVSNT\
- CVSNTビルド出力: cvsnt\cvsnt-2.5.05.3744\Releasex64\
- TortoiseShell: cvsnt\tortoiseCVS\TortoiseCVS\build\vc18x64\TortoiseShell\Release\
- 現在の動作DLL登録先: C:\Ap\TortoiseCVS64\

## ビルド環境
- Visual Studio 2026 (v18)
- cmake: C:\Program Files\Microsoft Visual Studio\18\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe
- bison/flex: C:\winflexbison\
- VsDevCmd: C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat

## 作業進捗
PROGRESS.md を参照。

## 注意事項
- 管理者権限が必要な操作はPowerShellで実行
- Explorerを再起動する際は taskkill /f /im explorer.exe → Start-Process explorer.exe
- 元に戻すコマンドは必ず記録してから実行