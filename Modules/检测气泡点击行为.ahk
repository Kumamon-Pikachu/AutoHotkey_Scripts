TrayTip, AutoHotkey, Click Me, 10
Return

; 检测托盘气泡的点击
TB_HIDEBUTTON(wParam, lParam, msg, hwnd) {
	static WM_USER := 0x400
	static _______ := OnMessage(WM_USER + 4, "TB_HIDEBUTTON")
	
	If (lParam = 1029) ;点击托盘气泡通知
	{
		MsgBox TrayTip Click`, 点击气泡AutoHotkey will now exit
		ExitApp
	}
	If (lParam = 102/8) ;气泡时间到
	{
		MsgBox TrayTip Click`, 气泡时间到AutoHotkey will now exit
		ExitApp
	}
	If (lParam = 513) ;在托盘图标点击左键
	{
		MsgBox TrayTip Click`, 左键AutoHotkey will now exit
		ExitApp
	}
	If (lParam = 519) ;在托盘图标点击中键
	{
		MsgBox TrayTip Click`, 中键AutoHotkey will now exit
		ExitApp
	}
}


/*
Integer WM_LBUTTONDOWN = 513 // 在托盘图标点击左键
Integer WM_RBUTTONDOWN = 516 // 在托盘图标点击右键
Integer WM_MBUTTONDOWN = 519 // 在托盘图标点击中键
Integer NIN_BALLOONSHOW = 1026 //当 Balloon Tips 弹出
Integer NIN_BALLOONHIDE = 1027 //当 Balloon Tips 消失（如 SysTrayIcon 被删除），但指定的 TimeOut 时间到或鼠标点击 Balloon Tips 后的消失不发送此消息
Integer NIN_BALLOONTIMEOUT = 1028 // 当 Balloon Tips 的 TimeOut 时间到
Integer NIN_BALLOONUSERCLICK = 1029 //当鼠标点击 Balloon Tips
//注意:在XP下执行时 Balloon Tips 上有个关闭按钮, 
//如果鼠标点在按钮上将接收到 NIN_BALLOONTIMEOUT 消息。
*/