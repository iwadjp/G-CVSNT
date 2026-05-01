// TortoiseCVS - a Windows shell extension for easy version control
// Windows 11 modern context menu support via IExplorerCommandHandler
//
// Architecture:
//   CExplorerCommandHandlerFactory  IClassFactory  (created by DllGetClassObject)
//   CExplorerCommandHandler         IExplorerCommandHandler  (top-level handler)
//   CExplorerCommandEnum            IEnumExplorerCommand     (enumerates sub-commands)
//   CExplorerCommandItem            IExplorerCommand         (one CVS command or separator)
//
// Registration (build/install64.reg / registry.iss):
//   HKCU\Software\Classes\*\shell\TortoiseCVS\
//     ExplorerCommandHandler = {5d1cb71a-1c4b-11d4-bed5-005004b1f42f}
//     MUIVerb                = TortoiseCVS
//     SubCommands            =        (empty: use EnumCommands from handler)

#include "StdAfx.h"
#include "ShellExt.h"
#include "ExplorerCommand.h"
#include "TortoiseShellRes.h"

#include <Utils/Translate.h>
#include <Utils/TortoiseDebug.h>
#include <Utils/Cache.h>
#include <ContextMenus/HasMenu.h>
#include <ContextMenus/MenuDescription.h>
#include <ContextMenus/DefaultMenus.h>

// ---------------------------------------------------------------------------
// Module-level menu data -- initialized once per DLL load
// ---------------------------------------------------------------------------

static std::vector<MenuDescription> s_menus;
static bool                         s_menusInitialized = false;
static CriticalSection              s_menuCS;

static void EnsureMenus()
{
    CSHelper cs(s_menuCS, true);
    if (!s_menusInitialized)
    {
        FillInDefaultMenus(s_menus);
        s_menusInitialized = true;
    }
}

// ---------------------------------------------------------------------------
// Helper: convert IShellItemArray to a vector of file-system paths
// ---------------------------------------------------------------------------

static void FilesFromShellItemArray(IShellItemArray* psia,
                                    std::vector<std::string>& files)
{
    if (!psia) return;
    DWORD count = 0;
    if (FAILED(psia->GetCount(&count))) return;
    for (DWORD i = 0; i < count; ++i)
    {
        IShellItem* pItem = NULL;
        if (FAILED(psia->GetItemAt(i, &pItem))) continue;
        LPWSTR pszPath = NULL;
        if (SUCCEEDED(pItem->GetDisplayName(SIGDN_FILESYSPATH, &pszPath)))
        {
            int len = WideCharToMultiByte(CP_ACP, 0, pszPath, -1, NULL, 0, NULL, NULL);
            if (len > 1)
            {
                std::string path(static_cast<size_t>(len - 1), '\0');
                WideCharToMultiByte(CP_ACP, 0, pszPath, -1, &path[0], len, NULL, NULL);
                files.push_back(path);
            }
            CoTaskMemFree(pszPath);
        }
        pItem->Release();
    }
}

// Map from TortoiseMenus.config icon field to the corresponding numeric
// resource ID in this DLL (defined in TortoiseShellRes.h).
// "switch" has no icon in the RC, so it is omitted → returns 0 → E_NOTIMPL.
// "makemodule" maps to IDI_MAKEMOD (the RC name is "makemod", not "makemodule").
static UINT MenuIconNameToId(const std::string& name)
{
    static const struct { const char* n; UINT id; } kMap[] = {
        { "about",         IDI_ABOUT         },
        { "add",           IDI_ADD           },
        { "branch",        IDI_BRANCH        },
        { "browse",        IDI_BROWSE        },
        { "checkout",      IDI_CHECKOUT      },
        { "command",       IDI_COMMAND       },
        { "commit",        IDI_COMMIT        },
        { "compare",       IDI_COMPARE       },
        { "delete",        IDI_DELETE        },
        { "help",          IDI_HELP          },
        { "ignore",        IDI_IGNORE        },
        { "lock",          IDI_LOCK          },
        { "log",           IDI_LOG           },
        { "makemodule",    IDI_MAKEMOD       },
        { "merge",         IDI_MERGE         },
        { "patch",         IDI_PATCH         },
        { "refresh",       IDI_REFRESH       },
        { "release",       IDI_RELEASE       },
        { "rename",        IDI_RENAME        },
        { "resolve",       IDI_RESOLVE       },
        { "revert",        IDI_REVERT        },
        { "revisiongraph", IDI_REVISIONGRAPH },
        { "settings",      IDI_SETTINGS      },
        { "showedits",     IDI_SHOWEDITS     },
        { "tag",           IDI_TAG           },
        { "tortoise",      IDI_TORTOISE      },
        { "update",        IDI_UPDATE        },
    };
    for (size_t i = 0; i < sizeof(kMap) / sizeof(kMap[0]); ++i)
        if (name == kMap[i].n) return kMap[i].id;
    return 0;
}

// Build "<dllpath>,-<id>" CoTaskMem string for IExplorerCommand::GetIcon.
// The negative-index format tells the shell to load by integer resource ID.
// Returns E_NOTIMPL when id == 0 (no icon available for this command).
static HRESULT GetIconSpecForId(UINT id, LPWSTR* ppszIcon)
{
    if (!ppszIcon) return E_POINTER;
    *ppszIcon = NULL;
    if (!id) return E_NOTIMPL;
    wchar_t dllPath[MAX_PATH];
    if (!GetModuleFileNameW(g_hInstance, dllPath, MAX_PATH))
        return E_NOTIMPL;
    wchar_t buf[MAX_PATH + 16];
    if (swprintf_s(buf, _countof(buf), L"%s,-%u", dllPath, id) < 0)
        return E_FAIL;
    size_t len = wcslen(buf);
    *ppszIcon = static_cast<LPWSTR>(CoTaskMemAlloc((len + 1) * sizeof(wchar_t)));
    if (!*ppszIcon) return E_OUTOFMEMORY;
    memcpy(*ppszIcon, buf, (len + 1) * sizeof(wchar_t));
    return S_OK;
}

// Helper: allocate a CoTaskMem wide string from a wxString
static HRESULT AllocCoStr(const wxString& src, LPWSTR* ppszOut)
{
    if (!ppszOut) return E_POINTER;
    const wchar_t* wsrc = src.wc_str();
    size_t len = wcslen(wsrc);
    *ppszOut = static_cast<LPWSTR>(CoTaskMemAlloc((len + 1) * sizeof(wchar_t)));
    if (!*ppszOut) return E_OUTOFMEMORY;
    memcpy(*ppszOut, wsrc, (len + 1) * sizeof(wchar_t));
    return S_OK;
}

// ---------------------------------------------------------------------------
// CExplorerCommandItem -- one CVS command (or separator) in the modern menu
// ---------------------------------------------------------------------------

class CExplorerCommandItem : public IExplorerCommand
{
    ULONG mycRef;
    int   myMenuIndex;
    bool  myIsSeparator;

public:
    CExplorerCommandItem(int menuIndex, bool isSeparator)
        : mycRef(1), myMenuIndex(menuIndex), myIsSeparator(isSeparator)
    {
        InterlockedIncrement(reinterpret_cast<long*>(&g_cRefThisDll));
    }
    virtual ~CExplorerCommandItem()
    {
        InterlockedDecrement(reinterpret_cast<long*>(&g_cRefThisDll));
    }

    // IUnknown
    STDMETHODIMP QueryInterface(REFIID riid, LPVOID* ppv)
    {
        *ppv = NULL;
        if (IsEqualIID(riid, IID_IUnknown) ||
            IsEqualIID(riid, IID_IExplorerCommand))
        {
            *ppv = static_cast<IExplorerCommand*>(this);
            AddRef();
            return S_OK;
        }
        return E_NOINTERFACE;
    }
    STDMETHODIMP_(ULONG) AddRef()
    {
        return ++mycRef;
    }
    STDMETHODIMP_(ULONG) Release()
    {
        if (--mycRef) return mycRef;
        delete this;
        return 0;
    }

    // IExplorerCommand::GetTitle
    STDMETHODIMP GetTitle(IShellItemArray* /*psia*/, LPWSTR* ppszName)
    {
        if (!ppszName) return E_POINTER;
        *ppszName = NULL;
        if (myIsSeparator)
        {
            *ppszName = static_cast<LPWSTR>(CoTaskMemAlloc(sizeof(wchar_t)));
            if (!*ppszName) return E_OUTOFMEMORY;
            (*ppszName)[0] = L'\0';
            return S_OK;
        }
        CheckLanguage();
        const MenuDescription& md = s_menus[myMenuIndex];
        wxString text = GetString(wxTextCStr(md.GetMenuText()));
        return AllocCoStr(text, ppszName);
    }

    // IExplorerCommand::GetIcon
    STDMETHODIMP GetIcon(IShellItemArray* /*psia*/, LPWSTR* ppszIcon)
    {
        if (myIsSeparator) { if (ppszIcon) *ppszIcon = NULL; return E_NOTIMPL; }
        const MenuDescription& md = s_menus[myMenuIndex];
        return GetIconSpecForId(MenuIconNameToId(md.GetIcon()), ppszIcon);
    }

    // IExplorerCommand::GetToolTip
    STDMETHODIMP GetToolTip(IShellItemArray* /*psia*/, LPWSTR* ppszInfotip)
    {
        if (!ppszInfotip) return E_POINTER;
        *ppszInfotip = NULL;
        if (myIsSeparator) return E_NOTIMPL;
        CheckLanguage();
        const MenuDescription& md = s_menus[myMenuIndex];
        wxString text = GetString(wxTextCStr(md.GetHelpText()));
        return AllocCoStr(text, ppszInfotip);
    }

    // IExplorerCommand::GetCanonicalName
    STDMETHODIMP GetCanonicalName(GUID* pguid)
    {
        if (!pguid) return E_POINTER;
        *pguid = GUID_NULL;
        return S_OK;
    }

    // IExplorerCommand::GetState
    // Uses HasMenu() with the same flags and file list as IContextMenu3::QueryContextMenu.
    STDMETHODIMP GetState(IShellItemArray* psia, BOOL /*fOkToCostly*/, DWORD* pdwState)
    {
        if (!pdwState) return E_POINTER;
        if (myIsSeparator)
        {
            *pdwState = ECS_ENABLED;
            return S_OK;
        }
        std::vector<std::string> files;
        FilesFromShellItemArray(psia, files);
        const MenuDescription& md = s_menus[myMenuIndex];
        *pdwState = HasMenu(md.GetFlags(), files) ? ECS_ENABLED : ECS_HIDDEN;
        return S_OK;
    }

    // IExplorerCommand::Invoke
    // Delegates to MenuDescription::Perform, mirroring InvokeCommand logic.
    STDMETHODIMP Invoke(IShellItemArray* psia, IBindCtx* /*pbc*/)
    {
        if (myIsSeparator) return E_NOTIMPL;
        std::vector<std::string> files;
        FilesFromShellItemArray(psia, files);
        if (files.empty()) return E_FAIL;
        s_menus[myMenuIndex].Perform(files, NULL);
        return S_OK;
    }

    // IExplorerCommand::GetFlags
    STDMETHODIMP GetFlags(DWORD* pdwFlags)
    {
        if (!pdwFlags) return E_POINTER;
        *pdwFlags = myIsSeparator
            ? static_cast<DWORD>(ECF_ISSEPARATOR)
            : static_cast<DWORD>(ECF_DEFAULT);
        return S_OK;
    }

    // IExplorerCommand::EnumSubCommands -- leaf item, no sub-commands
    STDMETHODIMP EnumSubCommands(IEnumExplorerCommand** ppEnum)
    {
        if (ppEnum) *ppEnum = NULL;
        return E_NOTIMPL;
    }
};

// ---------------------------------------------------------------------------
// CExplorerCommandEnum -- enumerates visible CVS commands for the selection
// ---------------------------------------------------------------------------

class CExplorerCommandEnum : public IEnumExplorerCommand
{
    ULONG                          mycRef;
    std::vector<IExplorerCommand*> myItems;
    ULONG                          myPosition;

public:
    explicit CExplorerCommandEnum(IShellItemArray* psia)
        : mycRef(1), myPosition(0)
    {
        InterlockedIncrement(reinterpret_cast<long*>(&g_cRefThisDll));
        EnsureMenus();

        std::vector<std::string> files;
        FilesFromShellItemArray(psia, files);

        // Evaluate all menu items against the selected files
        std::vector<int> menuFlags(s_menus.size());
        for (size_t i = 0; i < s_menus.size(); ++i)
            menuFlags[i] = s_menus[i].GetFlags();

        std::vector<bool> hasMenus(s_menus.size());
        HasMenus(menuFlags, files, hasMenus);

        // Build the item list, deduplicating verbs and collapsing consecutive separators
        bool        prevWasSeparator = true; // suppress leading separator
        std::string prevVerb;
        for (size_t i = 0; i < s_menus.size(); ++i)
        {
            if (!hasMenus[i]) continue;

            const std::string& verb = s_menus[i].GetVerb();
            const bool isSep = verb.empty();

            if (isSep)
            {
                if (!prevWasSeparator)
                {
                    myItems.push_back(
                        new CExplorerCommandItem(static_cast<int>(i), true));
                    prevWasSeparator = true;
                }
                continue;
            }

            // Deduplicate identical consecutive verbs
            if (verb == prevVerb) continue;
            prevVerb = verb;

            myItems.push_back(
                new CExplorerCommandItem(static_cast<int>(i), false));
            prevWasSeparator = false;
        }

        // Strip trailing separator
        while (!myItems.empty())
        {
            DWORD flags = 0;
            myItems.back()->GetFlags(&flags);
            if (flags & ECF_ISSEPARATOR)
            {
                myItems.back()->Release();
                myItems.pop_back();
            }
            else break;
        }
    }

    ~CExplorerCommandEnum()
    {
        for (size_t i = 0; i < myItems.size(); ++i)
            myItems[i]->Release();
        InterlockedDecrement(reinterpret_cast<long*>(&g_cRefThisDll));
    }

    // IUnknown
    STDMETHODIMP QueryInterface(REFIID riid, LPVOID* ppv)
    {
        *ppv = NULL;
        if (IsEqualIID(riid, IID_IUnknown) ||
            IsEqualIID(riid, IID_IEnumExplorerCommand))
        {
            *ppv = static_cast<IEnumExplorerCommand*>(this);
            AddRef();
            return S_OK;
        }
        return E_NOINTERFACE;
    }
    STDMETHODIMP_(ULONG) AddRef()
    {
        return ++mycRef;
    }
    STDMETHODIMP_(ULONG) Release()
    {
        if (--mycRef) return mycRef;
        delete this;
        return 0;
    }

    // IEnumExplorerCommand
    STDMETHODIMP Next(ULONG celt, IExplorerCommand** rgelt, ULONG* pceltFetched)
    {
        if (!rgelt) return E_POINTER;
        ULONG fetched = 0;
        ULONG total   = static_cast<ULONG>(myItems.size());
        while (fetched < celt && myPosition < total)
        {
            rgelt[fetched] = myItems[myPosition];
            rgelt[fetched]->AddRef();
            ++fetched;
            ++myPosition;
        }
        if (pceltFetched) *pceltFetched = fetched;
        return (fetched == celt) ? S_OK : S_FALSE;
    }

    STDMETHODIMP Skip(ULONG celt)
    {
        ULONG total    = static_cast<ULONG>(myItems.size());
        ULONG newPos   = myPosition + celt;
        myPosition     = (newPos < total) ? newPos : total;
        return S_OK;
    }

    STDMETHODIMP Reset()
    {
        myPosition = 0;
        return S_OK;
    }

    // Clone is not required by Explorer; return E_NOTIMPL
    STDMETHODIMP Clone(IEnumExplorerCommand** ppEnum)
    {
        if (ppEnum) *ppEnum = NULL;
        return E_NOTIMPL;
    }
};

// ---------------------------------------------------------------------------
// CExplorerCommandRoot -- top-level "TortoiseCVS" entry in the modern menu
//
// IExplorerCommandHandler does not exist in Windows SDK 26100.
// The correct pattern is: register ExplorerCommandHandler = {CLSID} in the
// verb key, and have the CLSID implement IExplorerCommand with
// GetFlags() returning ECF_HASSUBCOMMANDS.  Shell then calls EnumSubCommands()
// to populate the fly-out.
// ---------------------------------------------------------------------------

class CExplorerCommandRoot : public IExplorerCommand
{
    ULONG mycRef;

public:
    CExplorerCommandRoot() : mycRef(1)
    {
        InterlockedIncrement(reinterpret_cast<long*>(&g_cRefThisDll));
    }
    virtual ~CExplorerCommandRoot()
    {
        InterlockedDecrement(reinterpret_cast<long*>(&g_cRefThisDll));
    }

    // IUnknown
    STDMETHODIMP QueryInterface(REFIID riid, LPVOID* ppv)
    {
        *ppv = NULL;
        if (IsEqualIID(riid, IID_IUnknown) ||
            IsEqualIID(riid, IID_IExplorerCommand))
        {
            *ppv = static_cast<IExplorerCommand*>(this);
            AddRef();
            return S_OK;
        }
        return E_NOINTERFACE;
    }
    STDMETHODIMP_(ULONG) AddRef()  { return ++mycRef; }
    STDMETHODIMP_(ULONG) Release() { if (--mycRef) return mycRef; delete this; return 0; }

    // IExplorerCommand -- root entry shows "TortoiseCVS" with a fly-out
    STDMETHODIMP GetTitle(IShellItemArray* /*psia*/, LPWSTR* ppszName)
    {
        if (!ppszName) return E_POINTER;
        static const wchar_t kTitle[] = L"TortoiseCVS";
        *ppszName = static_cast<LPWSTR>(
            CoTaskMemAlloc(sizeof(kTitle)));
        if (!*ppszName) return E_OUTOFMEMORY;
        memcpy(*ppszName, kTitle, sizeof(kTitle));
        return S_OK;
    }

    STDMETHODIMP GetIcon(IShellItemArray* /*psia*/, LPWSTR* ppszIcon)
    {
        return GetIconSpecForId(IDI_TORTOISE, ppszIcon);
    }

    STDMETHODIMP GetToolTip(IShellItemArray* /*psia*/, LPWSTR* ppszInfotip)
    {
        if (ppszInfotip) *ppszInfotip = NULL;
        return E_NOTIMPL;
    }

    STDMETHODIMP GetCanonicalName(GUID* pguid)
    {
        if (!pguid) return E_POINTER;
        *pguid = GUID_NULL;
        return S_OK;
    }

    // Show the root entry whenever at least one file is selected
    STDMETHODIMP GetState(IShellItemArray* psia, BOOL /*fOkToCostly*/, DWORD* pdwState)
    {
        if (!pdwState) return E_POINTER;
        DWORD count = 0;
        *pdwState = (psia && SUCCEEDED(psia->GetCount(&count)) && count > 0)
            ? ECS_ENABLED : ECS_HIDDEN;
        return S_OK;
    }

    // Root entry has no direct action -- sub-commands handle execution
    STDMETHODIMP Invoke(IShellItemArray* /*psia*/, IBindCtx* /*pbc*/)
    {
        return E_NOTIMPL;
    }

    STDMETHODIMP GetFlags(DWORD* pdwFlags)
    {
        if (!pdwFlags) return E_POINTER;
        *pdwFlags = ECF_HASSUBCOMMANDS;
        return S_OK;
    }

    // Shell calls EnumSubCommands because GetFlags returned ECF_HASSUBCOMMANDS
    STDMETHODIMP EnumSubCommands(IEnumExplorerCommand** ppEnum)
    {
        if (!ppEnum) return E_POINTER;
        *ppEnum = NULL;
        // psia is not available here; pass NULL and let GetState handle per-item
        CExplorerCommandEnum* pEnum = new CExplorerCommandEnum(NULL);
        if (!pEnum) return E_OUTOFMEMORY;
        *ppEnum = pEnum;   // already AddRef'd by constructor (mycRef=1)
        return S_OK;
    }
};

// ---------------------------------------------------------------------------
// CExplorerCommandHandlerFactory -- IClassFactory for CExplorerCommandRoot
// ---------------------------------------------------------------------------

class CExplorerCommandHandlerFactory : public IClassFactory
{
    ULONG mycRef;

public:
    CExplorerCommandHandlerFactory() : mycRef(1)
    {
        InterlockedIncrement(reinterpret_cast<long*>(&g_cRefThisDll));
    }
    virtual ~CExplorerCommandHandlerFactory()
    {
        InterlockedDecrement(reinterpret_cast<long*>(&g_cRefThisDll));
    }

    STDMETHODIMP QueryInterface(REFIID riid, LPVOID* ppv)
    {
        *ppv = NULL;
        if (IsEqualIID(riid, IID_IUnknown) ||
            IsEqualIID(riid, IID_IClassFactory))
        {
            *ppv = static_cast<IClassFactory*>(this);
            AddRef();
            return S_OK;
        }
        return E_NOINTERFACE;
    }
    STDMETHODIMP_(ULONG) AddRef()
    {
        return ++mycRef;
    }
    STDMETHODIMP_(ULONG) Release()
    {
        if (--mycRef) return mycRef;
        delete this;
        return 0;
    }

    STDMETHODIMP CreateInstance(IUnknown* pOuter, REFIID riid, void** ppv)
    {
        *ppv = NULL;
        if (pOuter) return CLASS_E_NOAGGREGATION;
        CExplorerCommandRoot* pHandler = new CExplorerCommandRoot();
        if (!pHandler) return E_OUTOFMEMORY;
        HRESULT hr = pHandler->QueryInterface(riid, ppv);
        pHandler->Release();
        return hr;
    }

    STDMETHODIMP LockServer(BOOL /*fLock*/)
    {
        return S_OK;
    }
};

// ---------------------------------------------------------------------------
// Entry point -- called from DllGetClassObject in ShellExt.cpp
// ---------------------------------------------------------------------------

HRESULT ExplorerCommand_CreateClassFactory(REFIID riid, LPVOID* ppvOut)
{
    CExplorerCommandHandlerFactory* pFactory = new CExplorerCommandHandlerFactory();
    if (!pFactory) return E_OUTOFMEMORY;
    HRESULT hr = pFactory->QueryInterface(riid, ppvOut);
    pFactory->Release();
    return hr;
}
