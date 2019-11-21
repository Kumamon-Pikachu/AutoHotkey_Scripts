/*
data ="Hello World!"
MsgBox %data%

data:=5+5
MsgBox %data%

case1 := data + 10
MsgBox %case1%
case2 := "This Text Will Be Followed By Number" . case1
MsgBox %case2%
case3 := "I have" . case1
MsgBox %case3%
*/
/*
IfEqual, var, value (等同于: if var = value)
IfNotEqual, var, value (等同于: if var <> value) (可以使用 != 代替 <>)
IfGreater, var, value (等同于: if var > value)
IfGreaterOrEqual, var, value (等同于: if var >= value)
IfLess, var, value (等同于: if var < value)
IfLessOrEqual, var, value (等同于: if var <= value)
If var ; 如果变量的内容为空或 0 时, 它被视为 false. 否则它被视为 true.
*/
/*
var := "tecst"
if var = test
	MsgBox var contains test
else if var =test
	MsgBox var contains test
else
	MsgBox var contains something else
*/
; and ----&&
; or---------- ||
; not---------- !
/*
var1 := 1
var2 := 0
var3 := 1
if ((var1) or (var2)) and (var3)
	MsgBox true
else
	MsgBox false
*/

/*
var = t
if var ;如果变量的内容为空或 0 时, 它被视为 false. 否则它被视为 true.
	MsgBox True
else
	MsgBox False
return
*/

/*
#c:: ;同一热键交替执行不同命令！
var := !var
if var
	MsgBox True
else
	MsgBox False
return
*/

/*
var := 5 ;变量在区间内为真
if var between 1 and 10
	MsgBox true
else
	MsgBox false
;--------------------------------------------------------------------------------------------------------
var := "test" ;字符串包含关系
list := "1,2,3,word,house,cat,g,x"
if var contains %list% ;包含其一则为真
	MsgBox true
else
	MsgBox false
*/
/*
Loop 5
{
	MsgBox % a_index ;每次执行增加1
	if a_index =2
		break
}
MsgBox done
;--------------------------------------------------------------------------------------------------------
var = 12|34|56|789
Loop, parse, var, | ;这是分割标志符，可自行设定，如果是，应写作 `,
{
	MsgBox % a_loopfield
}
;--------------------------------------------------------------------------------------------------------
loop, C:\Users\IVSOUL\Documents\Dictionary\*.*
	MsgBox % A_LoopFileLongPath
*/






































