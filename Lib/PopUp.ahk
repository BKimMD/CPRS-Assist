PopUp(PopUpTitle,PopUpTxt) { ;Pop-up Infobox on bottom right
    TrayTip, %PopUpTitle%,%PopUpTxt% ;Warning: The popup will not be shown if the Txt parameter is omitted, even if a Title is specified.
	Sleep, 500
;    TrayTip
	SetTimer, HideTrayTip, -1
}

HideTrayTip() { ;Hides popup tray
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 300  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}