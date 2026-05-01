;;; Icon handler COM controls

; Normal (5d1cb710) - used by context menu, property sheet, and column handlers
Root: HKCR32; Subkey: CLSID\{{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: CLSID\{{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check:
Root: HKCR32; Subkey: CLSID\{{5d1cb710-1c4b-11d4-bed5-005004b1f42f}\InProcServer32; ValueType: string; ValueName: ; ValueData: {app}\TortoiseShell.dll; Check:
Root: HKCR32; Subkey: CLSID\{{5d1cb710-1c4b-11d4-bed5-005004b1f42f}\InProcServer32; ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check:

Root: HKCR64; Subkey: CLSID\{{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{5d1cb710-1c4b-11d4-bed5-005004b1f42f}\InProcServer32; ValueType: string; ValueName: ; ValueData: {app}\TortoiseShell64.dll; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{5d1cb710-1c4b-11d4-bed5-005004b1f42f}\InProcServer32; ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: IsWin64

; Make them approved by administrator
Root: HKLM32; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; ValueData: TortoiseCVS; Flags: uninsdeletevalue

Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64

; Context menu handlers
Root: HKCR32; Subkey: Directory\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: Directory\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: Directory\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: Directory\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
Root: HKCR32; Subkey: Directory\Background\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: Directory\Background\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: Directory\Background\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: Directory\Background\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
Root: HKCR32; Subkey: Drive\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: Drive\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: Drive\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: Drive\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
Root: HKCR32; Subkey: Folder\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: Folder\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: Folder\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: Folder\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
Root: HKCR32; Subkey: *\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: *\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: *\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: *\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
Root: HKCR32; Subkey: InternetShortcut\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: InternetShortcut\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: InternetShortcut\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: InternetShortcut\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
Root: HKCR32; Subkey: lnkfile\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: lnkfile\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: lnkfile\shellex\ContextMenuHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: lnkfile\shellex\ContextMenuHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
; Property page handler
Root: HKCR32; Subkey: *\shellex\PropertySheetHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: *\shellex\PropertySheetHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: *\shellex\PropertySheetHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: *\shellex\PropertySheetHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
Root: HKCR32; Subkey: Folder\shellex\PropertySheetHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: Folder\shellex\PropertySheetHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: Folder\shellex\PropertySheetHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: Folder\shellex\PropertySheetHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
Root: HKCR32; Subkey: Folder\shellex\{{00021500-0000-0000-c000-000000000046}; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: Folder\shellex\{{00021500-0000-0000-c000-000000000046}; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: Folder\shellex\{{00021500-0000-0000-c000-000000000046}; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: Folder\shellex\{{00021500-0000-0000-c000-000000000046}; ValueType: string; ValueName: ; ValueData: {{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
; Column provider
Root: HKCR32; Subkey: Folder\shellex\ColumnHandlers\{{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: Folder\shellex\ColumnHandlers\{{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check:
Root: HKCR64; Subkey: Folder\shellex\ColumnHandlers\{{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: Folder\shellex\ColumnHandlers\{{5d1cb710-1c4b-11d4-bed5-005004b1f42f}; ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check: IsWin64
; Support for cvs: URLs (e.g. cvs://:pserver:anonymous@cvs.tortoisecvs.sourceforge.net:/cvsroot/tortoisecvs#tortoisecvs-1-0-4)
Root: HKCR32; Subkey: CVS; ValueType: string; ValueName: ; ValueData: "URL:CVS Protocol"; Check:
Root: HKCR32; Subkey: CVS; ValueType: string; ValueName: "URL Protocol"; ValueData: ; Check:
Root: HKCR32; Subkey: CVS\DefaultIcon; ValueType: string; ValueName: ; ValueData: "{app}\TortoiseAct.exe"; Check:
Root: HKCR32; Subkey: CVS\shell\open\command; ValueType: string; ValueName: ; ValueData: """{app}\TortoiseAct.exe"" cvsurl -u ""%1"""; Check:
Root: HKCR64; Subkey: CVS; ValueType: string; ValueName: ; ValueData: "URL:CVS Protocol"; Check: IsWin64
Root: HKCR64; Subkey: CVS; ValueType: string; ValueName: "URL Protocol"; ValueData: ; Check: IsWin64
Root: HKCR64; Subkey: CVS\DefaultIcon; ValueType: string; ValueName: ; ValueData: "{app}\TortoiseAct.exe"; Check: IsWin64
Root: HKCR64; Subkey: CVS\shell\open\command; ValueType: string; ValueName: ; ValueData: """{app}\TortoiseAct.exe"" cvsurl -u ""%1"""; Check: IsWin64
; ExplorerCommand COM registration (Windows 11 modern context menu)
Root: HKCR32; Subkey: CLSID\{{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: CLSID\{{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check:
Root: HKCR32; Subkey: CLSID\{{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}\InProcServer32; ValueType: string; ValueName: ; ValueData: {app}\TortoiseShell.dll; Check:
Root: HKCR32; Subkey: CLSID\{{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}\InProcServer32; ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check:
Root: HKCR64; Subkey: CLSID\{{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; ValueType: string; ValueName: ; ValueData: TortoiseCVS; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}\InProcServer32; ValueType: string; ValueName: ; ValueData: {app}\TortoiseShell64.dll; Check: IsWin64
Root: HKCR64; Subkey: CLSID\{{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}\InProcServer32; ValueType: string; ValueName: ThreadingModel; ValueData: Apartment; Check: IsWin64
Root: HKLM32; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; ValueData: TortoiseCVS; Flags: uninsdeletevalue
Root: HKLM64; Subkey: SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved; ValueType: string; ValueName: {{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; ValueData: TortoiseCVS; Flags: uninsdeletevalue; Check: IsWin64
; ExplorerCommandHandlers for *, Directory, Drive, Folder
Root: HKCR32; Subkey: *\ShellEx\ExplorerCommandHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: *\ShellEx\ExplorerCommandHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: *\ShellEx\ExplorerCommandHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: *\ShellEx\ExplorerCommandHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
Root: HKCR32; Subkey: Directory\ShellEx\ExplorerCommandHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: Directory\ShellEx\ExplorerCommandHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: Directory\ShellEx\ExplorerCommandHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: Directory\ShellEx\ExplorerCommandHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
Root: HKCR32; Subkey: Drive\ShellEx\ExplorerCommandHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: Drive\ShellEx\ExplorerCommandHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: Drive\ShellEx\ExplorerCommandHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: Drive\ShellEx\ExplorerCommandHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
Root: HKCR32; Subkey: Folder\ShellEx\ExplorerCommandHandlers\TortoiseCVS; Flags: uninsdeletekey; Check:
Root: HKCR32; Subkey: Folder\ShellEx\ExplorerCommandHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; Check:
Root: HKCR64; Subkey: Folder\ShellEx\ExplorerCommandHandlers\TortoiseCVS; Flags: uninsdeletekey; Check: IsWin64
Root: HKCR64; Subkey: Folder\ShellEx\ExplorerCommandHandlers\TortoiseCVS; ValueType: string; ValueName: ; ValueData: {{5d1cb71a-1c4b-11d4-bed5-005004b1f42f}; Check: IsWin64
