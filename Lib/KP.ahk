;Run KP
KP()
{

;    msgbox start KP
    IfWinActive ahk_exe SciTE.exe
    {
;        msgbox Sciting
        send ``
        return
    }
    KpRunning := false
    KpRunning = Process, Exist, KeePass.exe
;    msgbox % KpRunning
    If KpRunning
        {
;            msgbox change shortcut on KP
            Send ^`` ; Win+Z is turned into Ctrl+` (set in Keepass)
        }
  return
}
