#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

;INSTANT APPLICATION SWITCHER FUNCTIONS - START
switchToPremiere() {
	IfWinNotExist, ahk_class Premiere Pro 
		{
		;Run, Adobe Premiere Pro.exe
		;Adobe Premiere Pro CC 2017
		; Run, C:\Program Files\Adobe\Adobe Premiere Pro CC 2017\Adobe Premiere Pro.exe ;if you have more than one version instlaled, you'll have to specify exactly which one you want to open.
		Run, Adobe Premiere Pro.exe
		}
	if WinActive("ahk_class Premiere Pro")
		Goto, eof ;jump to end of function (eof)
	else
		WinActivate ahk_class Premiere Pro

	;end of function jump label    
	eof:
	return
}

switchToChrome() {
	IfWinNotExist, ahk_exe chrome.exe
		Run, chrome.exe
	if WinActive("ahk_exe chrome.exe")
		Sendinput ^{tab}
	else WinActivate ahk_exe chrome.exe
	return
}

switchToFileExplorer() {
	IfWinNotExist, ahk_class CabinetWClass
		Run, explorer.exe
	GroupAdd, taranexplorers, ahk_class CabinetWClass
	if WinActive("ahk_exe explorer.exe")
		GroupActivate, taranexplorers, r
	else
		WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
}

switchToAsana() {
	IfWinNotExist, ahk_exe Asana.exe
		Run, Asana.exe, C:\Users\morga\AppData\Local\Asana
	if WinActive("ahk_exe Asana.exe")
		Sendinput ^{tab}
	else WinActivate ahk_exe Asana.exe
	return
}

switchToSlack() {
	IfWinNotExist, ahk_exe slack.exe
		Run, slack.exe, C:\Users\morga\AppData\Local\slack
	if WinActive("ahk_exe slack.exe")
		Sendinput ^{tab}
	else WinActivate ahk_exe slack.exe
	return
}
;INSTANT APPLICATION SWITCHER FUNCTIONS - END

;KNOWN FLAWS
;	- Hasn't been tested with something other than _contentsOfClipboard
;TODO
waitForWinToOpen(ahkClass, nameOfWindow:="") {
	
	waitCounter = 0

	;MsgBox, The class is %ahkClass% and the name is %nameOfWindow% ;DEBUGGING

	 ;Check if nameOfWindow was given
	if (nameOfWindow == "")
	{
		;No nameOfWindow was given
		isNameOfWinGiven := false
		;MsgBox, nameOfWindow wasn't given
	}
	else if (nameOfWindow == "_contentsOfClipboard")
	{
	 	;Function call is requesting the contents of the clipboard as a nameOfWindow
	 	isNameOfWinGiven := true
		nameOfWindow = %Clipboard%
		;MsgBox, name is %nameOfWindow% ;DEBUGGING
	}
	else
	{
		isNameOfWinGiven = true
	}

	;Begin waiting for the window to open
	loop
	{
		;If we've waited 30ms * 50 = 1.5s --> break out the loop
		if (waitCounter > 50)
		{
			;retun 1 meaning error
			MsgBox, waitCounter is greater than 50
			return 1
		}

		Sleep, 10 ;Wait 30ms for the window to open

		; If nameOfWindow was NOT given
		if (isNameOfWinGiven)
		{
			;Check if window with the given class is active yet
			if WinActive(%ahkClass%)
			{
				Msgbox, Window by class is open.  Wait counter is %waitCounter%
				waitCounter++
				return 0
			}
		}
		; If nameOfWindow was given
		else
		{
			;Check if window with the name is active yet
			if WinActive(nameOfWindow)
			{
				Msgbox, Window by name is open. Wait counter is %waitCounter%
				waitCounter++
				return 0
			}
		}
	}
	MsgBox, You should never reach this code
	return 1 ;We should never get here
 }