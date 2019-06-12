;GetLabs

GetLabs() {
;f8::
	WinActivate, ahk_exe CPRSChart.exe
	send ^l
	Loop
		sleep 50
	until CPRSPage("Laboratory Results Page")
	while (A_Cursor = AppStarting) or (A_Cursor = Wait)
	sleep 500

	Loop 
	{
		ControlSend, TORTreeView1, {PgUp}, ahk_class TfrmFrame ahk_exe CPRSChart.exe, Laboratory Results Page
		ControlSend, TORTreeView1, A{Enter}, A
		
		Loop 
		{
			ControlGetText, TitleTxt, TCaptionListView1, A
			sleep 50
			ControlGetText, TitleTxt2, TCaptionListView1, A
		} Until TitleTxt = TitleTxt2
		
	;	msgbox % TitleTxt

		if A_Index > 5
			{
				MsgBox Unable to find All Tests by Date (script work in progress).
				return
			}

	} until InStr(TitleTxt, "All Tests by Date")
	
	Loop {
		sleep 50
		ControlGetText, ButtonText, TRadioButton8, A
	} until ButtonText = "1 Week"
	Control, Check,, TRadioButton8, A
	/*
14 . 0x109f8      TRadioButton3                            All Results
15 . 0x109f6      TRadioButton4                            2 Years
16 . 0x109f4      TRadioButton5                            1 Year
17 . 0x109f2      TRadioButton6                            6 Months
18 . 0x109f0      TRadioButton7                            1 Month
19 . 0x109ee      TRadioButton8                            1 Week
	*/

	Loop 
	{
		ControlGetText, LabResults, TRichEdit1, A
		sleep 10
		ControlGetText, LabResults2, TRichEdit1, A
	} Until LabResults = LabResults2

;	msgbox % LabResults
;FormattedLabs := RegExReplace(LabResults, "(.*(?=\n? *\[[0-9]{1,5}\]\n))|(Report Released Date\/Time.*)|(.*Test name.*range)", "$1")


;SubStr, 


regex := ComObjCreate("VBScript.RegExp")
regex.Global := true
regex.Pattern := "(.*(?=\n? *\[[0-9]{1,5}\]))|(Report Released Date\/Time.*)|(.*Test name.*range)"



; UA -needs work (?m)^(?=(?:(?!\r?\n\r?\n)[\s\S])*\bCIPROFLOXACIN\b)[\s\S]*?(?:\n\n|\Z)"
match := regex.Execute(LabResults)
FormattedLabs := ""

for item in match
{
	if item.value = ""
		Continue
	FormattedLabs .= item.value "`n"
}
FormattedLabs := RegExReplace(FormattedLabs , "`am)(Performing Lab Sites)|\s+$") ; Removes spaces

;msgbox % FormattedLabs


;	FormattedLabs := RegExReplace(LabResults, "m)^(?!.*\[[0-9]+\]|Report Released Date/Time: \w).*$\R| *\[[0-9]+\]| *Lab NOTE *") ;no UA
	
;	(.*\s*\[[0-9]{1,5}\]\n)|(Report Released Date\/Time.*)
;	FormattedLabs := RegExReplace(FormattedLabs, "(\n\r){2,}| *\[[0-9]+\]| *Lab NOTE *")
;	FormattedLabs := RegExReplace(LabResults, "m) +$")
;	FormattedLabs := RegExReplace(FormattedLabs, "m)?(   *)","		")
;	FormattedLabs := RegExReplace(FormattedLabs, "m)   *?!\R","	")

if FormattedLabs
	FormattedLabs := "=================Labs==================`n"FormattedLabs

Return FormattedLabs
}

/*
[code]
VistA CPRS in use by: Kim,Bryan Y  (vista.denver.med.va.gov) [Class:TfrmFrame]
---------------------------------------------------------------------------------------------------
Sl   c_Hwnd       ClassNN                                  Control Text (40 Characters only)       
---------------------------------------------------------------------------------------------------

1  . 0xd0bb4      TBitBtn1                                 &Next
2  . 0x705a0      TPanel1                                  
3  . 0xf1098      TPanel2                                  
4  . 0xf0aa2      TfrmLabs1                                Laboratory Results Page
5  . 0x80df0      TPanel3                                  
6  . 0x50c84      TORAutoPanel1                            
7  . 0x50898      TStaticText1                             
8  . 0x60a9c      TPanel4                                  
9  . 0xb103c      TPanel5                                  
10 . 0x709a8      TPanel6                                  
11 . 0xf0ca0      TGroupBox1                               
12 . 0x8093c      TRadioButton1                            Date Range...
13 . 0x90962      TRadioButton2                            Today
14 . 0x60992      TRadioButton3                            All Results
15 . 0x80990      TRadioButton4                            2 Years
16 . 0x80ae6      TRadioButton5                            1 Year
17 . 0x70e26      TRadioButton6                            6 Months
18 . 0x70e24      TRadioButton7                            1 Month
19 . 0x1600ee     TRadioButton8                            1 Week
20 . 0x50b48      TTabControl1                             
21 . 0x90980      TPanel7                                  
22 . 0x50aa4      TButton1                                       
23 . 0xa08de      TButton2                                       
24 . 0xc08be      TPanel8                                  
25 . 0xb08a0      TCaptionListView1                        All Tests by Date [From: May 01,2019 to 
26 . 0x8094c      SysHeader321                             
27 . 0xa084e      TCaptionStringGrid1                      
28 . 0xa0414      TORAutoPanel2                            
29 . 0x50c82      TORAutoPanel3                            
30 . 0x80952      TButton3                                 << Oldest
31 . 0x50aa8      TButton4                                 Newest >>
32 . 0x6089e      TButton5                                 < Previous
33 . 0x50aa6      TButton6                                 Next >
34 . 0xe0896      TORAutoPanel4                            
35 . 0x60c80      TCheckBox1                               Zoom
36 . 0x1207c0     TCheckBox2                               Values
37 . 0x70918      TCheckBox3                               3D
38 . 0x120878     TORAutoPanel5                            
39 . 0x190884     TCheckBox4                               Zoom
40 . 0xc0d10      TRadioGroup1                             Other Formats 
41 . 0x90954      TGroupButton1                            &Graph
42 . 0x1d093a     TGroupButton2                            &Comments
43 . 0xd046e      TCheckBox5                               Abnormal Results Only
44 . 0x908e0      TRadioGroup2                             Table Format 
45 . 0xa08e2      TGroupButton3                            &Vertical
46 . 0x908e4      TGroupButton4                            &Horizontal
47 . 0x2007bc     TCheckBox6                               3D
48 . 0x100944     TCheckBox7                               Values
49 . 0x30b90      TPanel9                                  
50 . 0x40b8e      TRichEdit1                               Printed at:@@ROCKY MOUNTAIN REGIONAL VAM
51 . 0x60ad8      Shell Embedding1                         
52 . 0x40e48      Shell DocObject View1                    
53 . 0x70c88      Internet Explorer_Server1                
54 . 0x40bb0      TPanel10                                 
55 . 0x40e4a      TPanel11                                 
56 . 0xb0aaa      TPanel12                                 
57 . 0xd098e      TStaticText2                             
58 . 0xb089c      TORListBox1                              
59 . 0xd08a6      TStaticText3                             Date Range
60 . 0x120ada     TORListBox2                              
61 . 0x30bb2      TPanel13                                 
62 . 0xb0b10      TStaticText4                             Headings
63 . 0x20b84      TORListBox3                              
64 . 0xb0a36      TORAutoPanel6                            
65 . 0xb08c2      TButton7                                 Other Tests
66 . 0x110894     TPanel14                                 
67 . 0xa08a2      TStaticText5                             Available Reports
68 . 0xa091a      TORTreeView1                             Available Reports
69 . 0x1a09f4     TfrmReports1                             Reports Page
70 . 0x30b1e      TPanel15                                 
71 . 0xb0e3a      TPanel16                                 
72 . 0x90c9a      TCaptionListView2                        Imaging [From: Apr 04,2018 to May 09,201
73 . 0x30b0c      SysHeader322                             
74 . 0x308ba      TPanel17                                 
75 . 0x308ae      TRichEdit2                               
76 . 0xe125a      Shell Embedding2                         
77 . 0x20412      Shell DocObject View2                    
78 . 0x70f9e      Internet Explorer_Server2                
79 . 0x50ac8      TPanel18                                 
80 . 0x40b78      TPanel19                                 
81 . 0x40bd6      TPanel20                                 
82 . 0x30b7a      TGroupBox2                               
83 . 0x70f98      TRadioButton9                            Date Range...
84 . 0x5102c      TRadioButton10                           Today
85 . 0x30b16      TRadioButton11                           All Results
86 . 0x40bdc      TRadioButton12                           2 Years
87 . 0x40bda      TRadioButton13                           1 Year
88 . 0x30b76      TRadioButton14                           6 Months
89 . 0x40bd8      TRadioButton15                           1 Month
90 . 0x30b74      TRadioButton16                           1 Week
91 . 0x30b70      TPanel21                                 
92 . 0x30b72      TButton8                                       
93 . 0x40bd4      TButton9                                       
94 . 0x50ace      TTabControl2                             
95 . 0x1c0a5a     TfrmGraphs1                              CPRS Graphing - CPRSpatient,One
96 . 0x1e0964     TPanel22                                 
97 . 0x15090c     TPanel23                                 
98 . 0xb11ea      TPanel24                                 
99 . 0x1602f4     TScrollBox1                              
100. 0x1b0994     TPanel25                                 
101. 0xc102a      TPanel26                                 
102. 0x171244     TPageControl1                            
103. 0x2311ca     TTabSheet1                               Views
104. 0x120158     TORListBox4                              
105. 0xe014c      TTabSheet2                               Items
106. 0x1111c2     TListView1                               
107. 0x150914     SysHeader323                             
108. 0x220558     msctls_updown321                         
109. 0xd1236      TPanel27                                 
110. 0xf124e      TCheckBox8                               Individual Graphs
111. 0x1312b6     TPanel28                                 
112. 0xc1286      TPanel29                                 
113. 0x1402c6     TScrollBox2                              
114. 0x140358     TPanel30                                 
115. 0x190388     TPanel31                                 
116. 0x1d02f0     TPageControl2                            
117. 0x1202d8     TTabSheet3                               Views
118. 0x1b11ce     TORListBox5                              
119. 0x110c9e     TTabSheet4                               Items
120. 0xa030c      TListView2                               
121. 0x1012cc     SysHeader324                             
122. 0x902fe      msctls_updown322                         
123. 0x26109c     TPanel32                                 
124. 0x100e54     TCheckBox9                               Individual Graphs
125. 0xc037a      TPanel33                                 
126. 0x1d12bc     TButton10                                Select/Define...
127. 0x100400     TCheckBox10                              Split Views
128. 0xb129a      TORComboBox1                             
129. 0x1311ec     TStaticText6                             
130. 0xd00dc      TORComboEdit1                            T-400 to T
131. 0x1710e4     TBitBtn2                                 
132. 0x1602c0     TButton11                                Settings...
133. 0x1d123e     TButton12                                Close
134. 0x120e38     TPanel34                                 
135. 0x220936     TORAutoPanel7                            Select multiple items using Ctrl-click o
136. 0x30b42      TPanel35                                 
137. 0x60b7c      TPanel36                                 
138. 0x50b1a      TStaticText7                             tvProcedures
139. 0x7100a      TORTreeView2                             tvProcedures
140. 0x30b7e      TPanel37                                 
141. 0xe0932      TORAutoPanel8                            
142. 0x7122e      TStaticText8                             
143. 0xd0a54      TORListBox6                              
144. 0x61222      TPanel38                                 
145. 0x61224      TORAlignButton1                          Settings...
146. 0x61230      TORAlignButton2                          Select/Define...
147. 0x61220      TCheckBox11                              Split Views
148. 0x150a3e     TStaticText9                             
149. 0x30b82      TORListBox7                              
150. 0x230f86     TStaticText10                            Headings
151. 0x30b80      TORListBox8                              
152. 0x30b38      TPanel39                                 
153. 0x30b6e      TStaticText11                            Available Reports
154. 0x40b44      TORTreeView3                             Available Reports
155. 0x6049e      TfrmOrders1                              Orders Page
156. 0x805a6      TPanel40                                 
157. 0x308b2      TStaticText12                            Active Orders (includes Pending & Recent
158. 0x90dd0      TCaptionListBox1                         
159. 0x50ac4      THeaderControl1                          
160. 0x31204      TPanel41                                 
161. 0x308b0      TORAlignButton3                          Write Delayed Orders
162. 0xb10ec      TStaticText13                            Write Orders
163. 0xf0dda      TORListBox9                              
164. 0x811142     TStaticText14                            View Orders
165. 0x3120a      TORListBox10                             
166. 0x60b2e      TfrmNotes1                               frmNotes
167. 0x70b64      TPanel42                                 
168. 0xa0e2e      TPanel43                                 
169. 0x160a9e     TCaptionListView3                        No Progress Notes Found
170. 0xa0dfa      SysHeader325                             
171. 0x1403fe     TRichEdit3                               
172. 0x40b8a      TVA508StaticText1                        
173. 0x50b5c      TRichEdit4                               
174. 0xe0af8      TPanel44                                 
175. 0x4097e      TPanel45                                 
176. 0x4098c      TStaticText15                            Subject
177. 0x4098a      TButton13                                Change...
178. 0x40988      TStaticText16                            
179. 0x40986      TStaticText17                            Vst: 02/21/19  RMR PACT MD 18
180. 0x40984      TStaticText18                            KIM,BRYAN Y
181. 0x40982      TStaticText19                            May 09,2019@11:17
182. 0x5094e      TStaticText20                             Addendum to: PRIMARY CARE PROVIDER NOTE
183. 0xa0ad0      TRichEdit5                               
184. 0x31208      TPanel46                                 
185. 0x60fec      TVA508StaticText2                        
186. 0x20a22      TPanel47                                 
187. 0x60bc8      TStaticText21                            
188. 0x30522      TORListBox11                             
189. 0x70f9c      TPanel48                                 
190. 0x100f96     TfraDrawers1                             
191. 0x70b9e      TPanel49                                 
192. 0x308b6      TBitBtn3                                 Orders
193. 0x30b6c      TPanel50                                 
194. 0x30b34      TBitBtn4                                 Reminders
195. 0x40b8c      TPanel51                                 
196. 0x50e3c      TBitBtn5                                 Templates
197. 0x90b40      TStaticText22                            
198. 0x20402      TORTreeView4                             
199. 0x60b58      TORAlignButton4                          Encounter
200. 0xf0e0e      TORAlignButton5                          New Note
201. 0x60b30      TfrmCover1                               Cover Sheet
202. 0x40b9c      TPanel52                                 
203. 0x41024      TPanel53                                 
204. 0x180fb2     TPanel54                                 
205. 0x30ab6      TStaticText23                            Appointments/Visits/Admissions
206. 0x2210fc     TORListBox12                             
207. 0x4101e      TPanel55                                 
208. 0x50fb0      TPanel56                                 
209. 0x30ab2      TStaticText24                            Vitals
210. 0x30ba8      TORListBox13                             
211. 0x30ba6      TPanel57                                 
212. 0x30aae      TStaticText25                            Recent Lab Results
213. 0xb0f8a      TORListBox14                             
214. 0x40ba0      TPanel58                                 
215. 0x30bd2      TPanel59                                 
216. 0x40ba4      TPanel60                                 
217. 0x709a2      TStaticText26                            Clinical Reminders                      
218. 0x50fb8      TORListBox15                             
219. 0x40fe0      TPanel61                                 
220. 0x70950      TStaticText27                            Active Medications
221. 0x60fc0      TORListBox16                             
222. 0x30bce      TPanel62                                 
223. 0x20b86      TPanel63                                 
224. 0x6097c      TStaticText28                            Postings
225. 0x60ca4      TORListBox17                             
226. 0x1307b6     TPanel64                                 
227. 0x6097a      TStaticText29                            
228. 0x808d8      TORListBox18                             
229. 0x30bd0      TPanel65                                 
230. 0x50fa0      TPanel66                                 
231. 0x609a0      TStaticText30                            Allergies / Adverse Reactions
232. 0x30bb6      TORListBox19                             
233. 0x50e46      TPanel67                                 
234. 0x7099a      TStaticText31                            Active Problems
235. 0x60c9c      TORListBox20                             
236. 0x6059e      TfrmConsults1                            Consults Page
237. 0xc0a2a      TPanel68                                 
238. 0x20470      TPanel69                                 
239. 0x120868     TStaticText32                            All Consults
240. 0x30526      TORTreeView5                             All Consults
241. 0x408da      TStaticText33                            
242. 0x203ea      TORListBox21                             
243. 0x30aca      TPanel70                                 
244. 0x60a26      TfrmDrawers1                             frmDrawers
245. 0xa0886      TStaticText34                            Reminders
246. 0x40972      TStaticText35                            Encounter
247. 0x50c86      TStaticText36                            Orders
248. 0x4096a      TStaticText37                            Consult Notes
249. 0x203e6      TORTreeView6                             Consult Notes
250. 0x40968      TStaticText38                            
251. 0x20abc      TORListBox22                             
252. 0xb0882      TORAlignButton6                          New Procedure
253. 0x4096e      TORAlignButton7                          New Consult
254. 0x70a0a      TPanel71                                 
255. 0x50bc0      TPanel72                                 
256. 0x61020      TRichEdit6                               
257. 0x60b5e      TRichEdit7                               
258. 0x70e02      TPanel73                                 
259. 0x50970      TPanel74                                 
260. 0x36099e     TStaticText39                            Subject
261. 0x40880      TCaptionEdit1                            
262. 0x37099c     TButton14                                Change...
263. 0x30910      TStaticText40                             General Medicine Note 
264. 0x4095a      TStaticText41                            Subject:
265. 0x40958      TStaticText42                            Expected Cosigner: Winchester,Charles Em
266. 0x50956      TStaticText43                            Vst: 10/20/99 Pulmonary Clinic, Dr. Welb
267. 0x50966      TStaticText44                            Winchester,Charles Emerson III
268. 0x409a6      TStaticText45                            Oct 20,1999@15:30
269. 0x30b1c      TRichEdit8                               
270. 0x60b2c      TfrmMeds1                                Medications Page
271. 0x308aa      TPanel75                                 
272. 0x308a4      TVA508StaticText3                        
273. 0x40bc4      TORAutoPanel9                            
274. 0x30bca      THeaderControl2                          
275. 0x308a8      TStaticText46                            Outpatient Medications
276. 0x71200      TCaptionListBox2                         
277. 0xc0e34      TORAutoPanel10                           
278. 0x8024a      TPanel76                                 pnlNonVA
279. 0x30bcc      THeaderControl3                          
280. 0x70874      TStaticText47                            Inpatient Medications
281. 0x51202      TCaptionListBox3                         
282. 0x40bc2      TPanel77                                 
283. 0x41008      THeaderControl4                          
284. 0x70872      TStaticText48                            Inpatient Medications
285. 0x81206      TCaptionListBox4                         
286. 0x80aee      TfrmDCSumm1                              Discharge Summary Page
287. 0x90fda      TPanel78                                 
288. 0x203e8      TPanel79                                 
289. 0x203ee      TRichEdit9                               
290. 0x70dbe      TPanel80                                 
291. 0x80ddc      TRichEdit10                              
292. 0x203f0      TRichEdit11                              
293. 0x70e04      TPanel81                                 
294. 0x90dca      TPanel82                                 
295. 0x60df2      TfrmDrawers2                             frmDrawers
296. 0x80360      TORTreeView7                             Last 100 Summaries
297. 0x203ec      TORListBox23                             
298. 0x140acc     TfrmSurgery1                             Surgery Page
299. 0xa12c2      TPanel83                                 
300. 0x120938     TPanel84                                 
301. 0x20410      TRichEdit12                              
302. 0x60de6      TPanel85                                 
303. 0x60df4      TRichEdit13                              
304. 0x70db2      TPanel86                                 
305. 0xb12c6      TPanel87                                 
306. 0x70de2      TfrmDrawers3                             frmDrawers
307. 0x20418      TORTreeView8                             Last 100 Surgery Cases
308. 0x4040e      TORListBox24                             
309. 0x8049a      TfrmProblems1                            Problems List Page
310. 0x180fba     TPanel88                                 
311. 0xd0242      TCaptionListBox5                         
312. 0x5059c      TStaticText49                            Remote Data
313. 0x308b4      TORListBox25                             
314. 0x110e12     TTabControl3                             
315. 0x505a4      TStatusBar1                              
316. 0x40b50      TPanel89                                 
317. 0x9101c      TKeyClickPanel1                          Remote Data
318. 0xa0b28      TKeyClickPanel2                          Remote Data
319. 0x90ff2      TKeyClickPanel3                          
320. 0x131278     TPanel90                                 
321. 0x180e22     TKeyClickPanel4                          
322. 0x90a02      TButton15                                CV 
323. 0x80fe2      TKeyClickPanel5                          
324. 0x30b36      TButton16                                MHV
325. 0x70b46      TButton17                                Pt Insur
326. 0xc0dd8      TKeyClickPanel6                          Postings A
327. 0x100a06     TStaticText50                            A
328. 0x13103a     TStaticText51                            Postings
329. 0x80a04      TKeyClickPanel7                          Reminders
330. 0x50960      TAnimate1                                

342. 0x6059a      TPanel91                                 
343. 0x705aa      MDIClient1                               
344. 0x30bc6      TPanel92                                 
---------------------------------------------------------------------------------------------------
* Control Spy * By Goyyah
[/code]
*/