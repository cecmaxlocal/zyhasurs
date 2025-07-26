' **Examining the Core Task**

' I've been deconstructing the user's request, focusing on the core task: building 
' a settings graphic button class within FreeBASIC using `fbgfx.bas`. I'm starting 
' to identify the key functionalities this class needs, like drawing, handling clicks, 
' and managing different states (hover, pressed, etc.). I'm also considering the design 
' of the graphic itself.


' **Designing the Class Structure**

' I'm now diving into the specifics of the `SettingsButton` class. I'm focusing on 
' defining its internal structure: which properties and methods are essential. I've 
' sketched out properties like position, size, and state-dependent colors. The core 
' will be the drawing and click-detection methods, alongside state-management logic. 
' The icon drawing is the next hurdle.


' **Elaborating the Gear Icon**

' I'm now focusing on the gear icon's construction. Initially, I will draft the central 
' and outer circle using `Circle`. The teeth will be constructed with `Line`, considering 
' angles to create a symmetrical look. I'm exploring different methods to calculate the 
' tooth positions using trigonometry, specifically `Sin` and `Cos` in FreeBASIC. I need 
' to figure out the best method to draw and fill it.


' **Implementing the Gear Icon**

' I've been figuring out the most efficient way to draw the gear icon in FreeBASIC. 
' While `Polygon` might be suitable, I opted to use `Line` primitives for drawing the 
' gear's teeth. The structure will consist of a central circle and an outer circle. I'll 
' determine the starting and ending points of a tooth, calculating the angles, and drawing 
' the lines to construct the tooth shape. I'll test drawing techniques until I get the 
' result needed.


' **Formulating the Gear's Design**

' I'm now thinking about the internal design of the gear's teeth. I'm starting with a loop 
' to calculate angles for each tooth, aiming for eight symmetrical teeth initially.  I've 
' sketched out the central circle and outer circle, and now it's time to translate the 
' calculations and drawings into code.  I'll then explore implementing the methods like 
' `Draw` and `Update`.


' **Developing the Icon Algorithm**

' I'm zeroing in on the icon's design and drawing method.  I've decided to employ a 
' trapezoidal approach for each tooth, ensuring a clean and manageable implementation. 
' I'm focusing on defining clear radii and angles for a crisp and recognizable gear 
' representation. The color palette considerations are next.


' **Defining the Gear Icon**

' I'm now zeroing in on the algorithm for the gear icon. I'll use a series of calculations 
' and lines, specifically targeting a simple trapezoid for each tooth to facilitate efficient 
' rendering. I'll focus on precise radii and angles to maintain the gear's recognizable 
' shape. The selection of a suitable color palette will be next.


' **Implementing the Gear's Design**

' I'm making progress in drawing the gear icon with lines.  I've simplified the algorithm 
' to render recognizable teeth with an eight-tooth design. I'm focusing on angles and radius 
' calculations to create the basic shapes, ensuring a simple, yet effective, representation 
' for the icon. Filling is next.


' **Simplifying the Implementation**

' I'm now streamlining the gear drawing logic. The focus has shifted to a simpler 
' implementation: a filled circle for the body, and arcs to draw each tooth. My recent 
' efforts refined the `Update` method, and testing will be a priority before adding any 
' other elements.


' **Focusing on Icon Refinement**

' My focus has shifted to drawing the gear icon. I've been considering using filled 
' trapezoids for the gear's teeth for better performance. I need to get the tooth shape 
' accurate and recognizable while also keeping the code simple and efficient. Now, I will 
' implement it and test it out.


' **Revising the Implementation**

' I've been looking at the gear icon implementation. I'm focusing on the best drawing 
' approach for both appearance and performance. I will retest the tooth's trapezoid method, 
' aiming for a simpler, clearer drawing. I'm prioritizing accuracy for the gear. The testing 
' will provide the final structure.


' **Refining the Drawing Logic**

' I've been improving the gear icon with more precise drawing.  I'm now calculating more 
' accurately, using lines for the teeth, aiming for a sharper, more defined look.  The main 
' challenge is getting those angles correct to draw recognizable teeth. I'm focusing on 
' simplicity while enhancing visual clarity, and I'll test the final rendering logic.


' **Optimizing the Implementation**

' I'm now focusing on optimizing the drawing code for the gear. I've switched from filled 
' circles to lines, simplifying the drawing process. I will test different radii to create 
' a recognizable and cleaner-looking gear. I'm focusing on minimizing the number of 
' calculations, and the colors will come after.


' **Refining the Gear Construction**

' I've been working on the gear icon. I tried lines for the teeth, but now I'm experimenting 
' with an arc-based design for a simpler and recognizable look. I will calculate and test the 
' arc algorithm, and then add color variations and hover effects to the implementation.



' Of course! Here are the complete files for a `SettingsButton` class in FreeBASIC using 
' the `fbgfx` library.

' This solution is broken down into three parts:
' 1.  **The Class Files (`.bi` and `.bas`)**: These are the core components of your reusable button class.
' 2.  **The Documentation (`README.md`)**: This explains how to use the class.
' 3.  **An Example Program (`example.bas`)**: This demonstrates the button in action.

' ---

' ### 1. Class Script Files

' You will create two files for the class itself. This separation is standard practice, with the `.bi` file acting as a "header" (defining the structure) and the `.bas` file containing the "implementation" (the actual code for the methods).

' #### `SettingsButton.bi` (The Header/Interface File)
' This file defines the `SettingsButton` type, including its properties and method declarations.

' ```freebasic
' ==========================================================================
'  File:    SettingsButton.bi
'  Author:  AI Assistant
'  Date:    October 2023
'  About:   Interface/Header for a graphical settings button class.
'           This button displays a "gear" icon and handles mouse
'           interaction (hover, click).
' ==========================================================================
#lang "fblite"
#ifndef __SETTINGSBUTTON_BI__
#define __SETTINGSBUTTON_BI__

#include "fbgfx.bi"

Type SettingsButton
    ' -- Public Properties - Can be changed after creation --

    ' Position and Size
    x As Integer
    y As Integer
    size As Integer  ' The button is a square, so size is width and height

    ' --- Colors ---
    ' Normal State
    bgColor As UInteger = Rgb(40, 40, 40)
    iconColor As UInteger = Rgb(200, 200, 200)

    ' Hover State
    hoverBgColor As UInteger = Rgb(70, 70, 70)
    hoverIconColor As UInteger = Rgb(255, 255, 255)

    ' Clicked/Down State
    downBgColor As UInteger = Rgb(20, 100, 180)
    downIconColor As UInteger = Rgb(255, 255, 255)

    ' Disabled State
    disabledBgColor As UInteger = Rgb(30, 30, 30)
    disabledIconColor As UInteger = Rgb(80, 80, 80)
    
    ' --- Public Methods ---
    ' Declare Constructor (ByVal newX As Integer, ByVal newY As Integer, ByVal newSize As Integer)
    ' Declare Sub Draw()
    ' Declare Function Update() As Boolean
    ' Declare Sub SetPosition(ByVal newX As Integer, ByVal newY As Integer)
    ' Declare Sub Enable()
    ' Declare Sub Disable()

    ' -- Private Members - For internal state management --
    Private:
    isHover As Boolean = false
    isDown As Boolean = false
    isDisabled As Boolean = false
    centerX As Integer
    centerY As Integer
    radius As Single
End Type

#endif ' __SETTINGSBUTTON_BI__
' ```

' #### `SettingsButton.bas` (The Implementation File)
' This file contains the code that makes the button work.

' ```freebasic
' ==========================================================================
'  File:    SettingsButton.bas
'  Author:  AI Assistant
'  Date:    October 2023
'  About:   Implementation for the SettingsButton class.
' ==========================================================================

#include "SettingsButton.bi"

' Using fbgfx namespace to shorten calls like fbgfx.Sin to Sin
' Using FB
' --- Constructor: Initializes a new button ---
' Constructor SettingsButton (ByVal newX As Integer, ByVal newY As Integer, ByVal newSize As Integer)
'     this.x = newX
'     this.y = newY
'     this.size = newSize
'     this.radius = newSize / 2.0
'     this.centerX = newX + this.radius
'     this.centerY = newY + this.radius
' End Constructor

' --- SetPosition: Moves the button to a new location ---
' Sub SettingsButton.SetPosition(ByVal newX As Integer, ByVal newY As Integer)
'     this.x = newX
'     this.y = newY
'     this.centerX = newX + this.radius
'     this.centerY = newY + this.radius
' End Sub

' --- Enable: Makes the button interactive ---
' Sub SettingsButton.Enable()
'     this.isDisabled = false
' End Sub

' --- Disable: Makes the button non-interactive ---
' Sub SettingsButton.Disable()
'     this.isDisabled = true
'     this.isHover = false
'     this.isDown = false
' End Sub

' --- Update: Handles mouse logic and returns TRUE if clicked ---
' Function SettingsButton.Update() As Boolean
'     If this.isDisabled Then Return false

'     Dim As Integer mx, my, mb
'     GetMouse(mx, my, , mb)

'     Dim clicked As Boolean = false

'     ' Check if mouse is within the button's circular area
'     Dim distSq As Single = (mx - this.centerX)^2 + (my - this.centerY)^2
'     If distSq < this.radius^2 Then
'         this.isHover = true

'         ' Check for mouse button down (press)
'         If mb And 1 Then
'             this.isDown = true
'         Else
'             ' Check for mouse button up (release)
'             ' This is a click event only if the button was previously pressed
'             If this.isDown Then
'                 clicked = true
'             End If
'             this.isDown = false
'         End If
'     Else
'         this.isHover = false
'         this.isDown = false
'     End If

'     Return clicked
' End Function

' --- Draw: Renders the button to the screen ---
' Sub SettingsButton.Draw()
'     ' --- Determine current colors based on state ---
'     Dim currentBgColor As UInteger
'     Dim currentIconColor As UInteger

'     If this.isDisabled Then
'         currentBgColor = this.disabledBgColor
'         currentIconColor = this.disabledIconColor
'     ElseIf this.isDown Then
'         currentBgColor = this.downBgColor
'         currentIconColor = this.downIconColor
'     ElseIf this.isHover Then
'         currentBgColor = this.hoverBgColor
'         currentIconColor = this.hoverIconColor
'     Else
'         currentBgColor = this.bgColor
'         currentIconColor = this.iconColor
'     End If

'     ' --- Draw the button background (a filled circle) ---
'     Circle (this.centerX, this.centerY), this.radius, currentBgColor, , , , F

'     ' --- Draw the "gear" icon ---
'     Const PI = 3.14159265
'     Const NUM_TEETH = 8
    
'     Dim toothLength As Single = this.size * 0.15
'     Dim bodyRadius As Single = this.size * 0.5 - toothLength
'     Dim holeRadius As Single = this.size * 0.18

'     ' Draw gear body
'     Circle (this.centerX, this.centerY), bodyRadius, currentIconColor, , , , F
'     ' Punch a hole in the middle
'     Circle (this.centerX, this.centerY), holeRadius, currentBgColor, , , , F
    
'     ' Draw gear teeth
'     For i As Integer = 0 To NUM_TEETH - 1
'         Dim angle As Single = i * (360 / NUM_TEETH)
'         Dim radAngle As Single = angle * PI / 180

'         ' Calculate the 4 corners of a rotated rectangle for the tooth
'         Dim toothWidthAngle As Single = 10 * PI / 180 ' Controls how wide the tooth is
'         Dim cx = this.centerX
'         Dim cy = this.centerY

'         Dim x1 = cx + bodyRadius * Cos(radAngle - toothWidthAngle)
'         Dim y1 = cy + bodyRadius * Sin(radAngle - toothWidthAngle)
        
'         Dim x2 = cx + (bodyRadius + toothLength) * Cos(radAngle - toothWidthAngle)
'         Dim y2 = cy + (bodyRadius + toothLength) * Sin(radAngle - toothWidthAngle)
        
'         Dim x3 = cx + (bodyRadius + toothLength) * Cos(radAngle + toothWidthAngle)
'         Dim y3 = cy + (bodyRadius + toothLength) * Sin(radAngle + toothWidthAngle)
        
'         Dim x4 = cx + bodyRadius * Cos(radAngle + toothWidthAngle)
'         Dim y4 = cy + bodyRadius * Sin(radAngle + toothWidthAngle)
        
'         ' Draw the tooth as a filled polygon
'         Line (x1, y1)-(x2, y2), currentIconColor
'         Line (x2, y2)-(x3, y3), currentIconColor
'         Line (x3, y3)-(x4, y4), currentIconColor
'         Line (x4, y4)-(x1, y1), currentIconColor
        
'         ' Find a point inside the tooth to start the fill
'         Dim paintX = cx + (bodyRadius + toothLength/2) * Cos(radAngle)
'         Dim paintY = cy + (bodyRadius + toothLength/2) * Sin(radAngle)
'         Paint (paintX, paintY), currentIconColor, currentIconColor
'     Next i

' End Sub
' ```

' ---

' ### 2. Documentation (`README.md`)

' This file explains how to integrate and use the class in your own projects.

' ```markdown
' # FreeBASIC fbgfx SettingsButton Class

' A simple, self-contained, and reusable graphical "settings" button class for FreeBASIC projects using the `fbgfx` library.

' The button is circular, displays a gear icon, and visually responds to mouse hover and click events.

' ## Features

' -   **Object-Oriented**: Encapsulated in a `Type` for easy reuse.
' -   **Interactive States**: Handles normal, hover, click, and disabled states.
' -   **Customizable**: All colors for all states can be changed via public properties.
' -   **Simple API**: Easy to integrate with a standard game loop (`Update` and `Draw`).
' -   **No External Assets**: The gear icon is drawn procedurally with `fbgfx` primitives.

' ## Files

' 1.  `SettingsButton.bi`: The class header file. You `#include` this in your main project.
' 2.  `SettingsButton.bas`: The class implementation file. You must compile this with your project.
' 3.  `example.bas`: A program demonstrating how to use the class.

' ## How to Use

' 1.  **Place the Files**: Put `SettingsButton.bi` and `SettingsButton.bas` in the same directory as your main project file.

' 2.  **Include the Class**: In your main `.bas` file, you only need to include the implementation file. It will automatically find the `.bi` file.
'     ```freebasic
'     #include "SettingsButton.bas"
'     ```

' 3.  **Create an Instance**: Declare and initialize a button variable. The constructor takes the top-left X, Y coordinates and the size (diameter).
'     ```freebasic
'     ' Create a button at (100, 100) with a size of 60 pixels
'     Dim mySettingsButton As SettingsButton = SettingsButton(100, 100, 60)
'     ```

' 4.  **Integrate into Game Loop**: In your main loop, you must call the button's `Update()` and `Draw()` methods every frame.

'     -   `Update()` handles all mouse logic. It returns `True` for a single frame when the button is successfully clicked.
'     -   `Draw()` renders the button to the screen.

'     ```freebasic
'     Do
'         ' --- EVENT HANDLING ---
'         If mySettingsButton.Update Then
'             Print "Settings button was clicked!"
'             ' Add your settings logic here, like opening a menu
'         End If

'         ' --- DRAWING ---
'         ScreenLock
'         Cls

'         ' mySettingsButton.Draw

'         ' Draw other game elements...

'         ScreenUnlock
'         Sleep 10, 1
'     Loop Until MultiKey(&h01) ' Exit on ESC
' '     ```

' ## Class Reference (API)

' ### Constructor

' `Declare Constructor (ByVal newX As Integer, ByVal newY As Integer, ByVal newSize As Integer)`
' Creates a new button at position `(newX, newY)` with a diameter of `newSize`.

' ### Methods

' `Function Update() As Boolean`
' -   Checks mouse position and button state.
' -   Updates the button's internal `isHover` and `isDown` flags.
' -   **Returns `True` on the frame the button is clicked (mouse released over the button), otherwise returns `False`.**

' `Sub Draw()`
' -   Draws the button to the graphics screen based on its current state (normal, hover, etc.).

' `Sub SetPosition(ByVal newX As Integer, ByVal newY As Integer)`
' -   Moves the button to a new location after it has been created.

' `Sub Enable()`
' -   Enables the button, making it interactive.

' `Sub Disable()`
' -   Disables the button. It will be drawn in a "grayed-out" style and will not respond to mouse input.

' ### Public Properties (for Customization)

' You can change these colors at any time.

' -   `bgColor`, `iconColor`: Colors for the normal state.
' -   `hoverBgColor`, `hoverIconColor`: Colors when the mouse is over the button.
' -   `downBgColor`, `downIconColor`: Colors when the mouse button is being held down on the button.
' -   `disabledBgColor`, `disabledIconColor`: Colors when the button is disabled.

' **Example of Customization:**
' ```freebasic
' Dim myButton As SettingsButton

' Make it a red button
' myButton.bgColor = Rgb(150, 20, 20)
' myButton.hoverBgColor = Rgb(200, 30, 30)
' myButton.iconColor = Rgb(255, 255, 255)
' ```

' ## Compiling

' Use the FreeBASIC compiler (`fbc`) and specify your main file. It will automatically find and compile the included files.

' ```bash
' fbc example.bas
' ```
' Then run the resulting executable.
' ```bash
' ./example
' ' or on Windows:
' example.exe
' ```
' ```

' ---

' ### 3. Example Program (`example.bas`)

' This file shows a complete, working example of how to use the `SettingsButton` class.

' ```freebasic
' ==========================================================================
'  File:    example.bas
'  Author:  AI Assistant
'  Date:    October 2023
'  About:   Demonstrates the use of the SettingsButton class.
' ==========================================================================

' We only need to include the .bas file. It will handle its own .bi dependency.
' #include "SettingsButton.bas"

' --- Screen Setup ---
Const SCR_W = 800
Const SCR_H = 600
ScreenRes SCR_W, SCR_H, 32

' --- Create Button Instances ---

' A standard button in the top-left
' Dim btn1 As SettingsButton = SettingsButton(20, 20, 60)

' A larger, customized button in the center
' Dim btn2 As SettingsButton = SettingsButton( (SCR_W - 100) / 2, (SCR_H - 100) / 2, 100)
' Customize its colors
btn2.bgColor = Rgb(10, 80, 20)
btn2.hoverBgColor = Rgb(20, 120, 40)
btn2.downBgColor = Rgb(255, 128, 0)
btn2.iconColor = Rgb(200, 255, 200)

' A disabled button in the top-right
' Dim btn3 As SettingsButton = SettingsButton(SCR_W - 80, 20, 60)
' btn3.Disable() ' This button will not be interactive

' --- Main Loop ---
' Dim As String message = "Click a button..."

' Do
'     ' --- Update Logic ---
'     If btn1.Update Then
'         message = "Top-left button clicked!"
'     End If

'     If btn2.Update Then
'         message = "Center button clicked!"
'     End If
    
'     ' btn3.Update() will always return false because it's disabled,
'     ' so we don't need to check it.

'     ' --- Drawing ---
'     ScreenLock
'     Cls
    
'     ' Draw some text
'     Draw String (20, 100), "Settings Button Class Demo"
'     Draw String (20, 120), "Press ESC to exit"
'     Draw String ( (SCR_W - Len(message) * 8) / 2, SCR_H - 40 ), message

'     ' Draw all the buttons
'     ' btn1.Draw()
'     ' btn2.Draw()
'     ' btn3.Draw()
    
'     ScreenUnlock

'     ' A small delay to prevent 100% CPU usage
'     Sleep 10, 1

' Loop Until MultiKey(&h01) ' Exit when ESC key is pressed

' End
' ```