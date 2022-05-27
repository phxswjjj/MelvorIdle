AppTitle := "Melvor Idle"
UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug, "Melvor Idlex not found"
    return
}

TaskImages := []
TaskImages.Push("images\task1.jpg")
TaskImages.Push("images\task2.jpg")

TaskMatched(TaskImages) {
    For index, element in TaskImages {
        ImageSearch, FoundX, FoundY, 698, 816, 818, 937, *100 %element%
        If Not ErrorLevel {
            OutputDebug, %element% Found
            Return True
        }
    }
    Return False
}

KeepRunning := true
WinActivate, ahk_id %UniqueID%
MouseMove, 998, 795
Loop 10 {
    Click, WheelUp
}

While (KeepRunning) {
    IfWinNotActive, ahk_id %UniqueID%
    {
        Sleep, 100
        Continue
    }
    If TaskMatched(TaskImages) {
        OutputDebug, Task Matched
        Break
    }
    
    MouseClick, Left, 998, 795
    Sleep, 500
    MouseClick, Left, 868, 856
    Sleep, 2000
}

FormatTime, CurrentDateTime,, HH:mm:ss
OutputDebug, [%CurrentDateTime%] Stopped
ExitApp

^!z::  ; Control+Alt+Z hotkey.
OutputDebug, "Z pressed"
KeepRunning := false
return