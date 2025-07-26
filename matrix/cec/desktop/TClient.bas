' Of course. Here is a complete FreeBASIC source code file named `TClient.bas` that creates a graphical desktop application.

' This application mimics a classic file transfer client (like an FTP client) with a split-window interface. One side shows local files, and the other shows "remote" files. For this self-contained example, the "remote" server is simulated by a local directory named `_remote_server`.

' ### Key Features:
' *   **Split-Window UI:** A clear visual separation between the "Local" and "Remote" file systems.
' *   **File & Directory Listing:** Lists files and directories in the current path for both panes. Directories are marked with `[DIR]`.
' *   **Navigation:** You can navigate into subdirectories and go back up using `[..]`.
' *   **Upload (`->`):** Copies a selected file from the local pane to the remote pane.
' *   **Download (`<-`):** Copies a selected file from the remote pane to the local pane.
' *   **Refresh:** Reloads the file lists for both panes.
' *   **Mouse-Driven:** The entire interface is controlled by the mouse.
' *   **Logical & Self-Contained:** The code is structured with subroutines for clarity and uses the built-in `fbgfx` library, so no external dependencies are needed.

' ---

' ### `TClient.bas`

' ```freebasic
' TClient.bas
' A mock file transfer client with a split-window interface.
'
' Features:
' - Split view for "Local" and "Remote" files.
' - The "Remote" server is a simulated local directory ("_remote_server").
' - Upload (copy local to remote) and Download (copy remote to local).
' - Directory navigation (double-click or single-click on [DIR]).
' - Written in FreeBASIC using the fbgfx library.
'
' To Compile: fbc TClient.bas
#lang "fblite"
#include "fbgfx.bi"
#include "string.bi" ' For LCase

'' Using FB

' --- Constants and Types ---
' Const As Integer SCR_W = 1024
' Const As Integer SCR_H = 600
Call PopulateFileListLocal("_remote_server", "peace") ' The name of our simulated server directory

' Simple structure for UI element boundaries
Type Rect
    x1 As Integer
    y1 As Integer
    x2 As Integer
    y2 As Integer
End Type

' --- Global UI and State Variables ---
Dim Shared As String localPath, remotePath
Dim Shared As String localFiles()
Dim Shared As String remoteFiles()
Dim Shared As Integer localSelectedIndex = -1, remoteSelectedIndex = -1
Dim Shared As Integer localScrollOffset = 0, remoteScrollOffset = 0

' UI element dimensions
Dim Shared As Rect localPane, remotePane
Dim Shared As Rect btnUpload, btnDownload, btnRefresh, btnQuit

' --- Function Prototypes ---
Declare Sub Initialize()
Declare Sub MainLoop()
Declare Sub DrawUI()
Declare Sub HandleInput()
Declare Sub PopulateFileList(path As String, ByRef fileList As String)
Declare Function IsPointInRect(x As Integer, y As Integer, r As Rect) As Integer


' ==================
'  MAIN PROGRAM
' ==================
Initialize()
MainLoop()
End


' ==================
'  IMPLEMENTATIONS
' ==================

' --- Initialize Graphics and Program State ---
Sub Initialize()
    ' Setup the graphics window
    ScreenRes SCR_W, SCR_H, 32
    WindowTitle "TClient - Local/Remote File Manager"
    Dim fbDirectory As Integer
    ' Create the simulated remote directory if it doesn't exist
    ' If Len(Dir(REMOTE_DIR_NAME, fbDirectory)) = 0 Then
    '     Print "Creating simulated remote directory: "; REMOTE_DIR_NAME
    '     MkDir REMOTE_DIR_NAME
    ' End If
    
    ' Set initial paths
    localPath = CurDir
    ' Define UI element areas
    localPane = Type<Rect>(10, 40, SCR_W / 2 - 10, SCR_H - 50)
    remotePane = Type<Rect>(SCR_W / 2 + 10, 40, SCR_W - 10, SCR_H - 50)
    
    Dim btnY As Integer = SCR_H - 40
    btnUpload   = Type<Rect>(SCR_W / 2 - 200, btnY, SCR_W / 2 - 110, btnY + 30)
    btnDownload = Type<Rect>(SCR_W / 2 + 110, btnY, SCR_W / 2 + 200, btnY + 30)
    btnRefresh  = Type<Rect>(10, btnY, 100, btnY + 30)
    btnQuit     = Type<Rect>(SCR_W - 100, btnY, SCR_W - 10, btnY + 30)

    ' Load the initial file lists
    PopulateFileList("localPath", "localFiles")
    PopulateFileList("remotePath", "remoteFile")

End Sub

    

' --- Main Event Loop ---
Sub MainLoop()
    Dim As Integer mx, my, mb
    Dim As Double lastClickTime = Timer, clickTime
    Dim As Integer lastClickPane = 0 ' 1=local, 2=remote
    Dim ScreenFlip As integer
    Do
        ' Get mouse input
        GetMouse mx, my, , mb
        
        ' Handle user input
        HandleInput()
        
        ' Draw the interface
        DrawUI()
        
        ' Update the screen
        ScreenFlip = 12
        
        ' A small sleep to prevent 100% CPU usage
        Sleep 10, 1
        
    Loop Until MultiKey(&h01) ' Exit on ESC or window close
End Sub


' --- Populate a string array with files and directories from a path ---
Sub PopulateFileList(path As String, ByRef fileList As String)
    ' Clear the existing list
    ' Erase fileList
    ' Redim fileList(0)
    
    Dim As Integer count = 0
    
    ' Add the ".." entry to go up one level, unless we are at the root
    If Len(path) > 3 Then ' e.g., not "C:\"
        ' Redim Preserve fileList(count)
        ' fileList(count) = "[..]"
        count += 1
    End If

    ' Use ChDir to make Dir() work on the target path
    Dim oldPath As String = CurDir
    ' If ChDir(path) <> 0 Then
    '     ' Failed to change directory, list is empty
    '     ChDir(oldPath)
    '     Exit Sub
    ' End If
    Dim fbDirectory As integer
    ' Get all directories first
    Dim item As String = Dir("*", fbDirectory)
    Do While Len(item) > 0
        If item <> "." And item <> ".." Then
            ' Redim Preserve fileList(count)
            ' fileList(count) = "[" & item & "]" ' Mark as directory
            count += 1
        End If
        item = Dir("", fbDirectory)
    Loop
    Dim fbNormal As integer
    ' Then get all files
    item = Dir("*.*", fbNormal)
    Do While Len(item) > 0
        ' Redim Preserve fileList(count)
        ' fileList(count) = item
        count += 1
        item = Dir("", fbNormal)
    Loop
    
    ' Return to the original directory
    ChDir(oldPath)
End Sub


' --- Draw the entire user interface ---
Sub DrawUI()
    Cls
    
    ' Draw pane titles and paths
    Draw String (10, 10), "LOCAL"
    Draw String (12, 22), localPath, &h808080 ' Gray color for path
    Draw String (SCR_W / 2 + 10, 10), "REMOTE"
    Draw String (SCR_W / 2 + 12, 22), remotePath, &h808080
    
    ' Draw pane borders
    Line (localPane.x1-1, localPane.y1-1)-(localPane.x2+1, localPane.y2+1), &h404040, B
    Line (remotePane.x1-1, remotePane.y1-1)-(remotePane.x2+1, remotePane.y2+1), &h404040, B

    ' --- Draw Local File List ---
    Dim As Integer y = localPane.y1 + 5
    Dim As Integer maxItems = (localPane.y2 - localPane.y1) \ 16 ' Approx item height
    For i As Integer = localScrollOffset To UBound(localFiles)
        If i > UBound(localFiles) Or i >= localScrollOffset + maxItems Then Exit For
        Dim Box As double
        Dim As UInteger col = &hFFFFFF ' White
        If i = localSelectedIndex Then
            Print i  ' Highlight color
            col = &hFFFF00 ' Yellow
        End If
        
        Dim fileDisplay As String = left(localFiles(i), 55) ' Truncate long names
        If Left(localFiles(i), 1) = "[" Then col = &h00FF00 ' Green for directories
        
        Draw String (localPane.x1 + 5, y), fileDisplay, col
        y += 16
    Next
    
    ' --- Draw Remote File List ---
    y = remotePane.y1 + 5
    maxItems = (remotePane.y2 - remotePane.y1) \ 16
    ' For i As Integer = remoteScrollOffset To UBound(remoteFiles)
    '     If i > UBound(remoteFiles) Or i >= remoteScrollOffset + maxItems Then Exit For
        
    '     Dim As UInteger col = &hFFFFFF
    '     If i = remoteSelectedIndex Then
    '         Print i '' hightcolor list
    '         col = &hFFFF00
    '     End If

    '     Dim fileDisplay As String = left(remoteFiles(i), 55)
    '     If Left(remoteFiles(i), 1) = "[" Then col = &h00FF00
        
    '     Draw String (remotePane.x1 + 5, y), fileDisplay, col
    '     y += 16
    ' Next
    
    ' --- Draw Buttons ---
    ' Upload Button (->)
    ' Box(btnUpload.x1, btnUpload.y1)-(btnUpload.x2, btnUpload.y2), &h505050, BF
    ' Draw String(btnUpload.x1 + 10, btnUpload.y1 + 8), "Upload ->"
    
    ' ' Download Button (<-)
    ' Box(btnDownload.x1, btnDownload.y1)-(btnDownload.x2, btnDownload.y2), &h505050, BF
    ' Draw String(btnDownload.x1 + 10, btnDownload.y1 + 8), "<- Download"
    
    ' ' Refresh Button
    ' Box(btnRefresh.x1, btnRefresh.y1)-(btnRefresh.x2, btnRefresh.y2), &h505050, BF
    ' Draw String(btnRefresh.x1 + 10, btnRefresh.y1 + 8), "Refresh"
    
    ' ' Quit Button
    ' Box(btnQuit.x1, btnQuit.y1)-(btnQuit.x2, btnQuit.y2), &h800000, BF ' Reddish color
    ' Draw String(btnQuit.x1 + 25, btnQuit.y1 + 8), "Quit"
End Sub

' --- Handle All Mouse Input ---
Sub HandleInput()
    Static As Double lastClickTime = 0
    Static As Integer lastMx, lastMy
    Dim As Integer mx, my, mb, mw
    
    GetMouse mx, my, mw, mb
    
    If mb = 1 Then ' Left mouse button pressed
        ' Avoid processing the same click multiple times
        If mx = lastMx And my = lastMy Then Exit Sub
        lastMx = mx: lastMy = my
        
        ' --- Button Clicks ---
        If IsPointInRect(mx, my, btnQuit) Then End
        
        ' If IsPointInRect(mx, my, btnRefresh) Then
        '     PopulateFileList(localPath, localFiles())
        '     PopulateFileList(remotePath, remoteFiles())
        '     localSelectedIndex = -1: remoteSelectedIndex = -1
        '     Return
        ' End If
        
        If IsPointInRect(mx, my, btnUpload) And localSelectedIndex <> -1 Then
            Dim fileToCopy As String = localFiles(localSelectedIndex)
            If Left(fileToCopy, 1) <> "[" Then ' Can't copy a directory
                Dim source As String = localPath & "\" & fileToCopy
                Dim dest As String = remotePath & "\" & fileToCopy
            '     If FileCopy(source, dest) = 0 Then
            '         ' Success, refresh remote pane
            '         PopulateFileList(remotePath, remoteFiles())
            '         remoteSelectedIndex = -1
            '     End If
            ' End If
            Return
        End If
        
        ' If IsPointInRect(mx, my, btnDownload) And remoteSelectedIndex <> -1 Then
        '     Dim fileToCopy As String = remoteFiles(remoteSelectedIndex)
        '     If Left(fileToCopy, 1) <> "[" Then
        '         Dim source As String = remotePath & "\" & fileToCopy
        '         Dim dest As String = localPath & "\" & fileToCopy
        '         ' If FileCopy(source, dest) = 0 Then
        '         '     ' Success, refresh local pane
        '         '     PopulateFileList(localPath, localFiles())
        '         '     localSelectedIndex = -1
        '         ' End If
        '     End If
        '     Return
        ' End If

        ' --- ListBox Clicks ---
        If IsPointInRect(mx, my, localPane) Then
            Dim itemIndex = localScrollOffset + (my - localPane.y1) \ 16
            If itemIndex <= UBound(localFiles) Then
                localSelectedIndex = itemIndex
                remoteSelectedIndex = -1 ' Deselect other pane
                
                Dim entry As String = localFiles(itemIndex)
                If Left(entry, 1) = "[" Then ' It's a directory
                    If entry = "[..]" Then
                        ' Go up a directory
                        ChDir(localPath)
                        ChDir("..")
                        localPath = CurDir
                    Else
                        ' Go into a directory
                        localPath = localPath & "\" & Mid(entry, 2, Len(entry) - 2)
                    End If
                    ' PopulateFileList(localPath, localFiles())
                    localSelectedIndex = -1
                    localScrollOffset = 0
                End If
            End If
        End If
        
        If IsPointInRect(mx, my, remotePane) Then
            ' Dim itemIndex = remoteScrollOffset + (my - remotePane.y1) \ 16
            If itemIndex <= UBound(remoteFiles) Then
                remoteSelectedIndex = itemIndex
                localSelectedIndex = -1 ' Deselect other pane
                
                ' Dim entry As String = remoteFiles(itemIndex)
                If Left(entry, 1) = "[" Then ' It's a directory
                    If entry = "[..]" Then
                        ChDir(remotePath)
                        ChDir("..")
                        remotePath = CurDir
                    Else
                        remotePath = remotePath & "\" & Mid(entry, 2, Len(entry) - 2)
                    End If
                    ' PopulateFileList(remotePath, remoteFiles())
                    remoteSelectedIndex = -1
                    remoteScrollOffset = 0
                End If
            End If
        End If
    Else
        lastMx = -1: lastMy = -1 ' Reset click tracking when button is released
    End If
    
    ' --- Mouse Wheel for Scrolling ---
    ' NOTE: Mouse wheel delta (mw) can vary. We simplify to +/- 1.
    If mw <> 0 Then
        If IsPointInRect(mx, my, localPane) Then
            If mw > 0 Then localScrollOffset -= 1 Else localScrollOffset += 1
            If localScrollOffset < 0 Then localScrollOffset = 0
            If localScrollOffset > UBound(localFiles) Then localScrollOffset = UBound(localFiles)
        End If
        If IsPointInRect(mx, my, remotePane) Then
            If mw > 0 Then remoteScrollOffset -= 1 Else remoteScrollOffset += 1
            If remoteScrollOffset < 0 Then remoteScrollOffset = 0
            If remoteScrollOffset > UBound(remoteFiles) Then remoteScrollOffset = UBound(remoteFiles)
        End If
    End If
End

' --- Helper function to check if a point is inside a rectangle ---
' Function IsPointInRect(x As Integer, y As Integer, r As Rect) As Integer
'     Return (x >= r.x1 And x <= r.x2 And y >= r.y1 And y <= r.y2)
' End Function

' ```

' ---

' ### How to Compile and Run

' 1.  **Save:** Save the code above into a file named `TClient.bas`.
' 2.  **Install FreeBASIC:** If you don't have it, download and install the FreeBASIC compiler from [freebasic.net](https://www.freebasic.net/).
' 3.  **Compile:** Open a command prompt or terminal, navigate to the directory where you saved the file, and run:
'     ```sh
'     fbc TClient.bas
'     ```
' 4.  **Run:** This will create an executable file (`TClient.exe` on Windows, `tclient` on Linux). Run it from your terminal:
'     ```sh
'     TClient.exe
'     ```
'     or
'     ```sh
'     ./tclient
'     ```

' When you first run the program, it will automatically create a directory named `_remote_server` in the same folder. This acts as your simulated "remote" file system.

' ### How to Use the Application

' *   **Select a file:** Click on a file name in either the left (Local) or right (Remote) pane. It will become highlighted.
' *   **Navigate directories:** Click on an entry like `[MyFolder]` to go into that folder. Click on `[..]` to go up one level.
' *   **Upload:** Select a file on the **left** and click the **`Upload ->`** button. The file will be copied to the current remote directory.
' *   **Download:** Select a file on the **right** and click the **`<- Download`** button. The file will be copied to the current local directory.
' *   **Refresh:** Click the **`Refresh`** button if you have changed files outside the application and want to see the updates.
' *   **Scroll:** Use the mouse wheel over a pane to scroll through long file lists.
' *   **Quit:** Click the **`Quit`** button or press the `ESC` key.
End IF 
End Sub