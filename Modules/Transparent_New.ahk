~LShift & WheelUp::
WinGet, Transparent, Transparent,A
If (Transparent="")
	Transparent=255
	Transparent_New:=Transparent+20 ;Speed
If (Transparent_New > 254)
	Transparent_New =255
	WinSet,Transparent,%Transparent_New%,A
	ToolTip, Transparent: %Transparent_New%
	SetTimer, RemoveToolTip, 1500
return

~LShift & WheelDown::
WinGet, Transparent, Transparent,A
If (Transparent="")
	Transparent=255
	Transparent_New:=Transparent-10 ;Speed
If (Transparent_New < 30)
	Transparent_New = 30
	WinSet,Transparent,%Transparent_New%,A
	ToolTip, Transparent: %Transparent_New%
	SetTimer, RemoveToolTip, 1500
return

~Lshift & Mbutton::  
WinGet, Transparent, Transparent,A
WinSet,Transparent,255,A  
ToolTip, Transparent Restored!
SetTimer, RemoveToolTip, 1500
return