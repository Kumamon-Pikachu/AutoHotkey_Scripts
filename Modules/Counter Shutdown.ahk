;定时关机
:://sd::
InputBox UserInput, Counter, 输入计划关机的时间（分钟）:
Run cmd
WinWaitActive ahk_class ConsoleWindowClass
time := UserInput * 60
send #{Space} ;设置英文输入
Send shutdown{Space} -s{Space}-t{Space}%time%{Enter}exit{Enter}
return
 
;取消定时关机
:://stop::
Run cmd
WinWaitActive ahk_class ConsoleWindowClass
send #{Space} ;设置英文输入
Send shutdown{Space} -a{Space}{Enter}exit{Enter}
return
 
;立刻休眠
:://sleep::
Run cmd
WinWaitActive ahk_class ConsoleWindowClass
send #{Space} ;设置英文输入
Send shutdown{Space} -h{Enter}
return
 
;立刻关机
:://sdn:: 
Shutdown, 1
return