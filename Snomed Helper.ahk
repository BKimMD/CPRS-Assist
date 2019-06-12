;Snomed Helper
#IfWinActive, Lookup Other Diagnosis ahk_class TfrmPCELex ahk_exe CPRSChart.exe

SnomedProcess(LongICD)
{
	WinTitle := "Lookup Other Diagnosis ahk_class TfrmPCELex ahk_exe CPRSChart.exe"

	If LongICD
	{
;		replacLongICD
		ControlSetText, TCaptionEdit1, %LongICD%, %WinTitle%
		Control, check,,TButton1, %WinTitle%
	}

	WinWaitClose, %WinTitle%
	return
}

#IfWinActive