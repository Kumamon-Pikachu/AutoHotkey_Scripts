OnExit, ExitSub

#1::
gosub Enable
return

#2::
gosub Disable
return

Disable:
Regwrite, REG_SZ, HKEY_LOCAL_MACHINE,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe, Debugger, Hotkey Disabled
return

Enable:
RegDelete,HKEY_LOCAL_MACHINE,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe
return

ExitSub:
RegDelete,HKEY_LOCAL_MACHINE,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe
ExitApp
return