WinStatus:=0   
 RButton::   
     KeyWait, RButton    ;松开鼠标右键后才继续执行下面的代码   
     keyWait, RButton, D T0.15  ;在 100 毫秒内等待再次按下鼠标右键，可以设置一个自己觉得适合的等待时间。    

 If ErrorLevel   
         Click, Right   

     Else   
     {   
          if WinStatus=0   
 {   
      WinMaximize , A   
      WinStatus:=1   
 }   
 else   
 {   
      WinRestore ,A   
      WinStatus:=0   
 }   
     }   
 Return   
 !m::   
 if WinStatus=0   
 {   
      WinMaximize , A   
      WinStatus:=1   
 }   
 else   
 {   
      WinRestore ,A   
      WinStatus:=0   
 }   
 return    