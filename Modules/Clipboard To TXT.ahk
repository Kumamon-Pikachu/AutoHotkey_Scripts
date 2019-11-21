#F12::
clip:=clipboard
Folder=%A_desktop%
StringReplace, First, clip, `r`n, , All
StringLeft,First,First,20
FileAppend, %clip%, %Folder%/%First%.txt
First=
clip=
tooltip NEW TXT WAS CREATED TO DESKTOP
sleep 2000
tooltip
return