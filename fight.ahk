UniqueID := WinExist("Melvor Idle")
if not UniqueID {
    OutputDebug, "Melvor Idlex not found"
    return
}

; WinActivate, ahk_id %UniqueID%

KeepRunning := true
FormatTime, CurrentDateTime,, HH:mm:ss
OutputDebug, [%CurrentDateTime%] running

LifeValue := 520
FoodValue := 70
LifeMinX := 1619
LifeMaxX := 1780
LifeRatio := (LifeValue - FoodValue * 2) / LifeValue
If LifeRatio < 0.5 {
    LifeRatio := 0.5
}
LifeTargetX := Floor(LifeMinX + (LifeRatio * (LifeMaxX-LifeMinX)))

OutputDebug, LifeRatio = %LifeRatio%

While (KeepRunning) {
    WinActivate, ahk_id %UniqueID%
    PixelSearch, Px, Py,LifeMinX, 1011, LifeTargetX, 1012, 0x5c6ad2, 2, Fast
    FormatTime, CurrentDateTime,, HH:mm:ss
    if ErrorLevel {
        ; OutputDebug, [%CurrentDateTime%] That color was not found in the specified region.
    }
    else {
        OutputDebug, [%CurrentDateTime%] A color was found at (%Px%, %Py%).
        Loop {
            WinActivate, ahk_id %UniqueID%
            PixelSearch, Px, Py, 1619, 1026, 1670, 1027, 0x52463E, 2, Fast
            if ErrorLevel {
                Sleep, 100
            }
            else {
                Break
            }
        }
        MouseGetPos, MouseX, MouseY
        MouseClick, Left, 1574, 1018
        MouseMove, MouseX, MouseY
        Continue
    }
    Sleep, 3000
}

FormatTime, CurrentDateTime,, HH:mm:ss
OutputDebug, [%CurrentDateTime%] Stopped
ExitApp

^!z::  ; Control+Alt+Z hotkey.
OutputDebug, "Z pressed"
KeepRunning := false
return
