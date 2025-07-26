' Of course! Here are the complete files for a `SettingsButton` class in FreeBASIC using the `fbgfx` library.

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
    Declare Constructor (ByVal newX As Integer, ByVal newY As Integer, ByVal newSize As Integer)
    Declare Sub Draw()
    Declare Function Update() As Boolean
    Declare Sub SetPosition(ByVal newX As Integer, ByVal newY As Integer)
    Declare Sub Enable()
    Declare Sub Disable()

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
