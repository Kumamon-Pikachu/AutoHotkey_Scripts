#Persistent
#SingleInstance,force
Menu, Tray, NoStandard
ProgramName:="IVSOUL@AHK Scripts"
Menu,Tray,Tip,%ProgramName% ;Show Tips When Cursor Hovering on Trayicon.
return

~Pause::
var := !var
if var
{
	WinMinimizeAll ;Minimize All Windows.
	Keywait Pause
	blockinput on
	WinHide, ahk_class Shell_TrayWnd ;Hide Task Bar.
	ControlSend, SysListView321, +{F10}VD, Program Manager ahk_class Progman
}

else
{
	WinMinimizeAllUndo
	WinShow, ahk_class Shell_TrayWnd
	ControlSend, SysListView321, +{F10}VD, Program Manager ahk_class Progman
	blockinput off
}
return

~LButton & Enter::
ExitApp
return