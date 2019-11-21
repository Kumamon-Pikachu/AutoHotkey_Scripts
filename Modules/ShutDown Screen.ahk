 #PrintScreen::   
 KeyWait PrintScreen   
 KeyWait LWin ;释放左Win键才激活下面的命令   
 SendMessage,0x112,0xF170,2,,Program Manager ;关闭显示器。0x112:WM_SYSCOMMAND，0xF170:SC_MONITORPOWER。2：关闭，-1：开启显示器   
 Return