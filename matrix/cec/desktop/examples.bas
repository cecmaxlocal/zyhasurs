#include "SettingsButton.bas"

' --- Screen Setup ---
Const SCR_W = 800
Const SCR_H = 600
ScreenRes SCR_W, SCR_H, 32

' --- Create Button Instances ---

' A standard button in the top-left
Dim btn1 As SettingsButton = SettingsButton(20, 20, 60)

' A larger, customized button in the center
Dim btn2 As SettingsButton = SettingsButton( (SCR_W - 100) / 2, (SCR_H - 100) / 2, 100)
' Customize its colors
btn2.bgColor = Rgb(10, 80, 20)
btn2.hoverBgColor = Rgb(20, 120, 40)
btn2.downBgColor = Rgb(255, 128, 0)
btn2.iconColor = Rgb(200, 255, 200)

' A disabled button in the top-right
Dim btn3 As SettingsButton = SettingsButton(SCR_W - 80, 20, 60)
btn3.Disable() ' This button will not be interactive

' --- Main Loop ---
Dim As String message = "Click a button..."

Do
    ' --- Update Logic ---
    If btn1.Update() Then
        message = "Top-left button clicked!"
    End If

    If btn2.Update() Then
        message = "Center button clicked!"
    End If
    
    ' btn3.Update() will always return false because it's disabled,
    ' so we don't need to check it.

    ' --- Drawing ---
    ScreenLock
    Cls
    
    ' Draw some text
    Draw String (20, 100), "Settings Button Class Demo"
    Draw String (20, 120), "Press ESC to exit"
    Draw String ( (SCR_W - Len(message) * 8) / 2, SCR_H - 40 ), message

    ' Draw all the buttons
    btn1.Draw()
    btn2.Draw()
    btn3.Draw()
    
    ScreenUnlock

    ' A small delay to prevent 100% CPU usage
    Sleep 10, 1

Loop Until MultiKey(&h01) ' Exit when ESC key is pressed

End