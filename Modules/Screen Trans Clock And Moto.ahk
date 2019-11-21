~Pause::
var := !var
if var
{
	BlockInput ON
	HideShowDesktopIcon()
	WinMinimizeAll ;Minimize All Windows.
	WinHide, ahk_class Shell_TrayWnd ;Hide Task Bar.
	gosub, DisableWinAltTabKey
	CoordMode, Mouse, Screen
	MouseMove, %A_ScreenWidth%, %A_ScreenHeight%, 11
	gosub, ShowScreenClock
	;SendMessage,0x112,0xF170,2,,Program Manager
}
else
{
	Gui, Destroy
	BlockInput OFF
	HideShowDesktopIcon()
	WinMinimizeAllUndo
	WinShow, ahk_class Shell_TrayWnd
	gosub, RestoreBothWinAltTabKey
	CoordMode, Mouse, Screen
	MouseMove, (A_ScreenWidth // 2), (A_ScreenHeight // 2), 17
	SetTimer, CurrentTime, Off
}
return

HideShowDesktopIcon()
{
	ControlGet, HWND, Hwnd,, SysListView321, ahk_class Progman
	If HWND =
		ControlGet, HWND, Hwnd,, SysListView321, ahk_class WorkerW
	If DllCall("IsWindowVisible", UInt, HWND)
		WinHide, ahk_id %HWND%
	Else
		WinShow, ahk_id %HWND%
	return
}

ShowScreenClock:
top = 560
ClockColor = F0F0F0
MotoColor = F0F0F0
Gui, -Border -Caption +AlwaysOnTop +ToolWindow +LastFound
Gui, Color, F1F0F0
WinSet, TransColor, F1F0F0
Gui, margin, 0, %top%
Gui, font, s37 c%ClockColor%, Segoe UI Black
Gui, add, text, center w%A_ScreenWidth% r1 vDisplayTime
Gui, margin, 0, 0
Gui, font, s28, Segoe UI Black
Gui, add, text, center w%A_ScreenWidth% r1 vDisplayDate
Gui, margin, 0, 0
Gui, font, s28 c%MotoColor%, Impact
Gui, add, text, center w%A_ScreenWidth% r2 vDisplayMoto
Gui, show, w%A_ScreenWidth% h%A_ScreenHeight% X0 Y0
Gosub, CurrentTime
SetTimer, CurrentTime, 1000
Return

CurrentTime:
FormatTime,EN_US_DATE, A_Now L0x0409, dddd, MMM d, yyyy
GuiControl,, DisplayTime, %A_Hour%:%A_Min%:%A_Sec%
GuiControl,, DisplayDate, %EN_US_DATE%
GuiControl,, DisplayMoto, Deadline Looms, Gotta Get Them All Dead By Tonight`nIVSOUL@AHK Scripts
Return

DisableWinAltTabKey:
Hotkey, LAlt & Tab, Blank, On
Hotkey, RAlt & Tab, Blank, On
Hotkey, LWin & Tab, Blank, On
Hotkey, LWin, Blank, On
Hotkey, RWin, Blank, On
Return			

RestoreBothWinAltTabKey:
Hotkey, LAlt & Tab, Blank, Off
Hotkey, RAlt & Tab, Blank, Off
Hotkey, LWin & Tab, Blank, Off
Hotkey, LWin, Blank, Off
Hotkey, RWin, Blank, Off
Return

Blank:
Return