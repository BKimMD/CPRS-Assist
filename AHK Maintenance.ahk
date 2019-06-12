#IfWinActive ahk_exe ahk_exe SciTE.exe
;2005-11-23
;Ctrl+S while in scite saves and auto-reloads the AHK script
;http://www.autohotkey.com/forum/viewtopic.php?t=135&highlight=auto+reload
$^s::
  Send, ^s
  SetTitleMatchMode, 2

  If WinActive(".ahk") or WinActive(".ini")
    { 
      PopUp("AHK","Updating script...")
      Reload
    } 
return 
#IfWinActive

^space:: ;Ctrl+Space Toggles AUTOHOTKEY FROM AUTOCORRECTING CTRL+SPACE, ~ before allows space to be shown
   Suspend, Toggle
Return