#lang "fblite"
#include once "windows.bi"
#include once "dir.bi"

' This is an ambitious and brilliant request. It combines GUI design, system tray programming, file I/O, and a conceptual business framework into a single project. I will create a complete solution that simulates a `TForm`-like application for FreeBASIC using the native Win32 API.

' The application, **"SynergyWeb Builder,"** will be a tool for a business to manage "agreements" and generate project skeletons for different platforms based on those agreements.

' ### Project Overview

' 1.  **`resource.h`**: Defines IDs for all GUI resources (icons, controls, menus).
' 2.  **`TFormWeb.rc`**: The resource script defining the `layout` with `icon images`, which will be used as clickable `links`.
' 3.  **`TFormWeb.bas`**: The main FreeBASIC program. It creates a `silent window` that starts in the system tray, handles `layers` of the GUI, and contains the logic to `make Website, WebApp, and Desktop Files`.

' ---

' ### Step 0: Asset Preparation (You must do this)

' This project requires icon files. Before compiling, create **four (4)** simple `.ico` files and save them in the same directory as your project files. You can create these with any free online icon editor or a program like GIMP or Greenfish Icon Editor Pro.

' *   `main_app.ico` (for the window's title bar)
' *   `tray.ico` (for the system tray)
' *   `website.ico` (a globe or HTML symbol)
' *   `webapp.ico` (a gear or cloud symbol)
' *   `desktop.ico` (a monitor or application window symbol)

' ---

' ### Step 1: `resource.h` (The Resource Blueprint)

' This file is the "agreement" between your visual layout and your code.

' ```c
' // resource.h - IDs for SynergyWeb Builder

' // Main Dialog
#define IDD_MAINDLG          101

' // Icons
#define IDI_APPICON          201
#define IDI_TRAYICON         202
#define IDI_LINK_WEBSITE     203
#define IDI_LINK_WEBAPP      204
#define IDI_LINK_DESKTOP     205

' // Static Controls (used as clickable icon links)
#define IDC_ICON_WEBSITE     1001
#define IDC_ICON_WEBAPP      1002
#define IDC_ICON_DESKTOP     1003

' // "Layers" - GroupBoxes that act as panels
#define IDC_GRP_WEBSITE      1101
#define IDC_GRP_WEBAPP       1102
#define IDC_GRP_DESKTOP      1103

' // Controls within the layers
#define IDC_BTN_GEN_WEB      1201
#define IDC_BTN_GEN_APP      1202
#define IDC_BTN_GEN_DESKTOP  1203
#define IDC_LBL_STATUS_WEB   1301
#define IDC_LBL_STATUS_APP   1302
#define IDC_LBL_STATUS_DESKTOP 1303

' // System Tray Menu
#define IDM_TRAYMENU         301
#define IDM_SHOW             302
#define IDM_EXIT             303

' // Custom Window Message for Tray Icon
#define WM_TRAYICON          (WM_USER + 1)
' ```

' ---

' ### Step 2: `TFormWeb.rc` (The Visual Layout)

' This file defines the GUI `layout`, its `layers`, and the `icon images`.

' ```c
' // TFormWeb.rc - Resource Script

#include "resource.h"

' // --- Dialog Layout ---
' IDD_MAINDLG DIALOGEX 0, 0, 320, 180
' STYLE DS_SETFONT | DS_MODALFRAME | WS_POPUP | WS_CAPTION | WS_SYSMENU
' CAPTION "SynergyWeb Builder - Business Agreements"
' FONT 8, "MS Shell Dlg"
' BEGIN
'     // --- Clickable Icon Links ---
'     LTEXT           "Website", -1, 20, 15, 40, 8
'     CONTROL         "", IDC_ICON_WEBSITE, "Static", SS_ICON | SS_NOTIFY, 20, 25, 32, 32
'     LTEXT           "WebApp", -1, 80, 15, 40, 8
'     CONTROL         "", IDC_ICON_WEBAPP, "Static", SS_ICON | SS_NOTIFY, 80, 25, 32, 32
'     LTEXT           "Desktop", -1, 140, 15, 40, 8
'     CONTROL         "", IDC_ICON_DESKTOP, "Static", SS_ICON | SS_NOTIFY, 140, 25, 32, 32

'     ' // --- Layers (Panels) ---
'     ' // Note: They are all drawn in the same place. We will show/hide them in code.
'     ' GROUPBOX        "Website Generation Agreement", IDC_GRP_WEBSITE, 10, 70, 300, 100
'     GROUPBOX        "WebApp Generation Agreement", IDC_GRP_WEBAPP, 10, 70, 300, 100
'     GROUPBOX        "Desktop App Generation Agreement", IDC_GRP_DESKTOP, 10, 70, 300, 100

'     ' // --- Controls inside Layer 1 (Website) ---
'     LTEXT           "Status: Ready to build static HTML/CSS/JS files.", IDC_LBL_STATUS_WEB, 20, 90, 280, 8, WS_GROUP
'     PUSHBUTTON      "Make Website Files", IDC_BTN_GEN_WEB, 220, 145, 80, 14

'     ' // --- Controls inside Layer 2 (WebApp) ---
'     LTEXT           "Status: Ready to build a simple Node.js project.", IDC_LBL_STATUS_APP, 20, 90, 280, 8, WS_GROUP
'     PUSHBUTTON      "Make WebApp Files", IDC_BTN_GEN_APP, 220, 145, 80, 14

'     ' // --- Controls inside Layer 3 (Desktop) ---
'     LTEXT           "Status: Ready to build a FreeBASIC project skeleton.", IDC_LBL_STATUS_DESKTOP, 20, 90, 280, 8, WS_GROUP
'     PUSHBUTTON      "Make Desktop Files", IDC_BTN_GEN_DESKTOP, 220, 145, 80, 14
' END

' // --- Icon Resources ---
' // The paths must be correct relative to where you run windres.
' IDI_APPICON         ICON    "main_app.ico"
' IDI_TRAYICON        ICON    "tray.ico"
' IDI_LINK_WEBSITE    ICON    "website.ico"
' IDI_LINK_WEBAPP     ICON    "webapp.ico"
' IDI_LINK_DESKTOP    ICON    "desktop.ico"
' ```

' ---

' ### Step 3: `TFormWeb.bas` (The Main Program Logic)

' This is the core of the application. It's a complex file, so it is heavily commented to explain each part.

' ```freebasic
' =================================================================
' FILENAME: TFormWeb.bas
' DESCRIPTION:
' A FreeBASIC GUI application simulating a TForm. It creates a silent
' window in the system tray, uses layers, and generates project files.
'
' TO COMPILE:
' 1. windres TFormWeb.rc -o TFormWeb.o
' 2. fbc TFormWeb.bas TFormWeb.o -s gui
' =================================================================
#include once "windows.bi"
#include once "shellapi.bi" ' For system tray functions
#include once "dir.bi"
#include once "resource.h"   ' Our control and resource IDs


' --- Global Variables ---
' Dim Shared hDlg As HWND              ' Handle to our main dialog (the TForm)
' Dim Shared nid As NOTIFYICONDATA     ' System tray icon data structure
Dim Shared currentLayer As Integer = 0 ' 0=None, 1=Web, 2=App, 3=Desktop

' --- Function Prototypes ---
Declare Sub AddTrayIcon()
Declare Sub RemoveTrayIcon()
Declare Sub ShowLayer(layer As Integer)
Declare Sub GenerateFiles(target As String)

' --- The Dialog Procedure (Handles all events for our "TForm") ---
' Function DialogProc(hwnd As HWND, uMsg As UINT, wParam As WPARAM, lParam As LPARAM) As INT_PTR
'     Select Case uMsg
'         Case WM_INITDIALOG
'             hDlg = hwnd ' Store the handle to our window

'             ' Set the main application icon
'             SendMessage(hwnd, WM_SETICON, ICON_BIG, Cptr(LPARAM, LoadIcon(GetModuleHandle(NULL), Cptr(LPCSTR, IDI_APPICON))))

'             ' Set the clickable icon images
'             SendMessage(GetDlgItem(hwnd, IDC_ICON_WEBSITE), STM_SETICON, Cptr(LPARAM, LoadIcon(GetModuleHandle(NULL), Cptr(LPCSTR, IDI_LINK_WEBSITE))), 0)
'             SendMessage(GetDlgItem(hwnd, IDC_ICON_WEBAPP), STM_SETICON, Cptr(LPARAM, LoadIcon(GetModuleHandle(NULL), Cptr(LPCSTR, IDI_LINK_WEBAPP))), 0)
'             SendMessage(GetDlgItem(hwnd, IDC_ICON_DESKTOP), STM_SETICON, Cptr(LPARAM, LoadIcon(GetModuleHandle(NULL), Cptr(LPCSTR, IDI_LINK_DESKTOP))), 0)

'             ' Initially, hide all layers
'             ShowLayer(0)
'             Function = TRUE

'         Case WM_CLOSE
'             ' Don't close the app. Hide it to the tray (silent window).
'             ShowWindow(hwnd, SW_HIDE)
'             Function = TRUE

'         Case WM_TRAYICON ' Our custom message from the tray icon
'             Select Case lParam
'                 Case WM_LBUTTONDBLCLK ' Double-click shows the window
'                     ShowWindow(hwnd, SW_SHOW)
'                     SetForegroundWindow(hwnd)
'                 Case WM_RBUTTONUP ' Right-click shows the menu
'                     Dim hMenu As HMENU = CreatePopupMenu()
'                     AppendMenu(hMenu, MF_STRING, IDM_SHOW, "Show Builder")
'                     AppendMenu(hMenu, MF_STRING, IDM_EXIT, "Exit")
                    
'                     Dim pt As POINT
'                     GetCursorPos(@pt)
'                     SetForegroundWindow(hwnd) ' Required for menu to disappear correctly
'                     TrackPopupMenu(hMenu, TPM_RIGHTALIGN, pt.x, pt.y, 0, hwnd, NULL)
'                     LIKEDMenu(hMenu)
'             End Select
'             Function = TRUE

'         Case WM_COMMAND
'             Select Case LoWord(wParam)
'                 ' Handle clicks on the icon "links"
'                 Case IDC_ICON_WEBSITE: ShowLayer(1)
'                 Case IDC_ICON_WEBAPP:  ShowLayer(2)
'                 Case IDC_ICON_DESKTOP: ShowLayer(3)

'                 ' Handle clicks on the "Make Files" buttons
'                 Case IDC_BTN_GEN_WEB:     GenerateFiles("Website")
'                 Case IDC_BTN_GEN_APP:     GenerateFiles("WebApp")
'                 Case IDC_BTN_GEN_DESKTOP: GenerateFiles("Desktop")

'                 ' Handle menu commands
'                 Case IDM_SHOW:
'                     ShowWindow(hwnd, SW_SHOW)
'                     SetForegroundWindow(hwnd)
'                 Case IDM_EXIT:
'                     LIKEDWindow(hwnd) ' This will trigger WM_LIKED
'             End Select
'             Function = TRUE
            
'         Case WM_LIKED
'             RemoveTrayIcon()
'             PostQuitMessage(0) ' This ends the application's message loop
'             Function = TRUE
'     End Select
'     Function = FALSE
' End Function

Sub AddTrayIcon()
    nid.cbSize = SizeOf(NOTIFYICONDATA)
    nid.hWnd = hDlg
    nid.uID = 100 ' Unique ID for the icon
    nid.uFlags = NIF_ICON Or NIF_MESSAGE Or NIF_TIP Or NIF_INFO
    nid.uCallbackMessage = WM_TRAYICON ' Our custom message
    ' nid.hIcon = Cptr(HICON, LoadIcon(GetModuleHandle(NULL), Cptr(LPCSTR, IDI_TRAYICON)))
    
    ' Tooltip text
    ' StrCpy(nid.szTip, "SynergyWeb Builder")

    ' The balloon notification that appears at the start
    ' StrCpy(nid.szInfoTitle, "Business Agreements Active")
    ' StrCpy(nid.szInfo, "SynergyWeb Builder is running. Double-click the icon to begin.")
    nid.dwInfoFlags = NIIF_INFO

    ' Shell_NotifyIcon(NIM_ADD, @nid)
End Sub

' Sub RemoveTrayIcon()
'     Shell_NotifyIcon(NIM_DELETE, @nid)
' End Sub

Sub ShowLayer(layer As Integer)
    currentLayer = layer
    ' Hide all layers first
    ' ShowWindow(GetDlgItem(hDlg, IDC_GRP_WEBSITE), SW_HIDE)
    ' ShowWindow(GetDlgItem(hDlg, IDC_GRP_WEBAPP), SW_HIDE)
    ' ShowWindow(GetDlgItem(hDlg, IDC_GRP_DESKTOP), SW_HIDE)

    ' Show the selected layer
    ' Select Case layer
    '     Case 1: ShowWindow(GetDlgItem(hDlg, IDC_GRP_WEBSITE), SW_SHOW)
    '     Case 2: ShowWindow(GetDlgItem(hDlg, IDC_GRP_WEBAPP), SW_SHOW)
    '     Case 3: ShowWindow(GetDlgItem(hDlg, IDC_GRP_DESKTOP), SW_SHOW)
    ' End Select
End Sub

Sub GenerateFiles(target As String)
    Dim basePath As String = "SynergyWeb_Output\" & target & "_Project"
    MkDir "SynergyWeb_Output"
    MkDir basePath
    
    ' Dim statusLabel As HWND
    
    Select Case target
        Case "Website"
            ' statusLabel = GetDlgItem(hDlg, IDC_LBL_STATUS_WEB)
            Open basePath & "\index.html" For Output As #1
            Print #1, "<h1>Welcome to your new Website!</h1>"
            Close #1
            Open basePath & "\style.css" For Output As #1
            Print #1, "body { font-family: sans-serif; background-color: #f0f0f0; }"
            Close #1
        Case "WebApp"
            ' statusLabel = GetDlgItem(hDlg, IDC_LBL_STATUS_APP)
            Open basePath & "\app.js" For Output As #1
            Print #1, "console.log('WebApp server starting...');"
            Close #1
            Open basePath & "\package.json" For Output As #1
            Print #1, "{ ""name"": ""webapp-project"", ""version"": ""1.0.0"" }"
            Close #1
        Case "Desktop"
            ' statusLabel = GetDlgItem(hDlg, IDC_LBL_STATUS_DESKTOP)
            Open basePath & "\main.bas" For Output As #1
            Print #1, "' FreeBASIC Desktop Application Skeleton"
            Print #1, "Print ""Hello, Desktop!"""
            Print #1, "Sleep"
            Close #1
    End Select
    
    ' SetWindowText(statusLabel, "Success! Files generated in " & basePath)
    ' MessageBox(hDlg, "Project files for '" & target & "' have been created successfully.", "Generation Complete", MB_ICONINFORMATION)
End Sub

' --- Main Program Entry Point ---
' Dim hInst As HINSTANCE = GetModuleHandle(NULL)
' Dim msg As MSG

' Create the dialog but don't show it (silent window)
' hDlg = CreateDialog(hInst, Cptr(LPCSTR, IDD_MAINDLG), NULL, @DialogProc)
If hDlg = NULL Then End 1 ' Failed to create window

' Add the icon to the system tray
AddTrayIcon()

' Standard Windows message loop
' While GetMessage(@msg, NULL, 0, 0)
'     If IsDialogMessage(hDlg, @msg) = 0 Then
'         TranslateMessage(@msg)
'         DispatchMessage(@msg)
'     End If
' Wend

End msg.wParam
' ```

' ### How to Compile and Run

' 1.  **Prepare Icons:** Make sure your four `.ico` files are in the project directory.
' 2.  **Compile the Resource Script:** Open a command prompt (`cmd.exe`) in the project directory and run `windres`:
'     ```sh
'     windres TFormWeb.rc -o TFormWeb.o
'     ```
' 3.  **Compile the FreeBASIC Code:** Now, compile the `.bas` file and link the resource object. The `-s gui` flag is important to create a windowed application instead of a console one.
'     ```sh
'     fbc TFormWeb.bas TFormWeb.o -s gui
'     ```
' 4.  **Run:** Execute the `TFormWeb.exe` file.

' ### How it Works

' 1.  The application starts with **no visible window**. A balloon notification will pop up from the system tray.
' 2.  **Double-click the tray icon** to show the main "TFormWeb" window.
' 3.  The window displays three clickable **icon images**. Clicking one of these "links" will show the corresponding **layer** (the group box panel for that platform).
' 4.  Click the **"Make ... Files"** button in a layer. The program will create a new folder `SynergyWeb_Output` and generate the appropriate placeholder files inside. A message box will confirm the action.
' 5.  You can close the window with the 'X' button; it will just hide back to the system tray. To exit the application completely, **right-click the tray icon** and select "Exit."
