#include "dialog.rc"

' **Considering the Structure**

' I'm currently focused on dissecting the request. My primary goal is to establish 
' the core task, which is creating a `dialog.bi` file using FreeBASIC. I need to define 
' what should be included in this file. I'm also considering the implications 
' of `main.bas`, but the focus right now is establishing the necessary components 
' for the `dialog.bi`.


' **Refining the Dialog Design**

' I've been solidifying the structure for `dialog.bi`. I'll define a `Type` for dialog 
' lines with a character name and their line. An array of this `Type` will store the 
' conversation. My aim is to include a `Declare Sub` for the display function, and I'm 
' determining the best way to handle user input prompts within `main.bas`, which will 
' include `dialog.bi`. I want to ensure the interaction feels natural.


' **Structuring the Dialogue System**

' I'm now implementing the `Type` and array for dialogue lines within `dialog.bi`, 
' including character name and dialogue content. I'm focusing on a clean `DisplayDialog` 
' subroutine declaration. I'll provide clear comments for better understanding, and ensure 
' a `#ifndef / #define / #endif` header guard to prevent redefinition errors. The aim is a 
' modular and easily understandable structure for the header file.

' I've defined the structure of the `dialog.bi` and now I'm thinking about the 
' implementation of `main.bas` to incorporate the defined header file. I will create 
' a function to display the dialogue from the provided array, with an appropriate pause 
' to allow users to interact with the narrative.


' **Defining the Interaction**

' I'm now determining how the dialog will be displayed and interacted with in `main.bas`. 
' I plan on iterating through the dialog array, printing each line, and implementing a 
' pause after each turn, likely requiring a key press from the user for the experience 
' to feel interactive. I'll provide a framework for a natural flow. I'll also add a 
' compile-time constant to define the maximum number of dialog lines in the header.


' **Crafting the Narrative Structure**

' I've outlined the dialogue using Gunnar and Elara, incorporating the material requests 
' within a focused narrative flow. The goal is to build a `dialog.bi` that enables the 
' display, including character names, dialogue content, and a clear subroutine declaration. 
' I plan to define a compile-time constant for the number of dialogue lines for easy 
' adjustment. I'm focusing on ensuring it's modular, commented, and includes header 
' guards. Furthermore, I'll structure the narrative with pauses and a visual framework 
' for the interaction in the `main.bas` file.


' **Structuring the Narrative Flow**

' I'm solidifying the narrative content. Elara and Gunnar's interaction is taking shape, 
' with the material requests woven into the conversation. The structure of `dialog.bi` 
' is defined, including the `Type`, character names and lines, and a `Declare Sub 
' DisplayDialog()`. The aim is now to implement `main.bas`, which will include the 
' interactions and user pauses.


' **Developing the Narrative**

' I'm now focusing on a narrative-driven structure for the dialogue. I'll craft a concise 
' conversation between Gunnar and Elara that includes material requests. The goal is to 
' build the initial conversation in `dialog.bi`, which will include an array of 
' `DialogLine` types, character names, and lines. Simultaneously, I'll create 
' `main.bas` to include the said dialogue and an interactive experience 
' for the user.



' Of course. Creating a `.bi` file (a header or "include" file in FreeBASIC) is a great 
' way to separate your data or function declarations from your main program logic. This 
' makes your project more organized.

' Here is a `dialog.bi` file that contains the data for a conversation about "materials 
' needed." I will also provide a `main.bas` file to show you how to use it.

' ---

' ### 1. The Header File: `dialog.bi`

' This file will define a custom data type to hold a line of dialog and then declare an 
' array containing the entire conversation.

' Save this code as `dialog.bi`:
' ```freebasic
' =================================================================
' FILENAME: dialog.bi
' DESCRIPTION:
' An include file for FreeBASIC.
' Contains the dialog data for a conversation about needed materials.
' This file should be included in a main .bas file.
' =================================================================

' Header guard to prevent this file from being included multiple times
#ifndef __DIALOG_BI__
#define __DIALOG_BI__

' -- DATA STRUCTURES --

' Define a type to hold one line of dialog
Type DialogLine
    character As String
    line      As String
End Type


' -- DIALOG DATA --

' Declare a shared array of our DialogLine type.
' The 'Shared' keyword makes it visible to the .bas file that includes this.
' This array holds the entire conversation.
' Dim Shared As DialogLine conversation(...) = { _
    ' ( "SCENE", "* (Elara, a young apprentice, approaches her master, Gunnar the forge-master, who is studying a complex blueprint.) *" ), _
    ' ( "Elara",   "Master Gunnar? I've cleared the forge. What materials will we need for the Sunstone project?" ), _
    ' ( "Gunnar",  "(Without looking up) The usual list will not suffice for this one, apprentice. The requirements are... specific." ), _
    ' ( "Elara",   "I'm ready to scribe the list." ), _
    ' ( "Gunnar",  "First, we need three ingots of river-cooled iron, not quench-cooled. It must be strong yet pliable." ), _
    ' ( "Elara",   "River-cooled iron... noted." ), _
    ' ( "Gunnar",  "Next, a bolt of whisper-silk for the wrappings. It must be woven under a new moon to hold the enchantment." ), _
    ' ( "Elara",   "Whisper-silk... that will be difficult to acquire." ), _
    ' ( "Gunnar",  "Of course it will be. We're not making horseshoes." ), _
    ' ( "Gunnar",  "We also need a vial of pure, undiluted honey from the mountain hives. It will be the binding agent." ), _
    ' ( "Elara",   "Honey? For metalwork?" ), _
    ' ( "Gunnar",  "It's not for the metal, it's for the light we intend to forge within it. And finally... the most important piece." ), _
    ' ( "Elara",   "(Leaning in) Yes, Master?" ), _
    ' ( "Gunnar",  "A piece of petrified emberwood. Find a piece that still feels warm to the touch. That will be the heart of the forge fire." ), _
    ' ( "Elara",   "Iron, silk, honey, and emberwood. I will gather them immediately!" ), _
    ' ( "Gunnar",  "(Finally looks up, a faint smile on his face) See that you do. The stone doesn't wait forever." ), _
    ' ( "SCENE", "* (Elara nods with determination and hurries out of the workshop.) *" ) _
' }

' -- FUNCTION DECLARATIONS --

' Declare the subroutine that will display the dialog.
' The actual code for this sub will be in our main .bas file.
Declare Sub PlayDialog()


#endif ' __DIALOG_BI__
' ```

' ---

' ### 2. The Main Program File: `main.bas`

' This file will include `dialog.bi` and contain the logic to display the conversation on the screen.

' Save this code as `main.bas` in the **same directory** as `dialog.bi`:
' ```freebasic
' =================================================================
' FILENAME: main.bas
' AUTHOR:   AI Assistant
'
' DESCRIPTION:
' Main program to display a dialog. It includes the dialog data
' from "dialog.bi" and contains the logic to print it to the
' screen in a readable format.
'
' TO COMPILE:
' fbc main.bas
'
' (The compiler will automatically find and use dialog.bi)
' =================================================================

' Include our dialog header file. The compiler will now have access
' to the 'conversation' array and the 'DialogLine' type.

' --- SUBROUTINE for displaying the dialog ---
' This is the implementation of the sub we declared in the .bi file.
Sub PlayDialog()
    Cls
    Print "--- The Sunstone Project ---"
    Print "----------------------------"
    Print

    ' Loop through every line in the 'conversation' array
    ' For i As Integer = Lbound(conversation) To Ubound(conversation)
        
    '     ' Check if the line is a scene description or character speech
    '     If conversation(i).character = "SCENE" Then
    '         ' Italic-style for scene descriptions
    '         Print conversation(i).line
    '     Else
    '         ' Format for character speech
    '         Print conversation(i).character; Tab(10); ": "; conversation(i).line
    '     End If
        
    '     ' Pause to make the dialog readable
    '     Sleep 2500
    '     Print
    ' Next i
End Sub


' --- MAIN PROGRAM ---

' Set a screen mode for better compatibility
ScreenRes 800, 600, 32

' Call the subroutine that plays our dialog
PlayDialog()

' --- END ---
Print
Print "--- END OF DIALOG ---"
Print
Print "Press any key to exit..."

' Wait for a keypress before closing the console window
Sleep
End
' ```

' ### How to Compile and Run

' 1.  **Save Files:** Make sure both `dialog.bi` and `main.bas` are saved in the same folder.
' 2.  **Open Terminal/Command Prompt:** Navigate to the folder where you saved the files.
' 3.  **Compile:** Run the FreeBASIC compiler on the main file.
'     ```sh
'     fbc main.bas
'     ```
'     The compiler is smart enough to see the `#include "dialog.bi"` line and will automatically incorporate it into the final program. You do not need to compile `dialog.bi` separately.
' 4.  **Run:** Execute the compiled program.
'     *   On Windows: `main.exe`
'     *   On Linux/macOS: `./main`

' The program will now display the conversation about the needed materials, with pauses between each line, just as you requested.
