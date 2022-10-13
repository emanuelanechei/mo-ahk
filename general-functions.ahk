#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

;Create a tool time with custom message and delay for custom duration in seconds
tippy(message, durationInSeconds) {
    millisecondsInOneSecond = 1000
    timeInMilliseconds := durationInSeconds * millisecondsInOneSecond
    ToolTip, %message%
    Sleep, timeInMilliseconds
    ToolTip,
    Return
}