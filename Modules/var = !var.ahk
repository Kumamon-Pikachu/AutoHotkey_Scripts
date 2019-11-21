x::
var := !var
if var
{
	WinMinimizeAll ;Minimize All Windows.
	WinHide, ahk_class Shell_TrayWnd ;Hide Task Bar.
}

else
{
	WinMinimizeAllUndo
	WinShow, ahk_class Shell_TrayWnd
}
return

