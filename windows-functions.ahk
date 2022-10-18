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

;Find adobe premiere pro file in file explorer folder
findPremiereProFileImg(){
	ImageSearch, OutputVarX, OutputVarY, 0, 0, 410, 510, C:\mo-ahk\support-files\adobe-premiere-pro.png
	if (ErrorLevel == 0)
	{
		;Move Mouse to where the project was found
		MouseMove, OutputVarX+10, OutputVarY+10, 0
		;tippy("Cursor over Premiere Pro Project", 1) ;DEBUGGING
		;MsgBox, found image at x: %OutputVarX% and y: %OutputVarY% ;DEBUGGING
		;Open Premiere Pro project
		Sleep 50
		return 0
	}
	Else if (ErrorLevel == 1)
	{
		tippy("Unable to find image", 2)
		return 1
	}
	Else
	{
		tippy("Problem prevented search", 2)
		return 2
	}
}
