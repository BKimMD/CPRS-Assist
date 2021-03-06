;CPRS Assist
#MaxMem 256
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook       ;Installs Needed hook for hotstring/hotkeys
#UseHook                ;Enables Needed hook for hotstring/hotkeys (can also use $ in front of hotkey
#SingleInstance force	;Allows only one copy of this script to run-needed for reloading properly)

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode, 2	;A window's title can contain WinTitle anywhere inside it to be a match
/*
1: A window's title must start with the specified WinTitle to be a match.
2: A window's title can contain WinTitle anywhere inside it to be a match.
3: A window's title must exactly match WinTitle to be a match
*/

DetectHiddenText, Off	;To prevent detection of hidden text
;SetControlDelay, 50
SetKeyDelay,, 1   ;Sets the delay that will occur after each keystroke sent by Send and ControlSend. SetKeyDelay [, Delay, PressDuration, Play]
;#Warn	  				;Enable warnings to assist with detecting common errors.
;SetNumLockState, on     ;Sets numlock on
#Persistent             ;Keeps a script permanently running
#MaxHotkeysPerInterval 50

GroupAdd, SignGroup, ahk_class TfrmSignOrders
GroupAdd, SignGroup, ahk_class TfrmSignItem
GroupAdd, SignGroup, ahk_class TfrmReview
GroupAdd, SignGroup, ahk_class TfrmSignon

SetTimer, ClosePopup, 100
return

;#Include U:\My Documents\BK Extensions\Autoclose00.ahk

;#Include U:\My Documents\BK Extensions\Hotkey Help.ahk
#Include CPRS GUI.ahk

;#Include U:\My Documents\AutoHotkeyU64.ahk
#Include HH Unskilled.ahk
#Include HH Skilled.ahk

#Include Snomed Helper.ahk
#Include Diagnosis Helper.ahk
#Include AHK Maintenance.ahk

If FileExist("U:\My Documents\BK Extensions\BK.ahk") {
	#Include *i U:\My Documents\BK Extensions\BK.ahk
}
else if FileExist("U:\My Documents\ShortcutsKeys.ahk") {
	#Include *i U:\My Documents\ShortcutsKeys.ahk
}
else {
	NewAHKShortcutsKeys =
(
zadd::
"("
1700 N Wheeling St 
Aurora, CO 80045
")"
zph::(303) 399-8020
)
FileAppend , NewAHKShortcutsKeys, "U:\My Documents\ShortcutsKeys.ahk"	
}
	

;If FileExist("U:\My Documents\BK Extensions\HH test.ahk")
;	#Include U:\My Documents\BK Extensions\HH test.ahk

;---------------------------------------------------------Comment out before compiling  
/*
#Include U:\My Documents\BK Extensions\HH test.ahk
#Include U:\My Documents\BK Extensions\BK.ahk

;-------------------------------------------------------------------- 
*/

;CPRS Global hotkeys--------------------------------------------------------
#IfWinActive ahk_exe CPRSChart.exe ;CPRS 2.0

^!F:: ;Followup Letter with labs/radio (on Notes Page)
	FollowupLetter:
	Gui, 11:Destroy
	
	Results := "I am writing to inform you of the results of the tests you had done recently.  The tests below were done and are satisfactory unless otherwise noted. `n`nIf you have any further questions or problems, please contact our nursing staff or me at the phone number at the top of this letter.`n"GetLabs()GetRadio()
	
	LetterWriter(Results)
return

$F5:: ;Ignore $, Refresh
If WinActive("VistA")
  {
	send {alt}fi
   } 
   else 
   {
    send {f5}
   }
return

$`::	;Key is below Esc, left of 1 key. Sign Off Prompt
	SignCPRSNote: ;LABEL
	DetectHiddenText, Off
;	msgbox start

	if WinActive("ahk_group SignGroup")
	{
;		msgbox go directly to kp
		KP()
		return
	}
	else if CPRSPage("frmNotes") or CPRSPage("Consults Page") or CPRSPage("Discharge Summary Page")
	{
;		msgbox 1st sign
		send  +^G
	}
	else if CPRSPage("Orders Page")
	{
;		msgbox 2nd sign
		send !AG
	}
	else
	{
;		msgbox % WinActive("Sign-on ahk_class TfrmSignon")
		Send !FN
		return
	}
	
	WinWaitActive, ahk_group SignGroup,,5
;	   msgbox Erorr is %ErrorLevel%
	if not ErrorLevel
	{
;		msgbox calling KP
		KP()
		return
;	msgbox finished
	}
return ; ` Sign Off

#IfWinActive, Patient Selection ahk_class TfrmPtSel ahk_exe CPRSChart.exe ;PATIENT SELECTION PAGE
/*
~LButton::
MouseGetPos,,, OutputVarWin, OutputVarCtl
ControlGetText, TextVar2 , %OutputVarCtl%, ahk_id %OutputVarWin%
Msgbox, The window says, "%TextVar2%" OUTPUTVARWIN %OutputVarWin%, OUPUTVARCTRL %OutputVarCtl%
WinGetText, WINVAR
MSGBOX % WINVAR

;If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < DllCall("GetDoubleClickTime"))
;	SetTimer detect_doubleclicked_object, -100
return


*/
;-------------------------------------------------------------------------
#If WinActive("VistA CPRS in use") and CPRSPage("Orders Page") ;ORDERS PAGE
;#IfWinActive ahk_group OrdersPage 

insert:: ;Copy to new order (on Orders Page)
	send !an ;COPY ORDERS
	WinWaitActive, ahk_class TfrmCopyOrders
	send {enter}
return

$delete::send !ad{enter}!FI ;Delete Order (on Orders Page)

^!c:: ;Med/surg consults (on Orders Page)
	Consults:
	Gui, 11:Destroy
	WinActivate, ahk_exe CPRSChart.exe

	CoordMode, Mouse, Screen
	MouseMove, 0, 0
	send ^t{enter}^o
	WinWaitActive, Order Menu ahk_class TfrmOMNavA,, 5
	send {right}{down 34}{enter}^#{up}

return

^!q:: ;Quick Meds - Go back one for vaccinations (on Orders Page)
	QuickMeds:
	Gui, 11:Destroy
	WinActivate, ahk_exe CPRSChart.exe

	CoordMode, Mouse, Screen
	MouseMove, 0, 0
	send ^o
	ControlSend, TORListBox1, O, A
	WinWaitActive, Order Menu ahk_class TfrmOMNavA,, 5
	send {down}{enter}^#{up}
;	WinWaitActive, 
;	ControlFocus, TORListBox1, A

;	
return

LabsFuture:
LabsToday:
/*
^!m::
	send ^t{enter}^o
;	MouseCursor(-1)
	winwaitactive, Order Menu ahk_class TfrmOMNavA

;	send 

return
*/
;-------------------------------------------------------------------------
#If WinActive("VistA CPRS in use") and CPRSPage("Medications Page") ;MEDS PAGE
;WinGetActiveTitle, ActiveWinTitle WinActive ahk_group MedsPage 

insert:: ;Copy to new order (on Medications Page)
	send !ap ;COPY ORDERS
	WinWaitActive, ahk_class TfrmMedCopy,, 5 ;Copy Medication Orders
		send {enter}
	WinWaitActive, ahk_class TfrmOMVerify,, 5
		send {enter}
return

$delete::send {alt}ad{enter}!FI ;Delete Order (on Medications Page)

^1:: ;Refills 1  times
^2:: ;Refills 2  times
^3:: ;Refills 3  times
^4:: ;Refills 4  times
^5:: ;Refills 5  times
^9:: ;Refills 11 times
^0:: ;Refills 0  times (on Medications Page)
	RefillNo:=Substr(A_ThisHotkey,2,1)
	If RefillNo = 9
		RefillNo := 11
	Send !AW
	IfWinExist, Unable to Renew Order ahk_class #32770
		return
	WinWaitActive, ahk_class TfrmRenewOrders,,2
	if ErrorLevel
		return
	Send, {right}{tab}{enter}
	WinWaitActive, ahk_class TfrmRenewOutMed,
	send, %RefillNo%{enter}
	WinWaitActive, ahk_class TfrmRenewOrders
	send {tab}{enter}
	

Return

;-------------------------------------------------------------------------
#If WinActive("VistA CPRS in use") and CPRSPage("frmNotes") ;NOTES PAGE
;#IfWinActive ahk_exe CPRSChart.exe, frmNotes ;NOTES PAGE

<+`:: ;Sign note, then add RN as signer
	goto SignCPRSNote
	AddSig("Alfred,S")
return

^F::send !VX ;Search text (on Notes Page)

^delete::send +^d ;Delete Note

#c:: ;Sign, then create "Completed." addenum and sign  (on Notes Page)
send ``
send nn{Enter}
send Completed.{Enter}
send ``
return

#v:: ;Default note view  (on Notes Page)
send !vf
return

^!p:: ;Goto 1st Primary care note WIP
	ControlGetText, FrameControl, TORTreeView1, ahk_class TfrmFrame ahk_exe CPRSChart.exe, frmNotes
	If(%FrameControl% == Templates)
		FrameControl := "TORTreeView2"
	else
		FrameControl := "TORTreeView1"
	
	ControlFocus, %FrameControl%, A
	ControlSend,  %FrameControl%, p, A

	Loop{
		ControlGetText, NoteTitle, TRichEdit2, ahk_class TfrmFrame ahk_exe CPRSChart.exe, frmNotes
		FirstLetter := SubStr(NoteTitle, InStr(NoteTitle, "LOCAL TITLE: ")+StrLen("LOCAL TITLE: "),1)
;		msgbox first letter %FirstLetter%
		if InStr(NoteTitle, "PRIMARY CARE PROVIDER NOTE", 1) || (A_Index >10) || (FirstLetter > "P")
			break
		else
			ControlSend,  %FrameControl%, {down}, ahk_class TfrmFrame ahk_exe CPRSChart.exe, frmNotes
	}
return

^!n:: ;Creates first templated note  (on Notes Page)
	Control, check,, TBitBtn3, ahk_class TfrmFrame ahk_exe CPRSChart.exe, frmNotes
	ControlFocus, TORTreeView1, A
	ControlSend,  TORTreeView1, {pgup}{left 2}{Right}{Down}{enter}, A
	WinWaitActive, Progress Note Properties ahk_class TfrmNoteProperties,,10
	Control, check,, TButton2, A
return
/*
SignerRN:
return
*/

;ADD SIGNATORY FUNCTION
AddSig(SignerName)
{
send {alt}ai%SignerName%{enter}{tab 3}{enter}
}

;::sShe::
;AddSig("Alfred,S")
;return

;::sGab::
;AddSig("Sloan,Gab")
;return


::eli::
AddSig("Seidenstricker")
return

::raf::
AddSig("Pineda,Raf")
return

::cyn::
AddSig("Cortez,cy")
return

::lin::
AddSig("Evans,Lin")
return

::lau::
AddSig("Gomez,Laur")
return

::cor::
AddSig("Caballero,Cora")
return

::nes::
AddSig("Anamuro,Nest")
return

::jen::
AddSig("PATUSZYNSKI,Jenn")
return

::len::
AddSig("te,lena")
return

::kimg::
AddSig("Gowdy,Kim")
return

::arel::
AddSig("Lumanlan,A")
return

::arn::
AddSig("FERRER,ARNEIL")
return

::kimh::
AddSig("HUBBARD,KIMBERLY")
return



::~~::
AddSig("")
return
*/

#If
;-------------------------------------------------------------------------

ClosePopup:	;Runs In Background
;Critical
/*
GroupAdd, BadGroup, ahk_class TfrmSignOrders
GroupAdd, BadGroup, ahk_class TfrmSignItem   
GroupAdd, BadGroup, Missing Encounter Information ahk_class #32770
*/


/*
	NoBreakOnTheseCursors=AppStarting, Wait
	Loop 
	{

		If Not InStr(NoBreakOnTheseCursors, A_Cursor)
			Break
;		msgbox %NoBreakOnTheseCursors% and %A_Cursor%>
		Sleep, 250
	}
*/

	IfWinActive, Lookup Other Diagnosis ahk_class TfrmPCELex ahk_exe CPRSChart.exe
		SnomedProcess(LongReversedICD)

	IfWinExist, Location for Current Activities ahk_class TfrmEncounter ahk_exe CPRSChart.exe, Encounter Location, Provider ;CLOSES LOCATION AND FILLS IN 00
	{
		WinActivate
		send +{tab}{right 2}{tab}
		send 00{enter}
		WinWaitClose
	}
	
	IfWinExist, Order Checking ahk_class TfrmOCAccept ahk_exe CPRSChart.exe, Drug Interaction Monograph ;CLOSES NALOXONE/OPIATE DUPLICATE NOTICE
	{
		WinActivate, Order Checking ahk_class TfrmOCAccept ahk_exe CPRSChart.exe, Drug Interaction Monograph
		ControlGetText, OrderCheckMsg, TRichEdit1
		DeleteNonVAMedCheck:=""
		if InStr(OrderCheckMsg, "Duplicate opioid medications:  [1] NALOXONE RESCUE")
			control, check,, TButton3, Order Checking ahk_class TfrmOCAccept ahk_exe CPRSChart.exe, Drug Interaction Monograph

		if InStr(OrderCheckMsg, "Order Checks could not be done for Drug: NO NON-VA MEDS REPORTED, please complete a manual check for Drug Interactions and Duplicate Therapy.")
			control, check,, TButton3, Order Checking ahk_class TfrmOCAccept ahk_exe CPRSChart.exe, Drug Interaction Monograph

		WinWaitClose, Order Checking ahk_class TfrmOCAccept ahk_exe CPRSChart.exe, Drug Interaction Monograph
	}

	while (A_Cursor = AppStarting) or (A_Cursor = Wait)
	sleep 500


;	goto BKRepeatJobs
	
	/*
	If WinActive("Order Menu ahk_class TfrmOMNavA ahk_pid 48572") 
		{
		WinGet, WinMaxed, MinMax , Order Menu ahk_class TfrmOMNavA ahk_pid 48572
		If !(WinMaxed)
			WinMaximize, Order Menu ahk_class TfrmOMNavA ahk_pid 48572
		}
		*/
return