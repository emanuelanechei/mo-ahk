#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
#Include C:\AHK\premiere-functions.ahk
#Include C:\AHK\windows-functions.ahk
#Include C:\AHK\general-functions.ahk

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
;              Windows                         ;
;                                              ;
;----------------------------------------------;


;INSTANT APPLICATION SWITCHER KEYS
#IfWinActive
;ctrl numpad1 -> Mapped to mouse
^Numpad1::switchToPremiere()
;ctrl numpad2 -> Mapped to mouse
^Numpad2::switchToFileExplorer()
;ctrl numpad3 -> Mapped to mouse
^Numpad3::switchToChrome()
;ctrl numpad4 -> Mapped to mouse
^Numpad4::switchToAsana()
;ctrl numpad5 -> Mapped to mouse
^Numpad5::switchToSlack()

^F2::
SendInput {LButton}
Sleep, 10
SendInput, {F2} ;highlight folder name
Send ^c ;copy project folder name
SendInput {LButton}
SendInput {LButton} ;double click to open “main” folder
;MsgBox, contents of clipboard is %Clipboard% ; DEBUG: Prints the correct message
waitForWinToOpen("CabinetWClass", "_contentsOfClipboard") ;Class of windows file explorer window and name of specific window that'll be open
Return

; Send ^c ;copy project folder name
; SendInput {LButton}
; SendInput {LButton} ;double click to open “main” folder


; ;move mouse to project files - based on window location because window could be anywhere on screen
; SendInput {LButton}
; SendInput {LButton} ;double click to open “project files” folder
; ;Move mouse to premiere pro file 
; SendInput {LButton} ;select project file at mouse location
; Send F2 ;highlight project file name
; Send ^v ;paste project folder name
; return