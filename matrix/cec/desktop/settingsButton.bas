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
Using FB

' --- Constructor: Initializes a new button ---
Constructor SettingsButton (ByVal newX As Integer, ByVal newY As Integer, ByVal newSize As Integer)
    this.x = newX
    this.y = newY
    this.size = newSize
    this.radius = newSize / 2.0
    this.centerX = newX + this.radius
    this.centerY = newY + this.radius
End Constructor

' --- SetPosition: Moves the button to a new location ---
Sub SettingsButton.SetPosition(ByVal newX As Integer, ByVal newY As Integer)
    this.x = newX
    this.y = newY
    this.centerX = newX + this.radius
    this.centerY = newY + this.radius
End Sub

' --- Enable: Makes the button interactive ---
Sub SettingsButton.Enable()
    this.isDisabled = false
End Sub

' --- Disable: Makes the button non-interactive ---
Sub SettingsButton.Disable()
    this.isDisabled = true
    this.isHover = false
    this.isDown = false
End Sub

' --- Update: Handles mouse logic and returns TRUE if clicked ---
Function SettingsButton.Update() As Boolean
    If this.isDisabled Then Return false

    Dim As Integer mx, my, mb
    GetMouse(mx, my, , mb)

    Dim clicked As Boolean = false

    ' Check if mouse is within the button's circular area
    Dim distSq As Single = (mx - this.centerX)^2 + (my - this.centerY)^2
    If distSq < this.radius^2 Then
        this.isHover = true

        ' Check for mouse button down (press)
        If mb And 1 Then
            this.isDown = true
        Else
            ' Check for mouse button up (release)
            ' This is a click event only if the button was previously pressed
            If this.isDown Then
                clicked = true
            End If
            this.isDown = false
        End If
    Else
        this.isHover = false
        this.isDown = false
    End If

    Return clicked
End Function

' --- Draw: Renders the button to the screen ---
Sub SettingsButton.Draw()
    ' --- Determine current colors based on state ---
    Dim currentBgColor As UInteger
    Dim currentIconColor As UInteger

    If this.isDisabled Then
        currentBgColor = this.disabledBgColor
        currentIconColor = this.disabledIconColor
    ElseIf this.isDown Then
        currentBgColor = this.downBgColor
        currentIconColor = this.downIconColor
    ElseIf this.isHover Then
        currentBgColor = this.hoverBgColor
        currentIconColor = this.hoverIconColor
    Else
        currentBgColor = this.bgColor
        currentIconColor = this.iconColor
    End If

    ' --- Draw the button background (a filled circle) ---
    Circle (this.centerX, this.centerY), this.radius, currentBgColor, , , , F

    ' --- Draw the "gear" icon ---
    Const PI = 3.14159265
    Const NUM_TEETH = 8
    
    Dim toothLength As Single = this.size * 0.15
    Dim bodyRadius As Single = this.size * 0.5 - toothLength
    Dim holeRadius As Single = this.size * 0.18

    ' Draw gear body
    Circle (this.centerX, this.centerY), bodyRadius, currentIconColor, , , , F
    ' Punch a hole in the middle
    Circle (this.centerX, this.centerY), holeRadius, currentBgColor, , , , F
    
    ' Draw gear teeth
    For i As Integer = 0 To NUM_TEETH - 1
        Dim angle As Single = i * (360 / NUM_TEETH)
        Dim radAngle As Single = angle * PI / 180

        ' Calculate the 4 corners of a rotated rectangle for the tooth
        Dim toothWidthAngle As Single = 10 * PI / 180 ' Controls how wide the tooth is
        Dim cx = this.centerX
        Dim cy = this.centerY

        Dim x1 = cx + bodyRadius * Cos(radAngle - toothWidthAngle)
        Dim y1 = cy + bodyRadius * Sin(radAngle - toothWidthAngle)
        
        Dim x2 = cx + (bodyRadius + toothLength) * Cos(radAngle - toothWidthAngle)
        Dim y2 = cy + (bodyRadius + toothLength) * Sin(radAngle - toothWidthAngle)
        
        Dim x3 = cx + (bodyRadius + toothLength) * Cos(radAngle + toothWidthAngle)
        Dim y3 = cy + (bodyRadius + toothLength) * Sin(radAngle + toothWidthAngle)
        
        Dim x4 = cx + bodyRadius * Cos(radAngle + toothWidthAngle)
        Dim y4 = cy + bodyRadius * Sin(radAngle + toothWidthAngle)
        
        ' Draw the tooth as a filled polygon
        Line (x1, y1)-(x2, y2), currentIconColor
        Line (x2, y2)-(x3, y3), currentIconColor
        Line (x3, y3)-(x4, y4), currentIconColor
        Line (x4, y4)-(x1, y1), currentIconColor
        
        ' Find a point inside the tooth to start the fill
        Dim paintX = cx + (bodyRadius + toothLength/2) * Cos(radAngle)
        Dim paintY = cy + (bodyRadius + toothLength/2) * Sin(radAngle)
        Paint (paintX, paintY), currentIconColor, currentIconColor
    Next i

End Sub
