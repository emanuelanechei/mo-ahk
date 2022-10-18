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

;----------------------------------------------------------------------
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
^+!g::
switchToChrome()
Sleep, 250
;Create new tab
SendInput, ^t
Sleep, 10
return

;OLD CODE - Allows input and pastes input into google search
; InputBox, searchQuery, Google Search, Enter your search., , 250git , 130
; Clipboard := searchQuery
; if (ErrorLevel == 1){
;     ;User pressed cancel
;     return
; }
; Else
; {
;     ;User submitted input
;     switchToChrome()
;     Sleep, 250
;     ;Create new tab
;     SendInput, ^t
;     Sleep, 10
;     SendInput, ^v
;     SendInput, {Enter}
;     return
; }

;INSTANT APPLICATION SWITCHER KEYS - End
;----------------------------------------------------------------------


;----------------------------------------------------------------------
;OPEN PROJECT AT CURSOR
^F2::
BlockInput, MouseMove ;Block mouse movement
CoordMode, Mouse, Relative
;Open "Main" project folder
Click, 2
;Wait for File Explorer Window to be active
WinWaitActive , ahk_class CabinetWClass, ,2
;Wait a little longer for File Explorer GUI to load for ImageSearch
Sleep, 200 
;tippy("Correct window is active", 2) ;DEBUGGING
;Search for "Project Files" folder
ImageSearch, OutputVarX, OutputVarY, 0, 0, 410, 510, *2 C:\mo-ahk\support-files\project-files-folder.png
if (ErrorLevel == 0)
{
    ;Move mouse to where the project file was found
    MouseMove, OutputVarX+10, OutputVarY+10, 0
    ;tippy("cursor over Project Files Folder", 2) ;DEBUGGING
    ;MsgBox, found image at x: %OutputVarX% and y: %OutputVarY% ;DEBUGGING
}
Else if (ErrorLevel == 1)
{
    tippy("Unable to find Project File Folder image", 2)
    BlockInput, MouseMoveOff ;Enable mouse movement
    return
}
Else
{
    tippy("Problem prevented Project File Folder search", 2)
    BlockInput, MouseMoveOff ;Enable mouse movement
    return
}
;tippy("Cursor over Project Files Folder", 1) ;DEBUGGING
;Open "Project Files" folder
Click, 2
Sleep, 100
;Search for Premiere Pro Project
if (findPremiereProFileImg() == 0)
{
    ;Open Premiere Pro Project
    Click, 2
}
BlockInput, MouseMoveOff ;Enable mouse movement
return
;----------------------------------------------------------------------


;----------------------------------------------------------------------
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
Click, 2
;Wait for File Explorer Window to be active
WinWaitActive , ahk_class CabinetWClass, ,2
;Wait a little longer for File Explorer GUI to load for ImageSearch
Sleep, 200 
;tippy("Correct window is active", 2) ;DEBUGGING
;Search for "Project Files" folder
ImageSearch, OutputVarX, OutputVarY, 0, 0, 410, 510, *2 C:\mo-ahk\support-files\project-files-folder.png
if (ErrorLevel == 0)
{
    ;Move mouse to where the project file was found
    MouseMove, OutputVarX+10, OutputVarY+10, 0
    ;tippy("cursor over Project Files Folder", 2) ;DEBUGGING
    ;MsgBox, found image at x: %OutputVarX% and y: %OutputVarY% ;DEBUGGING
}
Else if (ErrorLevel == 1)
{
    tippy("Unable to find Project File Folder image", 2)
    BlockInput, MouseMoveOff ;Enable mouse movement
    return
}
Else
{
    tippy("Problem prevented Project File Folder search", 2)
    BlockInput, MouseMoveOff ;Enable mouse movement
    return
}
;Open the "Projects folder"
Click, 2
;Wait for folder to open
Sleep, 100
;Search for Premiere Pro Project
if (findPremiereProFileImg() == 0)
{
    ;tippy("cursor over Premiere Pro Project file", 2) ;DEBUGGING
    ;Select, highlight, and rename Premiere Pro project
    SendInput {LButton}
    SendInput {F2}
    Sleep, 10
    SendInput ^v
    SendInput {Enter}
    ;Open Premiere Pro Project
    SendInput {Enter}
    
}
BlockInput, MouseMoveOff ;Enable mouse movement
Return
;----------------------------------------------------------------------


;----------------------------------------------------------------------
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
;----------------------------------------------------------------------