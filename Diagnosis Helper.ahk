;Diagnosis Helper

#IfWinActive, Lookup Diagnosis ahk_class TfrmPCELex ahk_exe CPRSChart.exe

$LButton::
MouseGetPos, x, y,,Ctrl
 If InStr(Ctrl,"TButton1") 
{
   ProcessICD()
}
else
{
   send, {LButton}
}
Return

$Enter::
   ProcessICD()
return

ProcessICD()
{
   global LongReversedICD = ""
   ControlGetText, EnteredString, TCaptionEdit1, %WinTitle%

;msgbox % EnteredString

;   msgbox % ICD10

   IcdSnippet:=GoogleSnippet(EnteredString)
;msgbox % IcdSnippet

If IcdSnippet
{
   ICD := IcdSnippet
;  RegExMatch(IcdSnippet, "[A-TV-Z][0-9][A-Z0-9](\.?[A-Z0-9]{0,4})?", ICD)

;   RegExMatch(IcdSnippet, "O)[A-TV-Z][0-9][A-Z0-9](\.?[A-Z0-9]{0,4})?", ICD10)
;GetIcdDef(IcdSnippet, IcdJson)
}
else
{
   ICD := EnteredString  
}

ControlSetText, TCaptionEdit1, %ICD%, %WinTitle%
;ControlClick, TButton1, ahk_class TfrmPCELex ahk_exe CPRSChart.exe
Control, check,,TButton1, %WinTitle%
ControlSend, TTreeView1, {UP}, %WinTitle%
LongReversedICD := ""
Loop
{
ControlGetText, LongReversedICD, TMemo1, %WinTitle%
If LongReversedICD or (A_Index > 1000)
   break
}

;msgbox % LongReversedICD
Return, LongReversedICD
;Msgbox % LongReversedICD
;Clipboard := LongReversedICD
;msgbox % ICD "," ICD1 ","
;msgbox % IcdSnippet
;msgbox % "Count="ICD10.Count()",Value="ICD10.Value(2)",Name="ICD10.Name(2)

;   clipboard := ICD10
;   run http://www.google.com/search?q=%ICD10%
}

SnipToIcdDef(Snippet, IcdTable)
{
   arr:=[],pos:=1
   While pos:=RegExMatch(Snippet,"[A-TV-Z][0-9][A-Z0-9](\.?[A-Z0-9]{0,4})?",m,StrLen(m)+pos)
   {
      IcdNoPeriod := StrReplace(m,".")
;      for i 
      arr.Insert(m, IcdTable.code[I214])
   }
   
   Msgbox % arr.MaxIndex()
   Msgbox % arr.1
}

GoogleSnippet(Phrase) 
{
;   msgbox % "Search Phrase=" phrase
   URL:="http://www.google.com/search?q="EncodeURL("ICD 10 "Phrase)
   URLDownloadToFile, % URL, %A_Temp%\GoogleSearch.html
;   run % URL
;	URLDownloadToFile, % "http://www.google.com/search?q=icd10+hypertension", C:\Users\X1\Desktop\ICD 10\GoogleSearch.txt

	FileRead, Result, %A_Temp%\GoogleSearch.html
;	FileRead, Result, C:\Users\X1\Desktop\ICD 10\GoogleSearch.txt

;   FileDelete, %A_Temp%\GoogleSearch
   
   RegExMatch(Result, "(?<=\W)(?<!\+|\/|-)[A-TV-Z][0-9][A-Z0-9]((\.[A-Z0-9]{1,4})|(?!\*|-)(?=\W))", Snippet)
;   RegExMatch(Result, "<div class=""KpMaL"">(.*?)</div>", Snippet)
;   Snippet:=RegExReplace(Snippet, "<(.*?)>")
 ;  msgbox % Snippet
      
   If !Snippet
   {
      msgbox Unable to find immediate search, opening google...
      ; % Result
      run % URL
   }

   return Snippet
/*
   RegExMatch(Result, "<h3 class=""r"">(.*?)</h3>", match) 
   RegExMatch(match1, "href=""(.*?)""", url)
   RegExMatch(match1, "<b>(.*?)</b>", title) 
;   Return % title1 " - " url1
*/
}

EncodeURL(Text)
{ 
   StringReplace, Text, Text, `%, `%25, All 
   StringReplace, Text, Text, +, `%2B, All 
   StringReplace, Text, Text, %A_Space%, +, All 
   FormatInteger := A_FormatInteger, FoundPos := 0 
   SetFormat, IntegerFast, Hex 
   While (FoundPos := RegExMatch(Text, "S)[^\w-.~%+]", Char, FoundPos + 1)) 
      StringReplace, Text, Text, %Char%, % "%" SubStr(0 SubStr(Asc(Char), 3), -1), All 
   SetFormat, IntegerFast, %FormatInteger% 
   Return RegExReplace(Text, "%..", "$U0") 
}

#IfWinActive