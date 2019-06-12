;GetRadio

GetRadio() {

	WinActivate, ahk_exe CPRSChart.exe
	send ^r
	Loop
		sleep 50
	until CPRSPage("Reports Page")
	while (A_Cursor = AppStarting) or (A_Cursor = Wait)
	sleep 500

	Loop 
	{
		ControlSend, TORTreeView1, {PGDN}, ahk_class TfrmFrame ahk_exe CPRSChart.exe, Reports Page
		ControlSend, TORTreeView1, I{Enter}, A
		
		Loop 
		{
			ControlGetText, TitleTxt, TCaptionListView1, A
			sleep 50
			ControlGetText, TitleTxt2, TCaptionListView1, A
		} Until TitleTxt = TitleTxt2
		
	;	msgbox % TitleTxt

		if A_Index > 5
			{
				MsgBox Unable to find Imaging (script work in progress).
				return
			}

	} until (InStr(TitleTxt, "Imaging") = 1)FOLLOW UP LETTER
	
	
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
	RadResults := ""
	Loop
	{
		ControlFocus, TCaptionListView1, A
		ControlSend, TCaptionListView1, {space}, A
		Loop 
		{
			ControlGetText, TempRadResults, TRichEdit1, A
			sleep 10
			ControlGetText, TempRadResults2, TRichEdit1, A
		} Until TempRadResults = TempRadResults2
		
		RadResults .= TempRadResults
		ControlSend, TCaptionListView1, {Down}, A
		
		Loop 
		{
			ControlGetText, TempRadResults3, TRichEdit1, A
			sleep 10
			ControlGetText, TempRadResults2, TRichEdit1, A
		} Until TempRadResults3 = TempRadResults2
	} until TempRadResults = TempRadResults3

;	clipboard := RadResults
;	msgbox % RadResults
;	FormattedRad := RegExReplace(RadResults, "m)^(?!.*\[[0-9]+\]|Report Released Date/Time: \w).*$\R| *\[[0-9]+\]| *Lab NOTE *")



regex := ComObjCreate("VBScript.RegExp")
regex.Global := true
regex.Pattern := "Detailed Report\s*.*|[A-Z]{3}.*(?=\s*Verifier E-Sig)|Impression:(?=\s+)[\s\S]*?(?=\s*Primary Diagnostic Code)"
;regex.Pattern := "((?<=^Detailed Report\s).*)|((?<=Date Verified: ).*)|(Impression:(?=\s+)[\s\S]*?(?=\s*Primary Diagnostic Code))"
match := regex.Execute(RadResults)

FormattedRad := ""

for item in match
{
	if item.value = ""
		Continue
	FormattedRad .= item.value "`n"
}

;	msgbox % FormattedRad
	FormattedRad := RegExReplace(FormattedRad , "m)\s+$|(Detailed Report)") ; Removes spaces

	if FormattedRad
		FormattedRad := "===============Radiology==============="FormattedRad
						 
	Return FormattedRad
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
4  . 0x1a09f4     TfrmReports1                             Reports Page
5  . 0x30b1e      TPanel3                                  
6  . 0xb0e3a      TPanel4                                  
7  . 0x90c9a      TCaptionListView1                        Imaging [From: Apr 04,2018 to May 09,201
8  . 0x30b0c      SysHeader321                             
9  . 0x308ba      TPanel5                                  
10 . 0x308ae      TRichEdit1                               
11 . 0xe125a      Shell Embedding1                         
12 . 0x20412      Shell DocObject View1                    
13 . 0x70f9e      Internet Explorer_Server1                
14 . 0x50ac8      TPanel6                                  
15 . 0x40b78      TPanel7                                  
16 . 0x40bd6      TPanel8                                  
17 . 0x30b7a      TGroupBox1                               
18 . 0x70f98      TRadioButton1                            Date Range...
19 . 0x5102c      TRadioButton2                            Today
20 . 0x30b16      TRadioButton3                            All Results
21 . 0x40bdc      TRadioButton4                            2 Years
22 . 0x40bda      TRadioButton5                            1 Year
23 . 0x30b76      TRadioButton6                            6 Months
24 . 0x40bd8      TRadioButton7                            1 Month
25 . 0x30b74      TRadioButton8                            1 Week
26 . 0x30b70      TPanel9                                  
27 . 0x30b72      TButton1                                       
28 . 0x40bd4      TButton2                                       
29 . 0x50ace      TTabControl1                             
30 . 0x1c0a5a     TfrmGraphs1                              CPRS Graphing - CPRSpatient,One
31 . 0x1e0964     TPanel10                                 
32 . 0x15090c     TPanel11                                 
33 . 0xb11ea      TPanel12                                 
34 . 0x1602f4     TScrollBox1                              
35 . 0x1b0994     TPanel13                                 
36 . 0xc102a      TPanel14                                 
37 . 0x171244     TPageControl1                            
38 . 0x2311ca     TTabSheet1                               Views
39 . 0x120158     TORListBox1                              
40 . 0xe014c      TTabSheet2                               Items
41 . 0x1111c2     TListView1                               
42 . 0x150914     SysHeader322                             
43 . 0x220558     msctls_updown321                         
44 . 0xd1236      TPanel15                                 
45 . 0xf124e      TCheckBox1                               Individual Graphs
46 . 0x1312b6     TPanel16                                 
47 . 0xc1286      TPanel17                                 
48 . 0x1402c6     TScrollBox2                              
49 . 0x140358     TPanel18                                 
50 . 0x190388     TPanel19                                 
51 . 0x1d02f0     TPageControl2                            
52 . 0x1202d8     TTabSheet3                               Views
53 . 0x1b11ce     TORListBox2                              
54 . 0x110c9e     TTabSheet4                               Items
55 . 0xa030c      TListView2                               
56 . 0x1012cc     SysHeader323                             
57 . 0x902fe      msctls_updown322                         
58 . 0x26109c     TPanel20                                 
59 . 0x100e54     TCheckBox2                               Individual Graphs
60 . 0xc037a      TPanel21                                 
61 . 0x1d12bc     TButton3                                 Select/Define...
62 . 0x100400     TCheckBox3                               Split Views
63 . 0xb129a      TORComboBox1                             
64 . 0x1311ec     TStaticText1                             
65 . 0xd00dc      TORComboEdit1                            T-400 to T
66 . 0x1710e4     TBitBtn2                                 
67 . 0x1602c0     TButton4                                 Settings...
68 . 0x1d123e     TButton5                                 Close
69 . 0x120e38     TPanel22                                 
70 . 0x220936     TORAutoPanel1                            Select multiple items using Ctrl-click o
71 . 0x30b42      TPanel23                                 
72 . 0x60b7c      TPanel24                                 
73 . 0x50b1a      TStaticText2                             tvProcedures
74 . 0x7100a      TORTreeView1                             tvProcedures
75 . 0x30b7e      TPanel25                                 
76 . 0xe0932      TORAutoPanel2                            
77 . 0x7122e      TStaticText3                             
78 . 0xd0a54      TORListBox3                              
79 . 0x61222      TPanel26                                 
80 . 0x61224      TORAlignButton1                          Settings...
81 . 0x61230      TORAlignButton2                          Select/Define...
82 . 0x61220      TCheckBox4                               Split Views
83 . 0x150a3e     TStaticText4                             
84 . 0x30b82      TORListBox4                              
85 . 0x230f86     TStaticText5                             Headings
86 . 0x30b80      TORListBox5                              
87 . 0x30b38      TPanel27                                 
88 . 0x30b6e      TStaticText6                             Available Reports
89 . 0x40b44      TORTreeView2                             Available Reports
90 . 0xf0aa2      TfrmLabs1                                Reports Page
91 . 0x80df0      TPanel28                                 
92 . 0x50c84      TORAutoPanel3                            
93 . 0x50898      TStaticText7                             
94 . 0x60a9c      TPanel29                                 
95 . 0xb103c      TPanel30                                 
96 . 0x709a8      TPanel31                                 
97 . 0xf0ca0      TGroupBox2                               
98 . 0x8093c      TRadioButton9                            Date Range...
99 . 0x90962      TRadioButton10                           Today
100. 0x60992      TRadioButton11                           All Results
101. 0x80990      TRadioButton12                           2 Years
102. 0x80ae6      TRadioButton13                           1 Year
103. 0x70e26      TRadioButton14                           6 Months
104. 0x70e24      TRadioButton15                           1 Month
105. 0x1600ee     TRadioButton16                           1 Week
106. 0x50b48      TTabControl2                             
107. 0x90980      TPanel32                                 
108. 0x50aa4      TButton6                                       
109. 0xa08de      TButton7                                       
110. 0xc08be      TPanel33                                 
111. 0xb08a0      TCaptionListView2                        Cumulative [From: May 01,2019 to May 09,
112. 0x8094c      SysHeader324                             
113. 0xa084e      TCaptionStringGrid1                      
114. 0xa0414      TORAutoPanel4                            
115. 0x50c82      TORAutoPanel5                            
116. 0x80952      TButton8                                 << Oldest
117. 0x50aa8      TButton9                                 Newest >>
118. 0x6089e      TButton10                                < Previous
119. 0x50aa6      TButton11                                Next >
120. 0xe0896      TORAutoPanel6                            
121. 0x60c80      TCheckBox5                               Zoom
122. 0x1207c0     TCheckBox6                               Values
123. 0x70918      TCheckBox7                               3D
124. 0x120878     TORAutoPanel7                            
125. 0x190884     TCheckBox8                               Zoom
126. 0xc0d10      TRadioGroup1                             Other Formats 
127. 0x90954      TGroupButton1                            &Graph
128. 0x1d093a     TGroupButton2                            &Comments
129. 0xd046e      TCheckBox9                               Abnormal Results Only
130. 0x908e0      TRadioGroup2                             Table Format 
131. 0xa08e2      TGroupButton3                            &Vertical
132. 0x908e4      TGroupButton4                            &Horizontal
133. 0x2007bc     TCheckBox10                              3D
134. 0x100944     TCheckBox11                              Values
135. 0x30b90      TPanel34                                 
136. 0x40b8e      TRichEdit2                               Printed at:@@ROCKY MOUNTAIN REGIONAL VAM
137. 0x60ad8      Shell Embedding2                         
138. 0x40e48      Shell DocObject View2                    
139. 0x70c88      Internet Explorer_Server2                
140. 0x40bb0      TPanel35                                 
141. 0x40e4a      TPanel36                                 
142. 0xb0aaa      TPanel37                                 
143. 0xd098e      TStaticText8                             
144. 0xb089c      TORListBox6                              
145. 0xd08a6      TStaticText9                             Date Range
146. 0x120ada     TORListBox7                              
147. 0x30bb2      TPanel38                                 
148. 0xb0b10      TStaticText10                            Headings
149. 0x20b84      TORListBox8                              
150. 0xb0a36      TORAutoPanel8                            
151. 0xb08c2      TButton12                                Other Tests
152. 0x110894     TPanel39                                 
153. 0xa08a2      TStaticText11                            Available Reports
154. 0xa091a      TORTreeView3                             Available Reports
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