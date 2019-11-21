#SingleInstance ignore

top = 400
fontcolor = eeffff
background = #486860

Gui, -border -caption
Gui, color, %background%
Gui, margin, 0, %top%
Gui, font, s96 c%fontcolor%, Times
Gui, add, text, center w%A_ScreenWidth% r1 vdisplay
Gui, font, s48
Gui, margin, 0, 0
Gui, add, text, center w%A_ScreenWidth% r1 vdate
Gui, show, w%A_ScreenWidth% h%A_ScreenHeight% X0 Y0

Gosub, currentTime
SetTimer, currentTime, 1000
Return

currentTime:
GuiControl,, display, %A_Hour%:%A_Min%:%A_Sec%
GuiControl,, date, %A_YYYY%年%A_MM%月%A_DD%日 %A_DDDD%
Return

GuiEscape:
GuiClose:
#c::
ExitApp