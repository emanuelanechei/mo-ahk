#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
#Include C:\mo-ahk\premiere-functions.ahk
#Include C:\mo-ahk\windows-functions.ahk
#Include C:\mo-ahk\general-functions.ahk

; Keys and corresponding symbols
;------------
;ctrl = ^
;shift = +
;alt = !
;win = #
;------------

;----------------------------------------------;
;                                              ;
;              Adobe Premire Pro               ;
;                                              ;
;----------------------------------------------;
#IfWinActive, ahk_exe Adobe Premiere Pro.exe

;SELECT CLIP AT PLAYHEAD AND RIPPLE DELETE
F1::
Send ^!s ;ctrl alt s -> [select clip at playhead]
sleep 1
Send ^!+d ;ctrl alt shift  s -> [ripple delete]
return

;F2::
;return

;F3::
;return

;CUT ALL UNLOCKED LAYERS AT CURSOR
;KNOWN FLAWS 
;   - Doesn't select caption tracks smh
F4::
;instant cut at cursor (UPON KEY RELEASE) -- super useful! even respects snapping!
;note to self, move this to premiere_functions already
;this is NOT suposed to stop the video playing when you use it, but now it does for some reason....
;keywait, F4
;tooltip, |
send, c ;[razor tool]
send, {shift down} ;makes the razor tool affect all (unlocked) tracks
keywait, F4 ;waits for the F4 to be released
;tooltip, was released
send, {lbutton} ;left mouse button - makes a CUT
send, {shift up} ;release shift
sleep 10
send, v ;[selection tool]
return

;F5::
;return

;F6::
;return

;F7::
;return

;F8::
;return

;DELETE SINGLE CLIP AT CURSOR
F9::
prFocus("timeline") ;This will bring focus to the timeline
send, ^+a ;ctrl shift a -> [deselect all]
send, v ;[selection tool]
send, {alt down}
send, {lbutton}
send, {alt up}
send, {Delete} ;[clear]
return

;F10::
;return

;F11::
;return

;SEARCH EFFECTS PANEL
F12::
send, ^!+7 ;[focus on effect panel]
sendinput, ^b ;[select find box]
return


;----------------------------------------------;
;                                              ;
;                 Windows                      ;
;                                              ;
;----------------------------------------------;


;INSTANT APPLICATION SWITCHER KEYS - Start
#IfWinActive
;ctrl numpad1 -> Mapped to mouse
^Numpad1::switchToPremiere()
;ctrl numpad2 -> Mapped to mouse
^Numpad2::switchToFileExplorer()
;ctrl numpad3 -> Mapped to mouse
;^Numpad3::switchToChrome()
;ctrl numpad4 -> Mapped to mouse
^Numpad4::switchToAsana()
;ctrl numpad5 -> Mapped to mouse
^Numpad5::switchToSlack()

;INSTANT GOOGLE SEARCH
^+F12::
InputBox, searchQuery, Google Search, Enter your search., , 250, 130
Clipboard := searchQuery
if (ErrorLevel == 1){
    ;User pressed cancel
    return
}
Else
{
    ;User submitted input
    switchToChrome()
    Sleep, 250
    ;Create new tab
    SendInput, ^t
    Sleep, 10
    SendInput, ^v
    SendInput, {Enter}
    return

}



;Go to text location
;paste text
;press enter

;INSTANT APPLICATION SWITCHER KEYS - End

;OPEN PROJECT AT CURSOR
^F2::
CoordMode, Mouse, Relative
;Open "Main" project folder
SendInput {LButton}
SendInput {LButton}
;Wait for window to open
;Keeping this high allows time for window to open as to not click on an laready open window of explorer
Sleep, 250
;Move Mouse to location of "Project Files" folder
MouseMove, 200, 305, 0
;tippy("cursor over Project Files Folder", 1) ;DEBUGGING
;Open "Project Files" folder
SendInput {LButton}
SendInput {LButton}
Sleep, 30
;Move Mouse to location of Premiere Pro project
MouseMove, 200, 215, 0
Sleep 30
;tippy("cursor over Premiere Pro Project", 1) ;DEBUGGING
;Open Premiere Pro project
SendInput {LButton}
SendInput {LButton}
Return

;RENAME AND OPEN PREMIERE PROJECT
^+F2::
BlockInput, MouseMove ;Block mouse movement
CoordMode, Mouse, Relative
;Select "Main" project folder
SendInput {LButton}
;Highlight & copy the name of the "Main" project folder
SendInput {F2}
SendInput ^c
Sleep, 10
;Open "Main" project folder
SendInput {LButton}
SendInput {LButton}
;Wait for window to open
;Keeping this high allows time for window to open as to not click on an laready open window of explorer
Sleep, 1200
;Move Mouse to location of "Project Files" folder
MouseMove, 200, 305, 0
;tippy("cursor over Project Files Folder", 2) ;DEBUGGING
Sleep, 100
;Open the "Projects folder"
SendInput {LButton}
SendInput {LButton}
;Move Mouse to location of Premiere Pro Project file
MouseMove, 200, 215, 0
Sleep, 50
;tippy("cursor over Premiere Pro Project file", 2) ;DEBUGGING
;Select, highlight, and rename Premiere Pro project
SendInput {LButton}
SendInput {F2}
Sleep, 10
SendInput ^v
SendInput {Enter}
;Open "Project Files" folder
SendInput {Enter}
BlockInput, MouseMoveOff ;Enable mouse movement
Return

;RENAME, OPEN, & IMPORT PREMIERE PROJECT
^+!F2::
BlockInput, MouseMove ;Block mouse movement
CoordMode, Mouse, Relative
;Select "Main" project folder
SendInput {LButton}
;Highlight & copy the name of the "Main" project folder
SendInput {F2}
SendInput ^c
Sleep, 10
;Open "Main" project folder
SendInput {LButton}
SendInput {LButton}
;Wait for window to open
;Keeping this high allows time for window to open as to not click on an laready open window of explorer
Sleep, 1200
;Move Mouse to location of "Project Files" folder
MouseMove, 200, 305, 0
;tippy("cursor over Project Files Folder", 2) ;DEBUGGING
Sleep, 100
;Open the "Projects folder"
SendInput {LButton}
SendInput {LButton}
;Move Mouse to location of Premiere Pro Project file
MouseMove, 200, 215, 0
Sleep, 50
;tippy("cursor over Premiere Pro Project file", 2) ;DEBUGGING
;Select, highlight, and rename Premiere Pro project
SendInput {LButton}
SendInput {F2}
Sleep, 10
SendInput ^v
SendInput {Enter}
;Open "Project Files" folder
SendInput {Enter}
;Wait 15s for Premiere Project to open
;Sleep, 15000
;Move Mouse to & select "Workspaces" icon
;MouseMove, 1810, 70, 0
;SendInput {LButton}
;Sleep, 10

;Move Mouse to & select "Vertical Video" Workspace
;MouseMove, 20, 465, 0
;SendInput {LButton}
;Sleep, 10

;tippy("Cursor over Workspaces icon", 2)
BlockInput, MouseMoveOff ;Enable mouse movement
Return