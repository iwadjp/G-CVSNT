// TortoiseCVS - a Windows shell extension for easy version control
// Windows 11 modern context menu support via IExplorerCommandHandler

#pragma once

// Called from DllGetClassObject when CLSID_TortoiseCVSExplCmd is requested.
HRESULT ExplorerCommand_CreateClassFactory(REFIID riid, LPVOID* ppvOut);
