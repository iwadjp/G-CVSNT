; TortoiseCVS (G-CVSNT) x64 installer for GitHub distribution
; Based on TortoiseCVS.iss / registry.iss
; TortoiseOverlays.dll is bundled for systems without TortoiseGit/SVN.
; x64 Windows only.

#define APPVER "2.5.05.3744"
#define DISTDIR "..\..\..\..\..\dist\TortoiseCVS-x64"

[Setup]
AppID=TortoiseCVS
AppName=TortoiseCVS (G-CVSNT x64)
AppVerName=TortoiseCVS (G-CVSNT x64) {#APPVER}
AppVersion={#APPVER}
DefaultDirName={commonpf64}\TortoiseCVS64
DefaultGroupName=TortoiseCVS
OutputDir=..\..\..\..\..\dist\installer
OutputBaseFilename=TortoiseCVS-x64-Setup
PrivilegesRequired=admin
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
Compression=lzma/ultra
SolidCompression=yes
DirExistsWarning=no
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\TortoiseAct.exe
MinVersion=6.1sp1

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"

[Files]
; Main executables
Source: {#DISTDIR}\cvs.exe;               DestDir: {app}; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\TortoiseAct.exe;       DestDir: {app}; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\TortoisePlink.exe;     DestDir: {app}; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\TortoiseSetupHelper.exe; DestDir: {app}; Flags: ignoreversion

; Shell extension DLL (64-bit)
Source: {#DISTDIR}\TortoiseShell64.dll;   DestDir: {app}; Flags: restartreplace uninsrestartdelete ignoreversion

; GDI+
Source: {#DISTDIR}\gdiplus.dll;           DestDir: {app}; Flags: restartreplace uninsrestartdelete

; CVSNT runtime DLLs
Source: {#DISTDIR}\cvsapi.dll;            DestDir: {app}; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\cvstools.dll;          DestDir: {app}; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\mdnsclient.dll;        DestDir: {app}; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\plink.dll;             DestDir: {app}; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\libcrypto-1_1-x64.dll; DestDir: {app}; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\libssl-1_1-x64.dll;   DestDir: {app}; Flags: restartreplace uninsrestartdelete ignoreversion

; Configuration
Source: {#DISTDIR}\TortoiseMenus.config;  DestDir: {app}; Flags: restartreplace uninsrestartdelete

; Protocol plugins
Source: {#DISTDIR}\protocols\enum.dll;    DestDir: {app}\protocols; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\protocols\ext.dll;     DestDir: {app}\protocols; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\protocols\fork.dll;    DestDir: {app}\protocols; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\protocols\gserver.dll; DestDir: {app}\protocols; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\protocols\pserver.dll; DestDir: {app}\protocols; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\protocols\server.dll;  DestDir: {app}\protocols; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\protocols\sserver.dll; DestDir: {app}\protocols; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\protocols\ssh.dll;     DestDir: {app}\protocols; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\protocols\sspi.dll;    DestDir: {app}\protocols; Flags: restartreplace uninsrestartdelete ignoreversion

; Trigger plugins
Source: {#DISTDIR}\triggers\audit.dll;    DestDir: {app}\triggers; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\triggers\checkout.dll; DestDir: {app}\triggers; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\triggers\email.dll;    DestDir: {app}\triggers; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\triggers\info.dll;     DestDir: {app}\triggers; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\triggers\script.dll;   DestDir: {app}\triggers; Flags: restartreplace uninsrestartdelete ignoreversion

; Database plugins
Source: {#DISTDIR}\database\odbc.dll;     DestDir: {app}\database; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\database\sqlite.dll;   DestDir: {app}\database; Flags: restartreplace uninsrestartdelete ignoreversion

; mDNS plugins
Source: {#DISTDIR}\mdns\apple.dll;        DestDir: {app}\mdns; Flags: restartreplace uninsrestartdelete ignoreversion
Source: {#DISTDIR}\mdns\mini.dll;         DestDir: {app}\mdns; Flags: restartreplace uninsrestartdelete ignoreversion

; xdiff plugins
Source: {#DISTDIR}\xdiff\xml.dll;         DestDir: {app}\xdiff; Flags: restartreplace uninsrestartdelete ignoreversion

; TortoiseOverlays (bundled for systems without TortoiseGit/SVN)
; License: TortoiseSVN Project (https://tortoisesvn.net) - see installed License.txt
Source: "C:\Program Files\Common Files\TortoiseOverlays\TortoiseOverlays.dll"; DestDir: {commonpf64}\Common Files\TortoiseOverlays; Flags: ignoreversion; Check: not TortoiseOverlaysInstalled
Source: "C:\Program Files\Common Files\TortoiseOverlays\icons\*";              DestDir: {commonpf64}\Common Files\TortoiseOverlays\icons; Flags: ignoreversion recursesubdirs createallsubdirs; Check: not TortoiseOverlaysInstalled
Source: "C:\Program Files\Common Files\TortoiseOverlays\License.txt";          DestDir: {commonpf64}\Common Files\TortoiseOverlays; Flags: ignoreversion; Check: not TortoiseOverlaysInstalled

[Registry]

; --- Standard TortoiseCVS shell extension CLSIDs and handlers ---
#include "registry.iss"

; --- Installation path in 64-bit hive (TortoiseRegistry uses KEY_WOW64_64KEY) ---
Root: HKLM64; Subkey: SOFTWARE\TortoiseCVS; ValueType: string; ValueName: RootDir; ValueData: "{app}\"; Flags: uninsdeletevalue; Check: IsWin64

; --- TortoiseOverlays shared CLSIDs (x64) ---
; These 7 CLSIDs are read by TortoiseOverlays.dll from HKLM\SOFTWARE\TortoiseOverlays\*\CVS.
; Each CLSID must be registered as a COM InProcServer32 pointing to TortoiseShell64.dll.

; Normal
Root: HKCR64; Subkey: CLSID\{{06367927-6A25-4087-97BC-22E4C819D7D3};                       Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{06367927-6A25-4087-97BC-22E4C819D7D3};                       ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{06367927-6A25-4087-97BC-22E4C819D7D3}\InProcServer32;        ValueType: string; ValueName: ; ValueData: {app}\TortoiseShell64.dll; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{06367927-6A25-4087-97BC-22E4C819D7D3}\InProcServer32;        ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: IsWin64
; Modified
Root: HKCR64; Subkey: CLSID\{{DD9F1BBF-004E-4D7E-82BC-509A79101C65};                       Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{DD9F1BBF-004E-4D7E-82BC-509A79101C65};                       ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{DD9F1BBF-004E-4D7E-82BC-509A79101C65}\InProcServer32;        ValueType: string; ValueName: ; ValueData: {app}\TortoiseShell64.dll; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{DD9F1BBF-004E-4D7E-82BC-509A79101C65}\InProcServer32;        ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: IsWin64
; Conflict
Root: HKCR64; Subkey: CLSID\{{F2CBE515-CAFA-465B-9E2C-AB806F3F313F};                       Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{F2CBE515-CAFA-465B-9E2C-AB806F3F313F};                       ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{F2CBE515-CAFA-465B-9E2C-AB806F3F313F}\InProcServer32;        ValueType: string; ValueName: ; ValueData: {app}\TortoiseShell64.dll; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{F2CBE515-CAFA-465B-9E2C-AB806F3F313F}\InProcServer32;        ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: IsWin64
; Added
Root: HKCR64; Subkey: CLSID\{{3B8D1AB7-E0FD-4C0A-B749-0B5FCF8C135B};                       Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{3B8D1AB7-E0FD-4C0A-B749-0B5FCF8C135B};                       ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{3B8D1AB7-E0FD-4C0A-B749-0B5FCF8C135B}\InProcServer32;        ValueType: string; ValueName: ; ValueData: {app}\TortoiseShell64.dll; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{3B8D1AB7-E0FD-4C0A-B749-0B5FCF8C135B}\InProcServer32;        ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: IsWin64
; Ignored
Root: HKCR64; Subkey: CLSID\{{17F29A72-FE71-4A44-B64F-B9F3A60E3D94};                       Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{17F29A72-FE71-4A44-B64F-B9F3A60E3D94};                       ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{17F29A72-FE71-4A44-B64F-B9F3A60E3D94}\InProcServer32;        ValueType: string; ValueName: ; ValueData: {app}\TortoiseShell64.dll; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{17F29A72-FE71-4A44-B64F-B9F3A60E3D94}\InProcServer32;        ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: IsWin64
; ReadOnly
Root: HKCR64; Subkey: CLSID\{{407086D3-BB16-4B50-A3B2-A965C002D7CF};                       Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{407086D3-BB16-4B50-A3B2-A965C002D7CF};                       ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{407086D3-BB16-4B50-A3B2-A965C002D7CF}\InProcServer32;        ValueType: string; ValueName: ; ValueData: {app}\TortoiseShell64.dll; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{407086D3-BB16-4B50-A3B2-A965C002D7CF}\InProcServer32;        ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: IsWin64
; Unversioned
Root: HKCR64; Subkey: CLSID\{{488E3E10-3D35-4F85-9C38-143E8D4396C7};                       Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{488E3E10-3D35-4F85-9C38-143E8D4396C7};                       ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{488E3E10-3D35-4F85-9C38-143E8D4396C7}\InProcServer32;        ValueType: string; ValueName: ; ValueData: {app}\TortoiseShell64.dll; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{488E3E10-3D35-4F85-9C38-143E8D4396C7}\InProcServer32;        ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: IsWin64

; --- TortoiseOverlays type-to-CLSID mapping (x64) ---
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\Normal;      ValueType: string; ValueName: CVS; ValueData: {{06367927-6A25-4087-97BC-22E4C819D7D3}; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\Modified;    ValueType: string; ValueName: CVS; ValueData: {{DD9F1BBF-004E-4D7E-82BC-509A79101C65}; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\Conflict;    ValueType: string; ValueName: CVS; ValueData: {{F2CBE515-CAFA-465B-9E2C-AB806F3F313F}; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\Added;       ValueType: string; ValueName: CVS; ValueData: {{3B8D1AB7-E0FD-4C0A-B749-0B5FCF8C135B}; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\Ignored;     ValueType: string; ValueName: CVS; ValueData: {{17F29A72-FE71-4A44-B64F-B9F3A60E3D94}; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\ReadOnly;    ValueType: string; ValueName: CVS; ValueData: {{407086D3-BB16-4B50-A3B2-A965C002D7CF}; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\Unversioned; ValueType: string; ValueName: CVS; ValueData: {{488E3E10-3D35-4F85-9C38-143E8D4396C7}; Check: IsWin64
; Deleted/Locked CVS values (old CLSIDs) are removed in CurStepChanged below

; --- Shell Extensions Approved for TortoiseOverlays shared CLSIDs ---
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{06367927-6A25-4087-97BC-22E4C819D7D3}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{DD9F1BBF-004E-4D7E-82BC-509A79101C65}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{F2CBE515-CAFA-465B-9E2C-AB806F3F313F}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{3B8D1AB7-E0FD-4C0A-B749-0B5FCF8C135B}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{17F29A72-FE71-4A44-B64F-B9F3A60E3D94}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{407086D3-BB16-4B50-A3B2-A965C002D7CF}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{488E3E10-3D35-4F85-9C38-143E8D4396C7}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64

; --- TortoiseOverlays COM CLSID registration (only when bundling DLL) ---
; ThreadingModel=Apartment, points to {commonpf64}\Common Files\TortoiseOverlays\TortoiseOverlays.dll
; Tortoise1Normal
Root: HKCR64; Subkey: CLSID\{{C5994560-53D9-4125-87C9-F193FC689CB2};                    ValueType: string; ValueName: ; ValueData: TortoiseOverlays Class; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994560-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ; ValueData: {commonpf64}\Common Files\TortoiseOverlays\TortoiseOverlays.dll; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994560-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: not TortoiseOverlaysInstalled
; Tortoise2Modified
Root: HKCR64; Subkey: CLSID\{{C5994561-53D9-4125-87C9-F193FC689CB2};                    ValueType: string; ValueName: ; ValueData: TortoiseOverlays Class; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994561-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ; ValueData: {commonpf64}\Common Files\TortoiseOverlays\TortoiseOverlays.dll; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994561-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: not TortoiseOverlaysInstalled
; Tortoise3Conflict
Root: HKCR64; Subkey: CLSID\{{C5994562-53D9-4125-87C9-F193FC689CB2};                    ValueType: string; ValueName: ; ValueData: TortoiseOverlays Class; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994562-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ; ValueData: {commonpf64}\Common Files\TortoiseOverlays\TortoiseOverlays.dll; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994562-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: not TortoiseOverlaysInstalled
; Tortoise4Locked
Root: HKCR64; Subkey: CLSID\{{C5994563-53D9-4125-87C9-F193FC689CB2};                    ValueType: string; ValueName: ; ValueData: TortoiseOverlays Class; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994563-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ; ValueData: {commonpf64}\Common Files\TortoiseOverlays\TortoiseOverlays.dll; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994563-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: not TortoiseOverlaysInstalled
; Tortoise5ReadOnly
Root: HKCR64; Subkey: CLSID\{{C5994564-53D9-4125-87C9-F193FC689CB2};                    ValueType: string; ValueName: ; ValueData: TortoiseOverlays Class; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994564-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ; ValueData: {commonpf64}\Common Files\TortoiseOverlays\TortoiseOverlays.dll; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994564-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: not TortoiseOverlaysInstalled
; Tortoise6Deleted
Root: HKCR64; Subkey: CLSID\{{C5994565-53D9-4125-87C9-F193FC689CB2};                    ValueType: string; ValueName: ; ValueData: TortoiseOverlays Class; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994565-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ; ValueData: {commonpf64}\Common Files\TortoiseOverlays\TortoiseOverlays.dll; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994565-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: not TortoiseOverlaysInstalled
; Tortoise7Added
Root: HKCR64; Subkey: CLSID\{{C5994566-53D9-4125-87C9-F193FC689CB2};                    ValueType: string; ValueName: ; ValueData: TortoiseOverlays Class; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994566-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ; ValueData: {commonpf64}\Common Files\TortoiseOverlays\TortoiseOverlays.dll; Check: not TortoiseOverlaysInstalled
Root: HKCR64; Subkey: CLSID\{{C5994566-53D9-4125-87C9-F193FC689CB2}\InProcServer32;     ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: not TortoiseOverlaysInstalled

; --- ShellIconOverlayIdentifiers (only when bundling DLL) ---
; Leading double-space gives higher sort priority than OneDrive/Google Drive entries
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\  Tortoise1Normal;      ValueType: string; ValueName: ; ValueData: {{C5994560-53D9-4125-87C9-F193FC689CB2}; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\  Tortoise2Modified;    ValueType: string; ValueName: ; ValueData: {{C5994561-53D9-4125-87C9-F193FC689CB2}; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\  Tortoise3Conflict;    ValueType: string; ValueName: ; ValueData: {{C5994562-53D9-4125-87C9-F193FC689CB2}; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\  Tortoise4Locked;      ValueType: string; ValueName: ; ValueData: {{C5994563-53D9-4125-87C9-F193FC689CB2}; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\  Tortoise5ReadOnly;    ValueType: string; ValueName: ; ValueData: {{C5994564-53D9-4125-87C9-F193FC689CB2}; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\  Tortoise6Deleted;     ValueType: string; ValueName: ; ValueData: {{C5994565-53D9-4125-87C9-F193FC689CB2}; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\  Tortoise7Added;       ValueType: string; ValueName: ; ValueData: {{C5994566-53D9-4125-87C9-F193FC689CB2}; Flags: uninsdeletekey; Check: not TortoiseOverlaysInstalled

[Icons]
Name: {group}\Preferences; Filename: {app}\TortoiseAct.exe; Parameters: CVSPrefs
Name: {group}\About;       Filename: {app}\TortoiseAct.exe; Parameters: CVSAbout

[UninstallDelete]
Type: Files; Name: {app}\TortoiseSetupHelper.exe

[Code]
function TortoiseOverlaysInstalled(): Boolean;
begin
  Result := RegKeyExists(HKLM,
    'SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\' +
    'ShellIconOverlayIdentifiers\  Tortoise1Normal');
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then begin
    RegDeleteValue(HKLM64, 'SOFTWARE\TortoiseOverlays\Deleted', 'CVS');
    RegDeleteValue(HKLM64, 'SOFTWARE\TortoiseOverlays\Locked', 'CVS');
  end;
end;

function InitializeSetup(): Boolean;
begin
  Result := True;
end;
