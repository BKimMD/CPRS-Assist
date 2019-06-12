;1
UnskilledHH:
Gui, 11:Destroy
WinActivate, ahk_exe CPRSChart.exe

send ^t
WinWaitActive, ahk_class TfrmFrame ahk_exe CPRSChart.exe, Consults Page
ControlFocus, TORTreeView1, ahk_class TfrmFrame ahk_exe CPRSChart.exe, Consults Page
ControlSend,TORTreeView1,{home}

Loop{
	ControlFocus, TORTreeView1, A
	ControlGetText, ConsultTxt, TRichEdit1, A
	if InStr(ConsultTxt, "To Service:            COMMUNITY CARE-GEC UNSKILLED COMMUNITY HOME CARE")
		break
	ControlSend,TORTreeView1,{down}
	if A_Index > 15
	{
		MsgBox Unable to find recent COMMUNITY CARE-GEC SKILLED COMMUNITY HOME CARE order. Need to manually enter new one (script work in progress).
		return
	}
}
	ConsultTxt := RegExReplace(ConsultTxt, "s).*Reason For Request:|`r`n`r`n`r`n|Inter-facility Information.*")
;	msgbox % ConsultTxt
	CoordMode, Mouse, Screen
	MouseMove, 0, 0
	
	send {enter}
	WinWaitActive, Order Menu ahk_class TfrmOMNavA, Consult Orders...
	send {right}{down 3}{enter}
	WinWaitActive, Order Menu ahk_class TfrmOMNavA, COMMUNITY CARE CONSULT MENU
	send {down 77}{enter}
	WinWaitActive, Service Prerequisites - COMMUNITY CARE-GEC UNSKILLED COMMUNITY HOME CARE ahk_class TfrmPrerequisites
	Control, Check,, TButton3, A
	WinWaitActive, Template ahk_class TfrmTemplateDialog
	Control, Check,, TButton4, A
	WinWaitActive, Order a Consult ahk_class TfrmODCslt
	WinMaximize, Order a Consult ahk_class TfrmODCslt
	ControlSetText, TRichEdit1, %ConsultTxt%, Order a Consult ahk_class TfrmODCslt
	ControlSetText, TORDateBox1, T, Order a Consult ahk_class TfrmODCslt
	ControlSetText, TCaptionEdit1, Weakness (R53.1), Order a Consult ahk_class TfrmODCslt
	WinWaitActive, Order Menu ahk_class TfrmOMNavA, COMMUNITY CARE CONSULT MENU
	send {esc}^o
return