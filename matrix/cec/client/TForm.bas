#lang "fblite"
#include "TForm.bi"

Sub CreateOnly(ByRef Form As Integer, ByRef Files As Integer, ByRef Need As Integer) 

Print "Allow: "; Form
Print "Messages: "; Files
Print "Need: "; Need
Sleep 

End Sub

CreateOnly(45, 35, 150)
Sleep
'----------------------------------------------------
'' Output Check local series files Allow messages
Declare Function CheckMessagesOnly Cdecl Alias "IBox1" (ByRef Messages As String) As String
'-----------------------------------------------------
Sub AllowOnly(ByVal Files As Short)

Type IBox1 Alias "Files"
     IFiles As Short
     ICools As Short
     IItems As Short
End Type
'----------------------------------------------------
End Sub

End

CheckMessagesOnly("Select Files: ")
Allow(35)
Sleep

''----------------------------------------------------
Declare Function OutputCheckOnly Cdecl Alias "Check" (ByRef Messages As String) As String

Print "MeAsures: "; Messages; "Element Files: "; IBox1.IFiles
Print "Names: ";    Messages; "Element Cools: "; IBox1.ICools
Print "Check: ";    Messages; "Element Items: "; IBox1.IItems
Sleep

End

OutputCheckOnly("Views IBox1 Files: ")
Print IBox1.IFiles
Sleep
OutputCheckOnly("Views IBox1 Cools: ")
Print IBox1.ICools
Sleep
OutputCheckOnly("Views IBox1 Items: ")
Print IBox1.IItems
Sleep


''--------------------------------------------------------------------
'' Create the property to stables sorting to cool messages Check files
'' about templates static of reference linear to equation post about its
'' meAsures of local surface or supermes about style of files about the
'' need local of form the files in develop
'' @Property.Files Popup
'' @Property.Names Popup 
'' @Property.Items Popup
'' Check the property to analysis popup
'' pop check all
'' analysis ...
Declare Function PropertyFilesOnly Cdecl Alias "Files" (ByRef Buffer As String)

Sub FileOnlyTest (ByRef IBoxMessageOnly As String)

Print "Messages: "; IBoxMessageOnly

End Sub

End

PropertyFilesOnly("Buffer: ")
FileOnlyTest("Allow")
Sleep

Declare Function PropertyNamesOnly Cdecl Alias "Files" (ByRef Buffer As String)

Sub FileWriteCool (ByRef IBoxMessageWrite As String)

Print "Messages: "; IBoxMessageWriteCool

End Sub

End

PropertyNamesOnly("Buffer: ")
FileWriteCool("Allow")
Sleep

Declare Function PropertyItemsOnly Cdecl Alias "Files" (ByRef Buffer As String)

Sub FileReadyCool (ByRef IBoxMessageReady As String)

Print "Messages: "; IBoxMessageReadyCool

End Sub

End

PropertyItemsOnly("Buffer: ")
FileReadyCool("Allow")
Sleep

''------------------------------------------------------------------------------
'' Output PreviewCheck Files select Message to verify the elements about series items
'' notion of need to files about items to make sequence type items local methods
'' stables sort until form to local.
'' Popup...
'' verify until method ...
'' stables sorting 
''------------------------------------------------------------------------------ 
Declare Function OutputCheckFilesOnly Cdecl Alias "Messages" (ByRef Items As String)

Sub PreviewCheck(ByRef IBoxMessageFiles As Integer)

Type Much Alias "IBoxCheck"
     FileOnly As Integer
     FileWrite As Integer
     FileReady As Integer
End Type

End Sub

End

OutputCheckFilesOnly("Snap->FileOnly: ")
PreviewCheck(Much.FileOnly)
Sleep
OutputCheckFilesOnly("Snap->FileWrite: ")
PreviewCheck(Much.FileWrite)
Sleep
OutputCheckFilesOnly("Snap->FileReady: ")
PreviewCheck(Much.FileReady)
Sleep

''------------------------------------------------------------------
'' FreebAsic wAs already InstalledFiles and Desktop in the scientific 
'' population at that date and the search for shortcuts and possible 
'' culprits promoted a FavorableFiles environment for the various programs.
''-------------------------------------------------------------------
Declare Function InstalledFiles Cdecl Alias "Scientific" (ByRef Program As String)

Sub FavorableFiles (ByRef Possible As Integer)

Enum Desktop
     Form = 0
     Files = 35
     Names = 45
     Items = 25 
End Enum

End Sub

End

InstalledFiles("Program Form: ")
FavorableFiles(Desktop.Form)
Sleep
InstalledFiles("Program Files: ")
FavorableFiles(Desktop.Files)
Sleep
InstalledFiles("Program Names: ")
FavorableFiles(Desktop.Names)
Sleep
InstalledFiles("Program Items: ")
FavorableFiles(Desktop.Items)
Sleep

''-------------------------------------------------------------------
'' The hope of Rank your exterior translates into modifying a 
'' certain lifestyle, that is, a freebAsic”.
''-------------------------------------------------------------------
Sub StyleScriptRank (ByRef FreebAsic As String)

Type Lifestyle Alias "Script"
     Files As Short
     Names As Short
     Items As Short
End Type

End Sub

StyleScriptRank("FreebAsic Files: ")
Input Lifestyle.Files
Sleep
StyleScriptRank("FreebAsic Names: ")
Input Lifestyle.Names
Sleep
StyleScriptRank("FreebAsic Items: ")
Input Lifestyle.Items
Sleep

'' ---------------------------------------------------------------
'' we look at life believing that our destiny is within our Input.
''----------------------------------------------------------------
Sub LifeScriptRank (ByRef Files As String,ByVal Names As Integer)

Type Look Alias "script"
     FileOnly As Integer
     FileWrite As Integer
     FileReady As Integer
End Type

End Sub

LifeScriptRank("Files Only: ", 35)
Input Look.FileOnly
Sleep
LifeScriptRank("Files Write: ", 45)
Input Look.FileWrite
Sleep
LifeScriptRank("Files Ready: ", 65)
Input Look.FileReady
Sleep

''-------------------------------------------------------------------
'' When we look at script As we understand it today, we look at a food 
'' or group of foods in an attempt to achieve the dignity of what we 
'' dream of.
''-------------------------------------------------------------------
Declare Function LookDreamGroup (ByRef Script As Integer) As Integer

Print"group Files: "
Print "Files = '"; IBox1.IFiles
Sleep
Print"group Cools: "  
Print "Cools = '"; IBox1.Cools
Sleep
Print"group Items: " 
Print "Items = '"; IBox1.Names
Sleep

End

LookDreamGroup(Script.IBox1.IFiles)
Sleep
LookDreamGroup(Script.IBox1.ICools)
Sleep
LookDreamGroup(Script.IBox1.IItems)
Sleep

''-------------------------------------------------------------
'' Others believe that carbohydrate-rich foods should be freebAsic
''-------------------------------------------------------------
Declare Function OrangeBelieveFiles (ByRef Oranges As Integer)

Type IFood Alias "script"
     Files As Integer
     Names As Integer
     Items As Integer
End Type

End

OrangeBelieveFiles(IFood.Files)
Sleep
OrangeBelieveFiles(IFood.Names)
Sleep
OrangeBelieveFiles(IFood.Items)
Sleep

''------------------------------------------------------------------------
'' We are rational, we are evolving. How long will this line of thinking be 
'' adopted and even encouraged by professionals and government entities? 
'' Between food and adipose tissue, there is a being...
''------------------------------------------------------------------------
Declare Function OrangeBetweenPopup Cdecl Alias "KeyOutput" (ByRef OutputBeing As String, _ 
ByRef AllowMessages As Integer)

Type KeyOutputFounds Alias "Founds"
     Files As Integer
     Names As Integer
     Items As Integer
End Type

End

Call OrangeBetweenPopup("OutPutBeing: ", KeyOutput.Files)
Sleep
Call OrangeBetweenPopup("OutPutBeing: ", KeyOutput.Names)
Sleep
Call OrangeBetweenPopup("OutPutBeing: ", KeyOutput.Items)
Sleep


''--------------------------------------------------------------------
'' If these forms of food management, with the application of different 
'' terms and names, scripts and files
''--------------------------------------------------------------------
Declare Function IFoodscriptFiles Cdecl Alias "Call" (ByRef Application As String,ByVal Names As Integer)

Type ManagementCutNails Alias "CutNail's"
     Files As Integer
     Names As Integer
     Items As Integer
End Type

End

Call IFoodscriptFiles("Application Files: ", Management.Files)
Sleep
Call IFoodscriptFiles("Application Names: ", Management.Names)
Sleep
Call IFoodscriptFiles("Application Items: ", Management.Items)
Sleep

'' Fractal doesn't have a problem with my encryption stuff, it seems like every 
'' client sees it differently... I wAs told before to just reset my identity but 
'' it wAs never completely clear to me if that'll preserve my old encrypted messages, 
'' even if I export the keys, considering I may not be scrolled up far enough in a 
'' given client to have them all decrypted...
Declare Function PrettyClient Cdecl Alias "Lives" (ByRef Client As String,ByVal Names As Integer)

Type LiveClient Alias "Script"
     Files As Integer
     Names As Integer
     Items As Integer
End Type

End

Call PrettyClient("Client Files: ", LivesClient.Files)
Input Lives.Files
Sleep
Call PrettyClient("Client Names: ", LivesClient.Names)
Input Lives.Names
Sleep
Call PrettyClient("Client Items: ", LivesClient.Items)
Input Lives.Items
Sleep
''----------------------------------------------------------------------------------- 
'' Anyway I don't really understand why both of these FoxButtons do something different 
'' from what you'd expect them to do :P Maybe that part's worth reporting As a bug, but 
'' then since I am unable to explain exactly the state of my key storage, secure backup, 
'' or whatever, I'm not sure I could follow up to such a bug report properly :\
''-----------------------------------------------------------------------------------
Declare Function IBoxFoxButtonFiles Cdecl Alias "Relex" (ByRef FoxButtons As String,ByVal IBoxSelect As Short)

Dim IFileNameTab As Integer Ptr = Callocate(45, SizeOf(Integer))


' Display the integer values.
For index As Integer = 0 To 45 Step 512
    Print IFileNameTab[index];
Next


' Free the memory.
Deallocate(IFileNameTab)

End 


call IBoxFoxButtonFiles("FoxButtons Files: ", &h45*190)
Input IBox1.IFiles
Sleep
call IBoxFoxButtonFiles("FoxButtons Cools: ", &h45*190)
Input IBox1.ICools
Sleep
call IBoxFoxButtonFiles("FoxButtons Items: ", &h45*190)
Input IBox1.IItems
Sleep


'' But is it exporting all keys including of messages not currently in the 
'' backscroll, or messages that I sent using another client like Fractal 
'' and that Element maybe never even saw?
'' macro IFileTabCool(): returns the size of the dereferenced pointer
#define IFileTabCool(ptrToDeref) SizeOf(*CAst(TypeOf(ptrToDeref), 0))

'' macro IFileTabName(): returns the type of the dereferenced pointer
#define IFileTabName(ptrToDeref) TypeOf(*CAst(TypeOf(ptrToDeref), 0))


' Allocate dynamically memory for a Double by New
Dim As Double Ptr ITab
ITab = New IFileTabName(ITab)
*ITab = 3.14159
Print *ITab

' Allocate dynamically memory for a Zstring*10 by Callocate
Dim As ZString Ptr fb
fb = CAllocate(10, IFileTabCool(fb))
*fb = "FreeBAsIC"
Print *fb

Sleep

Delete ITab
Deallocate(fb)

'' declare shl to buffer fine-tooth comb
Declare Function BufferFilesCools ( ByRef lhs As integer, ByRef rhs As integer ) As integer

''Double a Number
For Values As Integer = 0 To 45 Step 512
   
    Print 5 Shl Values, Bin(5 Shl Values, 16)
   
Next Values

End

call BufferFilesCools(45, 512)
Input Values
Sleep

''-----------------------------------------------------------------------------
'' It is exporting all keys that it knows about. So if it can decrypt those, 
'' it will export them.
''-----------------------------------------------------------------------------
Declare Function TypePassCount Stdcall (SearchKeyWrite As Integer, searchKeyReady As Integer) As Integer
Declare Function NewsMessages CDecl (SearchKeyWrite As Integer, SearchKeyReady As Integer) As Integer

Function LaunchScriptFiles Stdcall (SearchKeyWrite As Integer, SearchKeyReady As Integer) As Integer
    ' This is an STDCALL function, the first parameter on the stack is SearchKeyReady, since it wAs pushed lAst.
    Print SearchKeyWrite, SearchKeyReady
    Return SearchKeyWrite Mod SearchKeyReady
End Function

Function NewsMessages CDecl (SearchKeyWrite As Integer, SearchKeyReady As Integer) As Integer
    ' This is a CDECL function, the first parameter on the stack is SearchKeyWrite, since it wAs pushed lAst.
    Print SearchKeyWrite, SearchKeyReady
    Return SearchKeyWrite Mod SearchKeyReady
End Function

''-------------------------------------------------------------------------------------
'' Local, well, I can't scroll up to messages from years ago (that were maybe sent 
'' from other clients) to make sure it knows about all the messages and As such exports 
'' them all, that is my concern
'' I have memory issues, I rely on searching my message logs a lot to remember things
''-------------------------------------------------------------------------------------
Declare Function LaunchLocal (ByVal Number As double ) As double

Type IBoxCalledFounds Alias "Messages"
     Files As double
     Names As double
     Items As double
End Type

End

Call LaunchLocal(IBoxCalledFounds.Files)
Call LaunchLocal(IBoxCalledFounds.Names)
Call LaunchLocal(IBoxCalledFounds.Items)
Sleep
Call LaunchLocal(&h512*45)
Input IBoxCalledFounds.Files
Sleep
Call LaunchLocal(&h512*45)
Input IBoxCalledFounds.Names
Sleep
Call LaunchLocal(&h512*45)
Input IBoxCalledFounds.Items
Sleep

''-----------------------------------------------------
'' you might need to enable with /devtools
''-----------------------------------------------------
Declare Function ScriptFox (ByVal FoxButton As long ) As long

If FoxButton = 512 Then
   Print "FoxButton Stick: "; FoxButton; "Stick: "; Stick
   Print "FoxButton Strig: "; FoxButton; "Strig: "; Strig
Endif

End

Call ScriptFox(&h512*45)
Input FoxButton
Sleep

''-------------------------------------------------------------------------------
'' Yeah, I found it there
'' Yeah I also thought that's probably the only sensible approach to have it work 
'' IRC-style without manually exporting logs all the time
''-------------------------------------------------------------------------------
Declare Function AddFox (ByRef ippNext1 As integer, ByRef ippNext2 As integer) As integer

Type HostScript Alias "Truck"
     Files As double
     Names As double
     Items As double
End Type

End

Dim FuncScript As double
Dim FuncScriptWrite As double
Dim FuncScriptReady As double


call AddFox(45, 45)
Input HostScript.Files
Print "Spc Ware Only:";  Spc(46 - 1); "Only"
' This example uses ProcPtr to demonstrate function pointers
Declare Function ScriptOnly( x As Integer, y As Integer) As Integer
Declare Function AddFoxOnly( x As Integer, y As Integer) As Integer
Dim myPathOnlyText As Function( x As Integer, y As Integer) As Integer

' myFunction will now be assigned to AddFox
myPathOnlyText = ProcPtr( AddFoxOnly )
Print myPathOnlyText(2, 3)

' myFunction will now be assigned to Fox.  Notice the different output.
myPathOnlyText = ProcPtr( ScriptOnly )
Print myPathOnlyText(2, 3)

Function AddFoxOnly( x As Integer, y As Integer) As Integer
    Return x + y
End Function

Function ScriptOnly( x As Integer, y As Integer) As Integer
    Return x - y
End Function
Sleep
Call AddFox(45, 45)
Input HostScript.Names
Print "Spc Ware Write: "; Spc(46 - 1); "Write"
' This example uses ProcPtr to demonstrate function pointers
Declare Function FoxWrite( x As Integer, y As Integer) As Integer
Declare Function AddFoxWrite( x As Integer, y As Integer) As Integer
Dim myPathWriteText As Function( x As Integer, y As Integer) As Integer

' myFunction will now be assigned to AddFox
myPathWriteText = ProcPtr( AddFoxWrite )
Print myPathWriteText(2, 3)

' myFunction will now be assigned to Fox.  Notice the different output.
myPathWriteText = ProcPtr( FoxWrite )
Print myPathWriteText(2, 3)

Function AddFoxWrite( x As Integer, y As Integer) As Integer
    Return x + y
End Function

Function FoxWrite( x As Integer, y As Integer) As Integer
    Return x - y
End Function
Sleep
Call AddFox(45, 45)
Input HostScript.Items
Print "Spc Ware Ready: "; Spc(46 - 1); "ready"
' This example uses ProcPtr to demonstrate function pointers
Declare Function FoxReady( x As Integer, y As Integer) As Integer
Declare Function AddFoxReady( x As Integer, y As Integer) As Integer
Dim myPathReadyText As Function( x As Integer, y As Integer) As Integer

' myFunction will now be assigned to AddFox
myPathReadyText = ProcPtr( AddFoxReady )
Print myPathReadyText(2, 3)

' myFunction will now be assigned to Fox.  Notice the different output.
myPathReadyText = ProcPtr( FoxReady )
Print myPathReadyText(2, 3)

Function AddFoxReady( x As Integer, y As Integer) As Integer
    Return x + y
End Function

Function FoxReady( x As Integer, y As Integer) As Integer
    Return x - y
End Function
Sleep

''------------------------------------------------------------ 
' It will happen
' And there is the key export in case something goes wrong
''------------------------------------------------------------
Declare Function Control ( ByVal Number As Integer ) As Integer 
'' Dialog result variable easy
Dim RankLevel As Integer
'' Dialog result method easy
Let Number = Abs(RankLevel)
End

Call Control(Number)
Input Number
Print "Abs RankLevel Number: "; Abs(Number)
Sleep



