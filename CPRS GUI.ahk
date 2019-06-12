;CPRS Assist
;#Include U:\My Documents\BK Extensions\CPRS Asssist.ahk

#IfWinActive ahk_exe CPRSChart.exe ;CPRS 2.0
^`::
Width:=200
Gui, 11:Font, s10
Gui, 11:Add, Text,, Click or Type Letter in ( )
Gui, 11:Add, Button, w%Width% gSkilledHH, Copy HH (&S)killed
Gui, 11:Add, Button, w%Width% gUnskilledHH, Copy HH (&U)nskilled
Gui, 11:Add, Button, w%Width% gFollowupLetter, Followup (&L)etter with 1 wk labs
Gui, 11:Add, Button, w%Width% gConsults, (&C)onsults
Gui, 11:Add, Button, w%Width% gQuickMeds, Quick (&M)eds 
;Gui, 11:Add, Button, +Disabled w%Width% gLabsFuture, (&L)abs - Future
;Gui, 11:Add, Button, +Disabled %Width% gLabsToday, Labs - (&T)oday
;Gui, 11:Add, Button, +Disabled %Width% gSignerRN, Add Signer-RN
Gui, 11:Show, x70 y70, CPRS Assist Return
return

11GuiContextMenu:
11GuiEscape:
11GuiClose:
Gui, 11:Destroy
return
#IfWinActive