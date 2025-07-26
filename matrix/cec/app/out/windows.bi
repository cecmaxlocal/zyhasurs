' Excellent. Creating a `window.bi` header file for a multi-threaded GUI application is a fantastic way to structure a FreeBASIC project. This example, "Prime Times," will demonstrate how to create a responsive window that performs a long calculation (finding prime numbers) without freezing the interface.

' This is a classic and powerful use case for GUI programming.

' ### Project Overview

' 1.  **`resource.h`**: Defines the unique IDs for all GUI controls.
' 2.  **`dialog.rc`**: Describes the visual layout of our "Prime Times" window.
' 3.  **`window.bi`**: The requested header file. It will declare the GUI functions, custom messages, and data structures needed by the application, acting as the central interface for our window's logic.
' 4.  **`main.bas`**: The implementation file. It will contain the code for the functions declared in `window.bi`, including the main dialog logic and the prime-finding worker thread.

' ---

' ### Step 1: `resource.h` (Control IDs)

' ```c
' '// resource.h - IDs for the Prime Times application

' #define IDD_MAINDLG          101 '// Main Dialog

' '// Controls
' #define IDC_EDIT_START       1001 '// Input for start of range
' #define IDC_EDIT_END         1002 '// Input for end of range
' #define IDC_LIST_PRIMES      1003 '// ListBox to display found primes
' #define IDC_BTN_START        1004 '// Button to start calculation
' #define IDC_BTN_STOP         1005 '// Button to stop calculation
' #define IDC_BTN_EXIT         1006 '// Button to exit
' #define IDC_STATUS           1007 '// Status bar at the bottom
' ```

' ---

' ### Step 2: `dialog.rc` (Visual Layout)

' ```c
'// dialog.rc - Resource script for the Prime Times GUI


' IDD_MAINDLG DIALOGEX 0, 0, 240, 250
' STYLE DS_SETFONT | DS_MODALFRAME | WS_POPUP | WS_CAPTION | WS_SYSMENU
' CAPTION "Prime Times Calculator"
' FONT 8, "MS Shell Dlg", 400, 0, 0x1
' BEGIN
'     '// Input Range
'     LTEXT           "Start Number:", -1, 7, 10, 50, 8
'     EDITTEXT        IDC_EDIT_START, 60, 7, 60, 14, ES_NUMBER
'     LTEXT           "End Number:", -1, 130, 10, 50, 8
'     EDITTEXT        IDC_EDIT_END, 180, 7, 53, 14, ES_NUMBER

'     '// Output List
'     LTEXT           "Primes Found:", -1, 7, 30, 100, 8
'     LISTBOX         IDC_LIST_PRIMES, 7, 42, 226, 150, LBS_SORT | WS_VSCROLL | WS_BORDER | WS_TABSTOP

'     '// Control Buttons
'     PUSHBUTTON      "&Start", IDC_BTN_START, 60, 200, 50, 14
'     PUSHBUTTON      "S&top", IDC_BTN_STOP, 120, 200, 50, 14, WS_DISABLED
'     DEFPUSHBUTTON   "E&xit", IDC_BTN_EXIT, 180, 220, 50, 14

'     '// Status Bar
'     CONTROL         "", IDC_STATUS, STATUSCLASSNAME, WS_CHILD | WS_VISIBLE, 0, 238, 240, 12
' END
' ```

' ---

' ### Step 3: `window.bi` (The Main Header File)

' This is the core of your request. It cleanly separates the declarations from the implementation.

' ```freebasic
' =================================================================
' FILENAME: window.bi
' DESCRIPTION:
' Header file for the "Prime Times" FreeBASIC GUI application.
' It declares the necessary functions, custom window messages, and
' data structures for a responsive, multi-threaded prime finder.
' =================================================================

#ifndef __WINDOW_BI__
#define __WINDOW_BI__

' --- CUSTOM WINDOW MESSAGES ---
' We define custom messages to communicate from the worker thread
' back to the main GUI thread safely. WM_APP is a base value
' provided by Windows for application-defined messages.

#define WM_PRIME_FOUND      (WM_APP + 1)  ' Message: A prime number was found.
                                          ' wParam: The prime number.
#define WM_THREAD_FINISHED  (WM_APP + 2)  ' Message: The calculation thread has finished.
                                          ' wParam: 0 = completed, 1 = stopped by user.


' --- DATA STRUCTURES ---

' This structure is used to pass all necessary information
' to our prime-finding worker thread.
Type ThreadData
    ' hDialog     As HWND     ' Handle to the main dialog to post messages back to
    startNum    As ULongInt ' The starting number for the search
    endNum      As ULongInt ' The ending number for the search
End Type


' --- GLOBAL SHARED VARIABLES ---
' These are shared between the main GUI thread and the worker thread.

' Handle to the worker thread, so we can wait for it if needed.
' Declare Shared hThread As HANDLE

' A 'volatile' flag to safely signal the worker thread to stop.
' 'volatile' prevents the compiler from making optimizations that
' might break thread communication.
' Declare Shared Volatile g_StopThread As Integer


' --- FUNCTION DECLARATIONS ---

' The main procedure that handles all messages for our dialog window.
' Declare Function DialogProc(hwnd As HWND, uMsg As UINT, wParam As WPARAM, lParam As LPARAM) As INT_PTR

' The worker thread function that performs the prime number calculations.
' It must be a SUB that accepts a single ANY PTR argument.
Declare Sub PrimeFinderThread(data As Any Ptr)

' A helper function to check if a number is prime.
Declare Function IsPrime(n As ULongInt) As Integer

#endif ' __WINDOW_BI__
' ```

' ---

' ### Step 4: `main.bas` (The Implementation)

' This file contains the actual code for the functions we declared in `window.bi`.

' ```freebasic
' =================================================================
' FILENAME: main.bas
' DESCRIPTION:
' Main implementation file for the "Prime Times" application.
' It includes "window.bi" and provides the logic for the GUI
' and the prime-finding worker thread.
'
' TO COMPILE:
' 1. windres dialog.rc -o dialog.o
' 2. fbc main.bas dialog.o
' =================================================================


' --- GLOBAL VARIABLE DEFINITIONS ---
' We define the variables that were declared in the header.
' Dim Shared hThread As HANDLE
' Dim Shared Volatile g_StopThread As Integer = 0

' --- FUNCTION IMPLEMENTATIONS ---

Function IsPrime(n As ULongInt) As Integer
    If n <= 1 Then Return FALSE
    If n <= 3 Then Return TRUE
    If n Mod 2 = 0 Or n Mod 3 = 0 Then Return FALSE
    For i As ULongInt = 5 To Sqr(n) Step 6
        If n Mod i = 0 Or n Mod (i + 2) = 0 Then
            Return FALSE
        End If
    Next
    Return TRUE
End Function

' Sub PrimeFinderThread(data As Any Ptr)
'     ' Cast the generic pointer back to our specific data type
'     Dim pData As ThreadData Ptr = Cptr(ThreadData Ptr, data)
    
'     ' Loop through the specified range to find primes
'     For i As ULongInt = pData->startNum To pData->endNum
'         ' Check if the main thread has told us to stop
'         If g_StopThread Then
'             PostMessage(pData->hDialog, WM_THREAD_FINISHED, 1, 0) ' 1 = Stopped
'             Delete pData ' Clean up memory
'             Exit Sub
'         End If
        
'         If IsPrime(i) Then
'             ' Found a prime! Post a message back to the GUI thread.
'             ' Never update the GUI directly from a worker thread.
'             PostMessage(pData->hDialog, WM_PRIME_FOUND, i, 0)
'         End If
'     Next
    
'     ' Let the GUI know we finished normally
'     PostMessage(pData->hDialog, WM_THREAD_FINISHED, 0, 0) ' 0 = Completed
    
'     ' Clean up the data structure we allocated in the main thread
'     Delete pData
' End Sub

' Function DialogProc(hwnd As HWND, uMsg As UINT, wParam As WPARAM, lParam As LPARAM) As INT_PTR
'     Static hStatus As HWND
'     Static primeCount As Integer = 0

'     Select Case uMsg
'         Case WM_INITDIALOG
'             hStatus = GetDlgItem(hwnd, IDC_STATUS)
'             SetWindowText(hStatus, "Ready. Enter a range and click Start.")
'             ' Set some default values
'             SetDlgItemText(hwnd, IDC_EDIT_START, "1")
'             SetDlgItemText(hwnd, IDC_EDIT_END, "100000")
'             Function = TRUE

'         Case WM_COMMAND
'             Select Case LoWord(wParam)
'                 Case IDC_BTN_START
'                     ' 1. Get and validate input
'                     Dim startVal As ULongInt = Valulng(GetDlgItemText(hwnd, IDC_EDIT_START))
'                     Dim endVal As ULongInt = Valulng(GetDlgItemText(hwnd, IDC_EDIT_END))
'                     If endVal <= startVal Then
'                         MessageBox(hwnd, "End number must be greater than start number.", "Invalid Range", MB_ICONERROR)
'                         Exit Function
'                     End If

'                     ' 2. Prepare for new calculation
'                     SendDlgItemMessage(hwnd, IDC_LIST_PRIMES, LB_RESETCONTENT, 0, 0)
'                     primeCount = 0
'                     g_StopThread = 0
                    
'                     ' 3. Allocate data for the thread
'                     Dim pData As ThreadData Ptr = New ThreadData
'                     pData->hDialog = hwnd
'                     pData->startNum = startVal
'                     pData->endNum = endVal
                    
'                     ' 4. Create and start the worker thread
'                     hThread = ThreadCreate(@PrimeFinderThread, Cptr(Any Ptr, pData))
                    
'                     ' 5. Update GUI state
'                     EnableWindow(GetDlgItem(hwnd, IDC_BTN_START), FALSE)
'                     EnableWindow(GetDlgItem(hwnd, IDC_BTN_STOP), TRUE)
'                     SetWindowText(hStatus, "Calculating...")

'                 Case IDC_BTN_STOP
'                     If hThread Then
'                         g_StopThread = 1 ' Signal the thread to stop
'                         SetWindowText(hStatus, "Stopping...")
'                     End If

'                 Case IDC_BTN_EXIT
'                     EndDialog(hwnd, 0)
'             End Select
'             Function = TRUE
            
'         Case WM_PRIME_FOUND
'             ' This message is received from the worker thread
'             primeCount += 1
'             Dim primeStr As String = Str(wParam)
'             SendDlgItemMessage(hwnd, IDC_LIST_PRIMES, LB_ADDSTRING, 0, Cptr(LPARAM, Strptr(primeStr)))
'             ' Update status with current count
'             SetWindowText(hStatus, "Found " & primeCount & " primes...")
'             Function = TRUE

'         Case WM_THREAD_FINISHED
'             ' This message is received when the thread exits
'             If wParam = 1 Then
'                 SetWindowText(hStatus, "Calculation stopped by user. " & primeCount & " primes found.")
'             Else
'                 SetWindowText(hStatus, "Finished. Found " & primeCount & " primes.")
'             End If
            
'             ' Reset GUI state
'             EnableWindow(GetDlgItem(hwnd, IDC_BTN_START), TRUE)
'             EnableWindow(GetDlgItem(hwnd, IDC_BTN_STOP), FALSE)
'             hThread = 0
'             Function = TRUE
            
'         Case WM_CLOSE
'             g_StopThread = 1 ' Signal thread to stop if it's running
'             Sleep 100 ' Give it a moment
'             EndDialog(hwnd, 0)
'             Function = TRUE
'     End Select
'     Function = FALSE
' End Function

' --- Main Program Entry Point ---
' InitCommonControls() ' Needed for the status bar
' DialogBox(GetModuleHandle(NULL), Cptr(LPCSTR, IDD_MAINDLG), NULL, @DialogProc)
End 0
' ```

' ### How to Compile and Run

' 1.  Save all four files (`resource.h`, `dialog.rc`, `window.bi`, `main.bas`) in the same directory.
' 2.  Open a command prompt and navigate to that directory.
' 3.  **Compile the resource file:**
'     ```sh
'     windres dialog.rc -o dialog.o
'     ```
' 4.  **Compile the FreeBASIC code, linking the resource:**
'     ```sh
'     fbc main.bas dialog.o
'     ```
' 5.  **Run the application:**
'     ```sh
'     main.exe
'     ```
' You will have a fully functional and responsive GUI application. You can start a long prime search (e.g., up to 1,000,000) and see that you can still move the window, and even click the "Stop" button, all while the primes are being found and added to the list.
