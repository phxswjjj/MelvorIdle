AppTitle := "Melvor Idle"
UniqueID := WinExist(AppTitle)
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
LifeMinX := 301
LifeMaxX := 770
LifeRatio := (LifeValue - FoodValue * 2) / LifeValue
If (LifeRatio < 0.5) {
    LifeRatio := 0.5
}
LifeTargetX := Floor(LifeMinX + (LifeRatio * (LifeMaxX-LifeMinX)))

OutputDebug, LifeRatio = %LifeRatio%

While (KeepRunning) {
    IfWinNotActive, ahk_id %UniqueID%
    {
        Sleep, 100
        Continue
    }
    ; WinActivate, ahk_id %UniqueID%
    PixelSearch, Px, Py, LifeMinX, 325, LifeTargetX, 335, 0x5c6ad2, 2, Fast
    FormatTime, CurrentDateTime,, HH:mm:ss
    if ErrorLevel {
        ; OutputDebug, [%CurrentDateTime%] That color was not found in the specified region.
    }
    else {
        OutputDebug, [%CurrentDateTime%] A color was found at (%Px%, %Py%).

        MouseGetPos, MouseX, MouseY
        MouseClick, Left, 1012, 323
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
