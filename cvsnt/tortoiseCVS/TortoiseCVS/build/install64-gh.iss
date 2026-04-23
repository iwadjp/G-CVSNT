; TortoiseCVS (G-CVSNT) x64 installer for GitHub distribution
; Based on TortoiseCVS.iss / registry.iss
; Requires: TortoiseGit (which includes TortoiseOverlays.dll) pre-installed.
; x64 Windows only.

#define APPVER "2.5.05.3744"
#define DISTDIR "..\..\..\..\..\dist\TortoiseCVS-x64"

[Setup]
AppID=TortoiseCVS
AppName=TortoiseCVS (G-CVSNT x64)
AppVerName=TortoiseCVS (G-CVSNT x64) {#APPVER}
AppVersion={#APPVER}
DefaultDirName={pf64}\TortoiseCVS64
DefaultGroupName=TortoiseCVS
OutputDir=..\..\..\..\..\dist\installer
OutputBaseFilename=TortoiseCVS-x64-Setup
PrivilegesRequired=admin
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
Compression=lzma/ultra
SolidCompression=yes
DirExistsWarning=no
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\TortoiseAct.exe
MinVersion=6.1

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
; Overwrites values written by registry.iss (which used old 5d1cb71x CLSIDs).
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\Normal;      ValueType: string; ValueName: CVS; ValueData: {{06367927-6A25-4087-97BC-22E4C819D7D3}; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\Modified;    ValueType: string; ValueName: CVS; ValueData: {{DD9F1BBF-004E-4D7E-82BC-509A79101C65}; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\Conflict;    ValueType: string; ValueName: CVS; ValueData: {{F2CBE515-CAFA-465B-9E2C-AB806F3F313F}; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\Added;       ValueType: string; ValueName: CVS; ValueData: {{3B8D1AB7-E0FD-4C0A-B749-0B5FCF8C135B}; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\Ignored;     ValueType: string; ValueName: CVS; ValueData: {{17F29A72-FE71-4A44-B64F-B9F3A60E3D94}; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\ReadOnly;    ValueType: string; ValueName: CVS; ValueData: {{407086D3-BB16-4B50-A3B2-A965C002D7CF}; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\TortoiseOverlays\Unversioned; ValueType: string; ValueName: CVS; ValueData: {{488E3E10-3D35-4F85-9C38-143E8D4396C7}; Check: IsWin64

; --- Shell Extensions Approved for TortoiseOverlays shared CLSIDs ---
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{06367927-6A25-4087-97BC-22E4C819D7D3}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{DD9F1BBF-004E-4D7E-82BC-509A79101C65}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{F2CBE515-CAFA-465B-9E2C-AB806F3F313F}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{3B8D1AB7-E0FD-4C0A-B749-0B5FCF8C135B}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{17F29A72-FE71-4A44-B64F-B9F3A60E3D94}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{407086D3-BB16-4B50-A3B2-A965C002D7CF}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{488E3E10-3D35-4F85-9C38-143E8D4396C7}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64

[Icons]
Name: {group}\Preferences; Filename: {app}\TortoiseAct.exe; Parameters: CVSPrefs
Name: {group}\About;       Filename: {app}\TortoiseAct.exe; Parameters: CVSAbout

[UninstallDelete]
Type: Files; Name: {app}\TortoiseSetupHelper.exe

[Code]
function InitializeSetup(): Boolean;
begin
  Result := True;
  if not RegKeyExists(HKLM, 'SOFTWARE\TortoiseOverlays') then
    MsgBox(
      'TortoiseOverlays is not installed.' + #13#10 +
      'Please install TortoiseGit first to enable icon overlays.' + #13#10#13#10 +
      'Installation will continue, but icon overlays will not appear until TortoiseGit is installed.',
      mbInformation, MB_OK);
end;
