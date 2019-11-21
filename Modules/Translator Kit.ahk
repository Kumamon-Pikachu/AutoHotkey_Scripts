~LButton & RButton::
Send, ^c
ClipWait, 1
if WinExist("ahk_exe MDict.exe")
	Send, ^+!d ;此处为Mdict内置快捷键，可自行设定。
else
	Run, C:\Users\DATA\Documents\Dictionary\MDict.exe
return





