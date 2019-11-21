;###################################################################################################################//
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#NoEnv
#Persistent
;#NoTrayIcon
#SingleInstance, Force
Menu, Tray, NoStandard ;Hide Default Menu.
ProgramName:="IVSOUL@AHK Scripts"
Menu,Tray,Tip,%ProgramName% ;Show Tips When Cursor Hovering on Trayicon.
NOW = %A_YYYY%年%A_MM%月%A_DD%日 %A_Hour%:%A_Min%:%A_Sec% %A_DDDD%
Traytip,IVSOUL@WARNING,%NOW%`nQuickShortcuts Starts Now！
SetTimer, RemoveTrayTip, 2000
ShowTip = QuickShortcuts Starts Now！
gosub, ShowTip
return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;###################################################################################################################//
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TB_HIDEBUTTON(wParam, lParam, Msg, HWND)
{
	static WM_USER := 0x400
	static _______ := OnMessage(WM_USER + 4, "TB_HIDEBUTTON")
	
	If (lParam = 513) ;LButton Click On Trayicon.
	{
		suspend
		SoundBeep, 500, 500
	}
	If (lParam = 519) ;MButton Click On Trayicon.
	{
		Edit
		Traytip,IVSOUL@WARNING,AHK Script Edit Mode！
		SetTimer, RemoveTrayTip, 1300
		SoundBeep, 500, 500
		return
	}
}
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
~RShift & LButton::
Reload ;Reload the script by Left Button and Right Shift.
SoundBeep, 500, 500
return

~LButton & Enter::
NOW = %A_YYYY%年%A_MM%月%A_DD%日 %A_Hour%:%A_Min%:%A_Sec% %A_DDDD%
Traytip,IVSOUL@WARNING,%NOW%`nAHK Script Will Now Exit！
SetTimer, RemoveTrayTip, 2000
SoundBeep, 500, 500
Gui, Tip:Destroy ;To Avoid Conflicts With Previous Gui Instance.
ShowTip = AHK Script Will Now Exit！
gosub, ShowTip
Sleep 1800
ExitApp
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
~PrintScreen::
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
	BlockInput OFF
	Gui, Clock:Destroy
	HideShowDesktopIcon()
	WinMinimizeAllUndo
	WinShow, ahk_class Shell_TrayWnd
	gosub, RestoreBothWinAltTabKey
	CoordMode, Mouse, Screen
	MouseMove, (A_ScreenWidth // 2), (A_ScreenHeight // 2), 7
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
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
~WheelUp::
MouseGetPos,, yPos,win
WinGetClass, class, ahk_id %win%
WinGet, winid, ID, ahk_class Shell_TrayWnd
if win = %winid%
	Send, {LWin Down}{Ctrl Down}{Left}{Ctrl Up}{LWin Up}
else if (yPos < 45 and InStr(class,"Chrome_WidgetWin"))
{
	IfWinNotActive ahk_id %win%
	WinActivate ahk_id %win%
	Send ^{PGUP}
}
return

~WheelDown::
MouseGetPos,, yPos,win
WinGetClass, class, ahk_id %win%
WinGet, winid, ID, ahk_class Shell_TrayWnd
if win = %winid%
	Send, {LWin Down}{Ctrl Down}{Right}{Ctrl Up}{LWin Up}
else if (yPos < 45 and InStr(class,"Chrome_WidgetWin"))
{
	IfWinNotActive ahk_id %win%
	WinActivate ahk_id %win%
	Send ^{PGDN}
}
return

~MButton::
MouseGetPos,, yPos,win
WinGet, winid, ID, ahk_class Shell_TrayWnd
if win = %winid%
	Send, {Volume_Mute}
return

~RButton::
MouseGetPos,, yPos,win
WinGetClass, class, ahk_id %win%
if (yPos < 45 and InStr(class,"Chrome_WidgetWin"))
	Send, {MButton}
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:*:,,Time:: ;Insert Current Date And Time.
CurrentDateTime = %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec% %A_DDDD%
SendInput %CurrentDateTime%
return

:*:,,tg:: ;Time Stamp.
TG = KEEPWISE_%A_YYYY%%A_MM%%A_DD%_%A_Hour%%A_Min%
SendInput %TG%
return

:*:,,tag:: ;Time Stamp.
TAG = %A_YYYY%%A_MM%%A_DD%%A_Hour%%A_Min%%A_Sec%
SendInput %TAG%
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
!N::
FileCreateDir, %A_Desktop%\NEW %A_Hour%%A_Min%
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* ~LCtrl:: ;Long Press RCtrl To Launch GodMode.
 * KeyWait LCtrl, T7 ; Interval In Seconds.
 * if ErrorLevel
 * 	Run shell:::{ED7BA470-8E54-465E-825C-99712043E01C}
 * return
 */

~RCtrl::
KeyWait RCtrl, T.7 ; Interval In Seconds.
if ErrorLevel
	Run Control
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*  F3:: ;Hold down the Hotkey to temporarily reduce the mouse cursor's speed, which facilitates precise positioning.
 *  SPI_GETMOUSESPEED = 0x70
 *  SPI_SETMOUSESPEED = 0x71
 *  ;Retrieve the current speed so that it can be restored later:
 *  DllCall("SystemParametersInfo", UInt, SPI_GETMOUSESPEED, UInt, 0, UIntP, OrigMouseSpeed, UInt, 0)
 *  ;Now set the mouse to the slower speed specified in the next-to-last parameter (the range is 1-20, 10 is default):
 *  DllCall("SystemParametersInfo", UInt, SPI_SETMOUSESPEED, UInt, 0, Ptr, 3, UInt, 0)
 *  KeyWait F3 ;This prevents keyboard auto-repeat from doing the DllCall repeatedly.
 *  return
 *  
 *  F3 up::DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, Ptr, OrigMouseSpeed, UInt, 0)  ;Restore the original speed.
 */
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:://PNB:: 
:://PortNumber::  ;Set Remote Desktop PortNumber, Take Effect When Reboot The System.
InputBox PortNumber, PortNumber, Enter Remote Desktop PortNumber(1024-65535):
if ErrorLevel <> 0
	TrayTip
else if PortNumber between 1024 and 65535
	gosub ChangePortNumber
else
	Traytip,IVSOUL@WARNING, Invalid Value！
return

ChangePortNumber:
RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp, PortNumber, %PortNumber%
RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp, PortNumber, %PortNumber%
Traytip,IVSOUL@WARNING, Reboot The System To Take Effect!`nPortNumber Changed Successfully!
Gui, Tip:Destroy ;To Avoid Conflicts With Previous Gui Instance.
ShowTip = PortNumber Changed Successfully!  Reboot The System To Take Effect!
gosub, Showtip
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
!V:: ;Paste Plain Text By Alt+V.
ClipboardBak:=ClipboardAll ;Store Full Version of Clipboard.
ClipBoard := ClipBoard ;Converts to Plain Text.
SendInput, ^v
Sleep, 50
Clipboard:=ClipboardBak
Traytip,IVSOUL@WARNING, Converts Clipboard to Plain Text And Paste！
SetTimer, RemoveTrayTip, 1300
Return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#PrintScreen:: ;Turn Off Monitor By pressing Win+PrintScreen..
KeyWait PrintScreen
KeyWait LWin
SendMessage,0x112,0xF170,2,,Program Manager
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:://cd::
:://countdown:: ;CountDown.
InputBox UserInput, CountDown, 请设定计划倒计时数值（分钟）：
IfEqual, Errorlevel, 0
{
	sleep UserInput * 60000
	Gui, Tip:Destroy ;To Avoid Conflicts With Previous Gui Instance.
	ShowTip = THE END OF THE COUNTDOWN!
	gosub, Showtip
}
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:://sd::
:://shutdown:: ;Count Down To Shutdown.
InputBox UserInput, Shutdown Counter, 输入计划关机剩余时间（分钟）:
if ErrorLevel <> 0
	TrayTip ;Nothing Happens Here.
else if UserInput !=
	gosub CountDownToShutDown
else
	Traytip,IVSOUL@WARNING, Invalid Value！
return

CountDownToShutDown:
Run cmd
WinWaitActive ahk_class ConsoleWindowClass
time := UserInput * 60
Send shutdown{Space} -s{Space}-t{Space}%time%{Enter}exit{Enter}
return

:://cancel::
Run cmd
WinWaitActive ahk_class ConsoleWindowClass
Send shutdown{Space} -a{Space}{Enter}exit{Enter}
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:://slp:: 
:://sleep:: ;Count Down To Sleep.
InputBox UserInput, Suspend State Counter, 输入计划休眠剩余时间（分钟）:
Time := UserInput * 60000
if ErrorLevel <> 0
	TrayTip ;Nothing Happens Here.
else if UserInput !=
{
	Traytip, IVSOUL@WARNING, Set Suspend State In %UserInput% Minites!
	Gui, Tip:Destroy ;To Avoid Conflicts With Previous Gui Instance.
	ShowTip = Set Suspend State In %UserInput% Minites!
	SetTimer, CountDownToSleep, %Time%
	gosub, Showtip
}
else
	Traytip,IVSOUL@WARNING, Invalid Value！
return

CountDownToSleep:
SetTimer, CountDownToSleep, Off
Run cmd
WinWaitActive ahk_class ConsoleWindowClass
Send shutdown{Space} -h{Enter}exit{Enter}
return

:://sdn:: ;Shutdown Now.
Shutdown, 1
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:*://ip::
Traytip,IVSOUL@WARNING, Internal IP Address: %A_IPAddress1%
Clipboard = \\%A_IPAddress1%
run, \\%A_IPAddress1%, UseErrorLevel
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
!G:: ;Search Clipboard By Google.
Send ^c
Run http://www.google.com/search?q=%Clipboard%
return

!B:: ;Search Clipboard By Baidu.
Send ^c
Run http://www.baidu.com/s?wd=%Clipboard%
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#N::
if WinExist("ahk_exe notepad.exe")
	WinActivate, ahk_exe notepad.exe
else
	Run, notepad.exe
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
F7::
SwitchSelCase("L") ;Switch Selected Text to Lower Case.
Traytip,IVSOUL@WARNING, Switch Selected Text to Lower Case！
SetTimer, RemoveTrayTip, 1300
return
F8::
SwitchSelCase("U") ;Switch Selected Text to Upper Case.
Traytip,IVSOUL@WARNING, Switch Selected Text to Upper Case！
SetTimer, RemoveTrayTip, 1300
return
F9::
SwitchSelCase("T") ; Switch First Letter to Upper Case.
Traytip,IVSOUL@WARNING, Switch First Letter to Upper Case！
SetTimer, RemoveTrayTip, 1300
return

SwitchSelCase(Mode)
{
	clipBak := ClipboardAll ; Backup Clipboard.
	Clipboard := "" ;Clear Clipboard.
  
	Send, ^c ;Copy Selected Text.
	ClipWait, 1
	selText := Clipboard
  
	if (selText != "")
	{
		Clipboard := ""
		Clipboard := Format("{:" Mode "}", selText)
		ClipWait, 1
		Send, ^v
		Sleep, 500
	}
	Clipboard := clipBak ;Restore Clipboard.
}
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Alt & 1:: ;Copy File Name.
Clipboard =
Send,^c
ClipWait
path = %Clipboard%
if path =
return

SplitPath, path, name
Clipboard = %name%
tooltip 已复制文件名至剪切板！`nFileName: "%clipboard%" Copied.
SetTimer, RemoveToolTip, 2000
Traytip,IVSOUL@WARNING, File Name has Copied To Clipboard！
SetTimer, RemoveTrayTip, 1300
return

Alt & 2:: ;Copy Folder Path.
Clipboard =
Send,^c
ClipWait
path = %Clipboard%
if path =
return

SplitPath, path, , dir
Clipboard = %dir%
tooltip 已复制文件夹路径至剪切板！`nFolderPath: "%clipboard%"Copied .
SetTimer, RemoveToolTip, 2000
Traytip,IVSOUL@WARNING, File Path Without Name has Copied To Clipboard！
SetTimer, RemoveTrayTip, 1300
return

Alt & 3:: ;Copy File Path and Name.
Clipboard =
Send,^c
ClipWait
path = %Clipboard%
if path =
return

Clipboard = %path%
tooltip 已复制文件路径至剪切板！`nFilePath: "%clipboard%" Copied.
SetTimer, RemoveToolTip, 2000
Traytip,IVSOUL@WARNING, Full File Path has Copied To Clipboard！
SetTimer, RemoveTrayTip, 1300
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
^H:: ;Show or Hide Hidden Files.
ID := WinExist("A")
WinGetClass,Class, ahk_id %ID%
WClasses := "CabinetWClass ExploreWClass"
IfInString, WClasses, %Class%
	GoSub, Toggle_HiddenFiles_Display
Return

^!H:: ;Show or Hide Super Hidden Files.
ID := WinExist("A")
WinGetClass,Class, ahk_id %ID%
WClasses := "CabinetWClass ExploreWClass"
IfInString, WClasses, %Class%
	GoSub, Toggle_SuperHiddenFiles_Display
Return

^!E:: ;Show or Hide File Extensions.
ID := WinExist("A")
WinGetClass,Class, ahk_id %ID%
WClasses := "CabinetWClass ExploreWClass"
IfInString, WClasses, %Class%
	GoSub, Toggle_FileExt_Display
Return

Toggle_HiddenFiles_Display:
RootKey = HKEY_CURRENT_USER
SubKey  = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced

RegRead, HiddenFiles_Status, % RootKey, % SubKey, Hidden
if HiddenFiles_Status = 2
	RegWrite, REG_DWORD, % RootKey, % SubKey, Hidden, 1
else
	RegWrite, REG_DWORD, % RootKey, % SubKey, Hidden, 2
	PostMessage, 0x111, 41504,,, ahk_id %ID%
Return

Toggle_SuperHiddenFiles_Display:
RootKey = HKEY_CURRENT_USER
SubKey  = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced

RegRead, SuperHiddenFiles_Status, % RootKey, % SubKey, ShowSuperHidden
if SuperHiddenFiles_Status = 0
	RegWrite, REG_DWORD, % RootKey, % SubKey, ShowSuperHidden, 1
else
	RegWrite, REG_DWORD, % RootKey, % SubKey, ShowSuperHidden, 0
	PostMessage, 0x111, 41504,,, ahk_id %ID%
Return

Toggle_FileExt_Display:
RootKey = HKEY_CURRENT_USER
SubKey  = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced

RegRead, FileExt_Status, % RootKey, % SubKey, HideFileExt
if FileExt_Status = 0
	RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 1
else
	RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 0
	PostMessage, 0x111, 41504,,, ahk_id %ID%
Return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:*:@1::
Send ivsoul@163.com
return

:*:@o::
Send ivsoul@outlook.com
return

:*:@e::
Send yangjian@evisionpr.com.cn
return

:*:,,gs::
:*:,,gongsi::
Send 北京时空视点整合营销顾问股份有限公司
return

:*:,,ev::
:*:,,evision::
Send EVISION Digital Marketing Group - Shanghai
return

:*:,,dz::
:*:,,dizhi::
Send 上海市闵行区顾戴路2337号丰树商业城A幢201室
return

:*:,,zhh::
:*:,,zhanghu::
Send 中国工商银行股份有限公司北京复兴门支行 0200 2501 0920 0103 856
return

:*:,,shh::
:*:,,shuihao::
Send 911102286883857291
return

:*:,,WiFi::
Send WiFi：EVISION/EVISION-5G，密码：2adc265220
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
ShowScreenClock:
ClockColor = EBE5D1
MotoColor = A9A9A9
LogoColor = A9A9A9
Background = 000000
top := A_ScreenHeight-300
Gui, Clock:-Border -Caption +AlwaysOnTop -SysMenu +ToolWindow
Gui, Clock:color, %Background%
Gui, Clock:margin, 0, %top%
Gui, Clock:font, s37 c%ClockColor%, Impact
Gui, Clock:add, text, center w%A_ScreenWidth% r1 vDisplayTime
Gui, Clock:margin, 0, 0
Gui, Clock:font, s28, Impact
Gui, Clock:add, text, center w%A_ScreenWidth% r1 vDisplayDate
Gui, Clock:margin, 0, 0
Gui, Clock:font, s28 c%MotoColor%, Impact
Gui, Clock:add, text, center w%A_ScreenWidth% r1 vDisplayMoto
Gui, Clock:margin, 0, 0
Gui, Clock:font, s21 c%LogoColor%, Impact
Gui, Clock:add, text, center w%A_ScreenWidth% r1 vDisplayLogo
Gui, Clock:show, w%A_ScreenWidth% h%A_ScreenHeight% X0 Y0
Gosub, CurrentTime
SetTimer, CurrentTime, 100
Return

CurrentTime:
FormatTime, EN_US_TIME, A_Now L0x0409, HH:mm:ss
FormatTime, EN_US_DATE, A_Now L0x0409, dddd, MMMM d, yyyy, gg
GuiControl, Clock:, DisplayTime, %EN_US_TIME%
GuiControl, Clock:, DisplayDate, %EN_US_DATE%
GuiControl, Clock:, DisplayMoto, Deadline Looms, Gotta Get Them All Done By Tonight
GuiControl, Clock:, DisplayLogo, -------//IVSOUL@AHK Scripts//-------
Return

DisableWinAltTabKey:
Hotkey, LAlt & Tab, Blank, On
Hotkey, RAlt & Tab, Blank, On
Hotkey, LWin & Tab, Blank, On
Hotkey, Alt & F4, Blank, On
Hotkey, RWin, Blank, On
Hotkey, LWin, Blank, On
Return			

RestoreBothWinAltTabKey:
Hotkey, LAlt & Tab, Blank, Off
Hotkey, RAlt & Tab, Blank, Off
Hotkey, LWin & Tab, Blank, Off
Hotkey, Alt & F4, Blank, Off
Hotkey, RWin, Blank, Off
Hotkey, LWin, Blank, Off
Return

Blank:
Return

RemoveTrayTip:
SetTimer, RemoveTrayTip, Off
TrayTip
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ShowTip:
TipTop := 3
TipHeight := 27
TipWidth := A_ScreenWidth-7
TipFontColor = 791039 ;A0A0A0
TipBackground = FFFFFF
TipAnimationTime := 27
TipHoverTime := 1300
TipTransparent := 247
Gui, Tip:-Border +AlwaysOnTop +ToolWindow -SysMenu +LastFound
Gui, Tip:color, %TipBackground%
Gui, Tip:margin, 0, %TipTop%
Gui, Tip:font, s13 c%TipFontColor%, Impact
Gui, Tip:add, text, center w%TipWidth% h%TipHeight% r1 vDisplayTip GuiMove
Gui, Tip:show, w%TipWidth% h%TipHeight% y-29
WinSet, Transparent, %TipTransparent%, ahk_class AutoHotkeyGUI
GuiControl, Tip:, DisplayTip, IVSOUL@WARNING : %ShowTip%
SetWinDelay, %TipAnimationTime%
WinMove, 0, -28
WinMove, 0, -21
WinMove, 0, -14
WinMove, 0, -7
WinMove, 0, 0
SetWinDelay, %TipHoverTime%
WinMove, 0, 0
SetWinDelay, %TipAnimationTime%
WinMove, 0, -7
WinMove, 0, -14
WinMove, 0, -21
WinMove, 0, -28
Gui, Tip:Destroy
Return

uiMove:
PostMessage, 0xA1, 2,,, A 
Return
;####################################################################################################################
;####################################################################################################################
;####################################################################################################################
;####################################################################################################################
:*://net::
NET := !NET
if NET
	gosub, ShowNetMeter
else
	Gui, Destroy
return

ShowNetMeter:
DnColor = 00768F
UpColor = FF4F49
UpRange = 0-197
DnRange = 0-72
ProgressWidth := 167
ProgressHeight := 9
ProgressColor = FFFFFF
NetPos := A_ScreenWidth-ProgressWidth*2-37
Gui, -Caption +Border +ToolWindow +LastFound -SysMenu ;+AlwaysOnTop
Gui, Color, EEAA99
WinSet, TransColor, EEAA99
Gui, Add, Progress, Background%ProgressColor% Range%UpRange% w%ProgressWidth% h%ProgressHeight% c%DnColor% -0x1 vDn
Gui, Add, Progress, Background%ProgressColor% Range%DnRange% x+10 w%ProgressWidth% h%ProgressHeight% c%UpColor% -0x1 vUp
Gui, Show, x%NetPos% y-21 , NetMeter
SetWinDelay, 37
WinMove,, -21
WinMove,, -14
WinMove,, -7
WinMove,, -2
WinMove,, 3

If GetIfTable(tb)
   Gui, Destroy

SetTimer, NetMeter, On, 100
Return

NetMeter:
dnNew := 0
upNew := 0

GetIfTable(tb)

Loop, % DecodeInteger(&tb)
{
/*  Include this codes to exclude the loopback interface.
	If DecodeInteger(&tb + 4 + 860 * (A_Index - 1) + 516) = 24
	   Continue
*/
	dnNew += DecodeInteger(&tb + 4 + 860 * (A_Index - 1) + 552) ;Total Incoming Octets
	upNew += DecodeInteger(&tb + 4 + 860 * (A_Index - 1) + 576) ;Total Outgoing Octets
}

dnRate := Round((dnNew - dnOld) / 1024)
upRate := Round((upNew - upOld) / 1024)

GuiControl,, Dn, %dnRate%
GuiControl,, Up, %upRate%

dnOld := dnNew
upOld := upNew
Return

GetIfTable(ByRef tb, bOrder = True)
{
	nSize := 4 + 860 * GetNumberOfInterfaces() + 8
	VarSetCapacity(tb, nSize)
	Return DllCall("iphlpapi\GetIfTable", "Uint", &tb, "UintP", nSize, "int", bOrder)
}

GetIfEntry(ByRef tb, idx)
{
   VarSetCapacity(tb, 860)
   DllCall("ntdll\RtlFillMemoryUlong", "Uint", &tb + 512, "Uint", 4, "Uint", idx)
   Return DllCall("iphlpapi\GetIfEntry", "Uint", &tb)
}

GetNumberOfInterfaces()
{
   DllCall("iphlpapi\GetNumberOfInterfaces", "UintP", nIf)
   Return nIf
}

DecodeInteger(ptr)
{
   Return *ptr | *++ptr << 8 | *++ptr << 16 | *++ptr << 24
}
;####################################################################################################################
;####################################################################################################################
;####################################################################################################################