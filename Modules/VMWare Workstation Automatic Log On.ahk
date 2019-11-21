#NoEnv
#Persistent
#NoTrayIcon
#SingleInstance

#v::
if WinExist("ahk_exe vmware.exe")
{
	WinActivate, ahk_exe vmware.exe
	Send, ^b ;Start Up Guest Hotkey
	Sleep, 30000 ;Wait For Login Screen
	WinActivate, ahk_exe vmware.exe
	Send, ^g ;Grab Input Hotkey
	Sleep, 300
	SendInput, vmpw{Enter} ;PassWords
}
else
{
	Run, vmware.exe
	Sleep, 3000
	WinActivate, ahk_exe vmware.exe
	Send, ^b ;Start Up Guest Hotkey
	Sleep, 30000 ;Wait For Login Screen
	WinActivate, ahk_exe vmware.exe
	Send, ^g ;Grab Input Hotkey
	Sleep, 300
	SendInput, vmpw{Enter} ;PassWords
}
return
