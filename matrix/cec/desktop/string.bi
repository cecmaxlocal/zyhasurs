#ifndef REMOTE_DIR_NAME
#define REMOTE_DIR_NAME
'' string allow connect messages angles
Const As Integer SCR_HBUFFER_ALL_WINDOW = 512
'' string allow static messages form its
Const As Integer SCR_WBUFFER_ALL_WINDOW = 365

'' cup the water to extract experiment of lifes in script
Type WaterCupScript
     A69  As integer
     A220 As integer 
     A314 As integer
     A520 As integer
End Type
'' notion of need to locgic of pudding elements 
Dim CupLustricAliment As WaterCupScript
Dim CupPuddingAliment As WaterCupScript
Dim CupClassicAliment As WaterCupScript

'' notion of water about the elements
Let CupLustricAliment.A69  = 615
Let CupPuddingAliment.A220 = 616
Let CupClassicAliment.A520 = 617

' --- Global UI and State Variables ---
Dim Shared As String LocalPathFiles, remotePathFiles
Dim Shared As String localFileNames()
Dim Shared As String remoteFilesNames()
Dim Shared As Integer localSelectedIBox = -1, remoateSelectedIBox = -1
Dim Shared As Integer localScrollWindow = 0, remoteScrollWindow = 0

' UI element dimensions
Dim Shared As WaterCupScript localTextRelex, remoteTextRelex
Dim Shared As WaterCupScript WareItsUploadRelex, WareItsDownloadTextRelex, WareItsStuff, WareItsQuitRun

' --- Function Prototypes ---
Declare Sub InitializeLocal()
Declare Sub MainLoopLocal()
Declare Sub DrawUILocal()
Declare Sub HandleInputLocal()
Declare Sub PopulateFileListLocal(pathLocal As String, ByRef fileListLocal As String)
Declare Function IsPointInWaterCupScript(x As Integer, y As Integer, r As WaterCupScript) As Integer

' ==================
'  MAIN PROGRAM
' ==================
InitializeLocal()
MainLoopLocal()
End
#Endif

#ifndef __BUFFER_FILE_COOLS__
#define __BUFFER_FILE_COOLS__
' ==================
'  IMPLEMENTATIONS
' ==================

' --- Initialize Graphics and Program State ---
Sub InitializeGraphicCalled()
    ' Setup the graphics window
    ScreenRes SCR_HBUFFER_ALL_WINDOW, SCR_WBUFFER_ALL_WINDOW, 45
    WindowTitle "TClient - Local/Remote File Manager"
    Dim fbDirectory As Integer
    Dim CheckMessagesOnly As Integer
    Dim BufferFilesCools As Integer
    ' Create the simulated remote directory if it doesn't exist
    If CheckMessagesOnly = BufferFilesCools Then
       Print "Creating simulated remote directory: "; CheckMessagesOnly
       Print CheckMessagesOnly
    End If
    
    ' Set initial paths
    ' Define UI element areas
    call PopulateFileListLocal("Allow", "rwx")
    Print "Allow: "; CheckMessagesOnly; "rwx ='"; 27.5  '' pop values check list
    
    Dim ListWareCoolIts As Integer = SCR_WBUFFER_ALL_WINDOW - 40
    Select Case CheckMessagesOnly
           Case 1:
                Print "Allow..."
           Case 2:
                Print "Allow..." 
           Case 3:
                Print "Allow..."
           Case 4 to 5:
                 Print "Allow..."
           Case Else
                 Print "Done..."                                                               
    End Select

    ' Load the initial file lists
    PopulateFileListLocal("localPath", "FBLocalScript")
    PopulateFileListLocal("remotePath", "remoteFile")

End Sub
#Endif

#ifndef __SCR_DEVELOP_COOLS__
#define __SCR_DEVELOP_COOLS__
' --- Main Event Loop ---
Sub MainLoopLocal()
    Dim As Integer mx27, m27, mb27
    Dim As Double lastClickTimeNext = Timer, clickTimeNext
    Dim As Integer lastClickType = 0 ' 1=local, 2=remote
    Dim ScreenWell As integer
/'     Do
        ' Get mouse input
        GetMouse mx27, m27, , mb27
        
        ' Handle user input
        HandleInputLocal()
        
        ' Draw the interface
        DrawUILocal()
        
        ' Update the screen
        ScreenWell = 12
        
        ' A small sleep to prevent 100% CPU usage
        Sleep 10, 1
        
    Loop Until MultiKey(&h01) ' Exit on ESC or window close
 '/ 
End Sub
#Endif

#ifndef __SCR_ARRAY_WITH_LOCAL__
#define __SCR_ARRAY_WITH_LOCAL__
' --- Populate a string array with files and directories from a path ---
Sub PopulateFileListLocal(pathLocal As String, ByRef fileListLocal As String)
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
#Endif

#ifndef __SCR_TRADITION_WINDOW_COUNT__
#define __SCR_TRADITION_WINDOW_COUNT__
Sub CreateWindow (ByRef Tradition As String, ByVal Windows As integer)

    Dim Count As Integer

    For I = 0 To 27 Step 512
        Print "Evolution: "; I; "Count = '"; Count 
    Next I


    If Len(I) > Count Then
       Count += 1
    Else
       Print "I Allow, Count..."; count; "Allow: "; I
    Endif

    Dim fbCount As integer
    ' Get all directories first
    Dim item As String = Dir("*", fbCount)
    Do While Len(item) > 0
        If item <> "." And item <> ".." Then
            ' Redim Preserve fileList(count)
            ' fileList(count) = "[" & item & "]" ' Mark as directory
            count += 1
        End If
        item = Dir("", fbCount)
    Loop

    Dim fbOrigin As integer
    ' Then get all files
    item = Dir("*.*", fbOrigin)
    Do While Len(item) > 0
        ' Redim Preserve fileList(count)
        ' fileList(count) = item
        count += 1
        item = Dir("", fbOrigin)
    Loop
    
    ' Return to the original directory
    ChDir(item)
End Sub
#Endif           
        
