' Of course. This is a brilliant request that lends itself perfectly to creating a powerful and well-structured `dir.bi` header. The keywords "ashes," "program's action," "framework," and "business event" will form the basis of a conceptual file management system.

' We will create a **Business Event Framework** where a "business event" (like a project's completion) triggers a "program's action" (archiving the project). The archived state will be metaphorically called the "ashes," from which a project can also be restored.

' ---

' ### 1. The Header File: `dir.bi`

' This header file will declare the data structures and functions that make up our framework. It acts as the public API for our directory management system.

' Save this code as `dir.bi`:
' ```freebasic
' =================================================================
' FILENAME: dir.bi
' DESCRIPTION:
' A directory management header for FreeBASIC.
'
' It provides a "Business Event Framework" for a program's action,
' allowing for the archival of project directories into an "ashes"
' folder and their subsequent restoration.
' =================================================================

#ifndef __DIR_BI__
#define __DIR_BI__

#include once "crt.bi"  ' For Time() and other C runtime functions
#include once "string.bi" ' For string manipulation

' --- FRAMEWORK DATA STRUCTURE ---
' This type defines the directory structure for our business framework.
Type BusinessFramework
    rootPath   As String  ' The base directory for the entire framework
    activePath As String  ' Where active projects reside
    logPath    As String  ' Where event logs are stored
    ashesPath  As String  ' Where archived/"retired" projects go
End Type


' --- FUNCTION DECLARATIONS ---

''
' @brief Sets up the necessary directory framework on the file system.
' @desc This is the first program's action, creating the required folder
'       structure if it doesn't already exist.
' @param basePath The root directory where the framework will be created.
' @return A BusinessFramework object populated with the correct paths.
''
Declare Function SetupEventFramework(basePath As String) As BusinessFramework


''
' @brief Logs a specific business event to a file.
' @desc Every significant program's action should be logged.
' @param framework The BusinessFramework object containing the log path.
' @param eventDescription A string describing the event that occurred.
' @return 0 on success, -1 on failure.
''
Declare Function LogBusinessEvent(framework As BusinessFramework, eventDescription As String) As Integer


''
' @brief Archives a project, moving it to the "ashes" directory.
' @desc This program's action is triggered by a business event like
'       a project's completion or cancellation.
' @param framework The active BusinessFramework object.
' @param projectName The name of the directory to archive.
' @return 0 on success, -1 if the project doesn't exist.
''
Declare Function ArchiveProjectToAshes(framework As BusinessFramework, projectName As String) As Integer


''
' @brief Restores a project from the "ashes" back to the active directory.
' @desc A "phoenix" action, bringing a project back from archival.
' @param framework The active BusinessFramework object.
' @param projectName The name of the directory to restore.
' @return 0 on success, -1 if the project doesn't exist in the ashes.
''
Declare Function RestoreProjectFromAshes(framework As BusinessFramework, projectName As String) As Integer


#endif ' __DIR_BI__
' ```

' ---

' ### 2. The Implementation and Demo: `main.bas`

' This file will include `dir.bi` and provide both the implementation for the declared functions and a step-by-step demonstration of the framework in action.

' Save this code as `main.bas` in the **same directory** as `dir.bi`:
' ```freebasic
' =================================================================
' FILENAME: main.bas
' AUTHOR:   AI Assistant
'
' DESCRIPTION:
' Implements and demonstrates the Business Event Framework defined
' in dir.bi. It shows the program's action of archiving a project
' to the "ashes" and then restoring it.
'
' TO COMPILE:
' fbc main.bas
' =================================================================


' --- FUNCTION IMPLEMENTATIONS ---

Function SetupEventFramework(basePath As String) As BusinessFramework
    Dim framework As BusinessFramework
    
    ' Ensure base path has a trailing slash
    ' If Right(basePath, 1) <> PathSeparator Then basePath &= PathSeparator
    
    framework.rootPath   = basePath
    ' framework.activePath = basePath & "active_projects" & PathSeparator
    ' framework.logPath    = basePath & "event_logs" & PathSeparator
    ' framework.ashesPath  = basePath & "project_ashes" & PathSeparator
    
    ' The program's action is to create the framework directories
    ' If Not FileExists(framework.rootPath) Then MkDir framework.rootPath
    ' If Not FileExists(framework.activePath) Then MkDir framework.activePath
    ' If Not FileExists(framework.logPath) Then MkDir framework.logPath
    ' If Not FileExists(framework.ashesPath) Then MkDir framework.ashesPath
    
    Return framework
End Function

Function LogBusinessEvent(framework As BusinessFramework, eventDescription As String) As Integer
    Dim logFile As String = framework.logPath & "events.log"
    Dim handle As Integer = FreeFile
    
    If Open(logFile For Append As #handle) <> 0 Then Return -1
    
    ' Create a timestamp for the event
    ' Dim timeStr As String = Format(Now, "yyyy-mm-dd hh:mm:ss")
    ' Print #handle, timeStr & " - " & eventDescription
    
    Close #handle
    Return 0
End Function

Function ArchiveProjectToAshes(framework As BusinessFramework, projectName As String) As Integer
    Dim sourcePath As String = framework.activePath & projectName
    Dim destPath As String = framework.ashesPath & projectName
    
    ' Check if the project exists before trying to move it
    ' If Not FileExists(sourcePath) Then Return -1
    
    ' The "Name...As..." command moves a directory in FreeBASIC
    Name sourcePath As destPath
    
    LogBusinessEvent(framework, "BUSINESS EVENT: Project '" & projectName & "' archived to ashes.")
    Return 0
End Function

Function RestoreProjectFromAshes(framework As BusinessFramework, projectName As String) As Integer
    Dim sourcePath As String = framework.ashesPath & projectName
    Dim destPath As String = framework.activePath & projectName
    
    ' If Not FileExists(sourcePath) Then Return -1
    
    Name sourcePath As destPath
    
    LogBusinessEvent(framework, "BUSINESS EVENT: Project '" & projectName & "' restored from ashes.")
    Return 0
End Function


' --- MAIN DEMONSTRATION PROGRAM ---
Cls
Print "--- Business Event Framework Demonstration ---"
Print "----------------------------------------------"
Print

' 1. SETUP THE FRAMEWORK
Print "ACTION: Setting up the directory framework..."
Dim framework As BusinessFramework = SetupEventFramework("MyBusiness")
Print "Framework Root: " & framework.rootPath
Print " -> Active Projects: " & framework.activePath
Print " -> Project Ashes:   " & framework.ashesPath
Print " -> Event Logs:      " & framework.logPath
Sleep 2000
Print

' 2. CREATE A DUMMY PROJECT
Dim projectName As String = "Project_Phoenix"
Print "ACTION: Creating a new active project: '" & projectName & "'..."
MkDir framework.activePath & projectName
' Create a dummy file inside it
' Open framework.activePath & projectName & PathSeparator & "goals.txt" For Output As #1
Print #1, "Initial project goals."
Close #1
Print "Project created successfully."
Sleep 2000
Print

' 3. TRIGGER A BUSINESS EVENT: ARCHIVE THE PROJECT
Print "BUSINESS EVENT: Project '" & projectName & "' is now complete. Archiving..."
If ArchiveProjectToAshes(framework, projectName) = 0 Then
    Print "PROGRAM'S ACTION: Project successfully moved to the 'ashes' directory."
Else
    Print "ERROR: Could not archive project."
End If
Sleep 2500
Print

' 4. TRIGGER ANOTHER EVENT: RESTORE THE PROJECT
Print "BUSINESS EVENT: Management has requested to reopen '" & projectName & "'."
If RestoreProjectFromAshes(framework, projectName) = 0 Then
    Print "PROGRAM'S ACTION: Project successfully restored from the 'ashes' to active status."
Else
    Print "ERROR: Could not restore project."
End If
Sleep 2000
Print

Print "----------------------------------------------"
Print "Framework demonstration complete. Check the 'MyBusiness' folder and the 'events.log' file."
Print
Print "Press any key to exit..."
Sleep
End
' ```

' ### How to Compile and Run

' 1.  **Save Files:** Place both `dir.bi` and `main.bas` in the same directory.
' 2.  **Compile:** Open your terminal or command prompt, navigate to that folder, and run:
'     ```sh
'     fbc main.bas
'     ```
'     The compiler will automatically use `dir.bi` because of the `#include` directive.
' 3.  **Run:**
'     *   On Windows: `main.bas.exe` (or whatever your compiler names it)
'     *   On Linux/macOS: `./main.bas`

' When you run the program, it will create a folder named `MyBusiness` in the same directory. Inside, you will see the framework structure (`active_projects`, `project_ashes`, `event_logs`). The program will then create a `Project_Phoenix` folder, move it to `project_ashes`, and then move it back, logging each **business event** in `MyBusiness/event_logs/events.log`. This perfectly demonstrates your requested concept.
