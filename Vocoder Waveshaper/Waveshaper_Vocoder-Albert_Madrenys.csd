; Author:    Albert Madrenys
; Created:   14/01/2024
; MU611A - Software Sound Synthesis
; Final Project - Waveshaper Vocoder

<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>
0dbfs = 1
ksmps = 32

;;channels
chn_k "DC",3
chn_k "H0",3
chn_k "H1",3
chn_k "H2",3
chn_k "H3",3
chn_k "H4",3
chn_k "H5",3
chn_k "H6",3
chn_k "plot",2
chn_k "indexDist",1
chn_k "envTime",1
chn_k "mic", 1

;MIDI controllers
//massign 1, 1
initc7 1, 20, 0.5

;functions declaration
gitrans init 0
ginorm init 0

;generator of the tables with the channel values (if done outside an instrument, the channels are not initialized)
instr 2
	gitrans ftgen 0, 0, 4097, 13, 1, 1,
			chnget("DC"), chnget("H0"), chnget("H1"), chnget("H2"),
			chnget("H3"), chnget("H4"), chnget("H5"), chnget("H6") ;transfer function	
	ginorm ftgen 0, 0, 2049, 4, gitrans, 1 ;normalising function
	chnset gitrans, "plot"
endin
schedule 2, 0, 0

instr 1
	iamp ampmidi 0dbfs
	kfreq cpsmidib 2
	kindex chnget "indexDist"
	ienvspeed chnget "envTime"
	kampenv linenr iamp, ienvspeed*0.5, ienvspeed*1.5, 0.01 ;amp envelope
	kindexenv linenr kindex, ienvspeed, ienvspeed, 0.01 ;timbre envelope
 
	acos oscili kindexenv*0.5, kfreq, -1,0.25 ;driving oscillator
	awave tablei acos, gitrans, 1, 0.5 ;waveshaper
	kscaler tablei kindexenv, ginorm, 1 ;scaler
 	asyn = awave*kscaler*kampenv
 	
 	kmic chnget "mic"
 	if kmic == 1 then
 		asig in
 	elseif kmic == 0 then
 		asig diskin "fox.wav", 1, 0, 1
 	endif
 	
	famp pvsanal asig, 2048, 512, 2048, 2 ;analyse in signal
	fexc pvsanal asyn, 2048, 512, 2048, 2 ;analyse excitation signal
	ftps pvsvoc  famp, fexc, 1, 2, 100 ;vocoder
	atps pvsynth ftps ;synthesise
	
  	out atps
endin

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>












<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>0</x>
 <y>0</y>
 <width>747</width>
 <height>604</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>380</x>
  <y>9</y>
  <width>224</width>
  <height>210</height>
  <uuid>{ff9066f7-d672-48e9-bb23-91e7a36d4b98}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <label/>
  <alignment>left</alignment>
  <valignment>top</valignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>53</r>
   <g>206</g>
   <b>206</b>
  </bgcolor>
  <bordermode>false</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>0</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>13</x>
  <y>10</y>
  <width>350</width>
  <height>207</height>
  <uuid>{6d12b726-e58c-40e5-9387-0d286b047d27}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <label/>
  <alignment>left</alignment>
  <valignment>top</valignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>30</r>
   <g>185</g>
   <b>178</b>
  </bgcolor>
  <bordermode>false</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>0</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScope">
  <objectName/>
  <x>16</x>
  <y>234</y>
  <width>350</width>
  <height>150</height>
  <uuid>{a2a13253-186c-42d9-946b-fd91728df999}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <value>-255.00000000</value>
  <type>scope</type>
  <zoomx>2.00000000</zoomx>
  <zoomy>1.00000000</zoomy>
  <dispx>1.00000000</dispx>
  <dispy>1.00000000</dispy>
  <mode>0.00000000</mode>
  <triggermode>NoTrigger</triggermode>
 </bsbObject>
 <bsbObject version="2" type="BSBTableDisplay">
  <objectName>plot</objectName>
  <x>383</x>
  <y>233</y>
  <width>223</width>
  <height>154</height>
  <uuid>{c9d86703-84c2-42cf-8851-b14106e54649}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <color>
   <r>255</r>
   <g>193</g>
   <b>3</b>
  </color>
  <range>0.00</range>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>25</x>
  <y>28</y>
  <width>234</width>
  <height>42</height>
  <uuid>{b4ab9ac2-3b0c-4f0c-80f3-13afc55b9a0d}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <label>Strenght of partials
Use the GUI or the knobs in Oxygen25</label>
  <alignment>left</alignment>
  <valignment>top</valignment>
  <font>Arial</font>
  <fontsize>12</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>false</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>0</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>DC</objectName>
  <x>41</x>
  <y>75</y>
  <width>20</width>
  <height>100</height>
  <uuid>{f88cfdda-79ea-4427-b90b-75cd3d85e421}</uuid>
  <visible>true</visible>
  <midichan>1</midichan>
  <midicc>71</midicc>
  <description/>
  <minimum>-100.00000000</minimum>
  <maximum>100.00000000</maximum>
  <value>4.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>H0</objectName>
  <x>76</x>
  <y>75</y>
  <width>20</width>
  <height>100</height>
  <uuid>{561a072a-06cc-4db7-8006-2ffa7161ee5b}</uuid>
  <visible>true</visible>
  <midichan>1</midichan>
  <midicc>72</midicc>
  <description/>
  <minimum>-100.00000000</minimum>
  <maximum>100.00000000</maximum>
  <value>100.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>H1</objectName>
  <x>109</x>
  <y>75</y>
  <width>20</width>
  <height>100</height>
  <uuid>{4f64808b-28d7-4e64-becd-e2c2c3497325}</uuid>
  <visible>true</visible>
  <midichan>1</midichan>
  <midicc>73</midicc>
  <description/>
  <minimum>-100.00000000</minimum>
  <maximum>100.00000000</maximum>
  <value>70.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>H2</objectName>
  <x>143</x>
  <y>76</y>
  <width>20</width>
  <height>100</height>
  <uuid>{72f9e77d-8c56-4ac0-97d4-d3eb01bd7d28}</uuid>
  <visible>true</visible>
  <midichan>1</midichan>
  <midicc>74</midicc>
  <description/>
  <minimum>-100.00000000</minimum>
  <maximum>100.00000000</maximum>
  <value>42.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>H3</objectName>
  <x>176</x>
  <y>76</y>
  <width>20</width>
  <height>100</height>
  <uuid>{26dd7921-30d2-4c4f-b49a-40f55220ecd7}</uuid>
  <visible>true</visible>
  <midichan>1</midichan>
  <midicc>22</midicc>
  <description/>
  <minimum>-100.00000000</minimum>
  <maximum>100.00000000</maximum>
  <value>12.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>H4</objectName>
  <x>207</x>
  <y>76</y>
  <width>20</width>
  <height>100</height>
  <uuid>{2b094fba-1678-4a2a-a44c-41ee61b4978c}</uuid>
  <visible>true</visible>
  <midichan>1</midichan>
  <midicc>23</midicc>
  <description/>
  <minimum>-100.00000000</minimum>
  <maximum>100.00000000</maximum>
  <value>-2.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>H5</objectName>
  <x>240</x>
  <y>78</y>
  <width>20</width>
  <height>100</height>
  <uuid>{0df27e38-7d10-49b2-9c0f-b6723951acdd}</uuid>
  <visible>true</visible>
  <midichan>1</midichan>
  <midicc>26</midicc>
  <description/>
  <minimum>-100.00000000</minimum>
  <maximum>100.00000000</maximum>
  <value>2.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>H6</objectName>
  <x>274</x>
  <y>79</y>
  <width>20</width>
  <height>100</height>
  <uuid>{561f522e-c5d9-4deb-a5e2-e372063aaf7e}</uuid>
  <visible>true</visible>
  <midichan>1</midichan>
  <midicc>27</midicc>
  <description/>
  <minimum>-100.00000000</minimum>
  <maximum>100.00000000</maximum>
  <value>100.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>38</x>
  <y>183</y>
  <width>264</width>
  <height>25</height>
  <uuid>{068b2469-3fd7-4e2e-ad3d-609faf6c0669}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <label>DC        H0        H1       H2        H3       H4       H5       H6</label>
  <alignment>left</alignment>
  <valignment>top</valignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>false</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>0</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>299</x>
  <y>70</y>
  <width>40</width>
  <height>127</height>
  <uuid>{bfa7ce0a-c363-4ff2-b5be-186fe8b999b8}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <label>- +100



-   0



- -100</label>
  <alignment>left</alignment>
  <valignment>top</valignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>false</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>0</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBButton">
  <objectName/>
  <x>272</x>
  <y>32</y>
  <width>69</width>
  <height>30</height>
  <uuid>{aff9e95a-9aac-467d-8fe5-43a2cc073cac}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>113</midicc>
  <description/>
  <type>event</type>
  <pressedValue>1.00000000</pressedValue>
  <stringvalue/>
  <text>Regen</text>
  <image>/</image>
  <eventLine>i2 0 0</eventLine>
  <latch>false</latch>
  <momentaryMidiButton>false</momentaryMidiButton>
  <latched>false</latched>
  <fontsize>8</fontsize>
 </bsbObject>
 <bsbObject version="2" type="BSBButton">
  <objectName>mic</objectName>
  <x>397</x>
  <y>167</y>
  <width>100</width>
  <height>30</height>
  <uuid>{05724938-6a83-4079-8c1e-ee3686971cca}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <type>value</type>
  <pressedValue>1.00000000</pressedValue>
  <stringvalue/>
  <text>Mic/Fox</text>
  <image>/</image>
  <eventLine/>
  <latch>true</latch>
  <momentaryMidiButton>false</momentaryMidiButton>
  <latched>false</latched>
  <fontsize>10</fontsize>
 </bsbObject>
 <bsbObject version="2" type="BSBKnob">
  <objectName>indexDist</objectName>
  <x>396</x>
  <y>31</y>
  <width>80</width>
  <height>80</height>
  <uuid>{daba51a3-6eb1-44c7-8338-f6cd96d4c3eb}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>1</midicc>
  <description/>
  <minimum>0.10000000</minimum>
  <maximum>1.00000000</maximum>
  <value>1.00000000</value>
  <mode>lin</mode>
  <mouseControl act="">continuous</mouseControl>
  <resolution>0.01000000</resolution>
  <randomizable group="0">false</randomizable>
  <color>
   <r>0</r>
   <g>170</g>
   <b>255</b>
  </color>
  <textcolor>#512900</textcolor>
  <border>0</border>
  <borderColor>#512900</borderColor>
  <showvalue>true</showvalue>
  <flatstyle>true</flatstyle>
  <integerMode>false</integerMode>
 </bsbObject>
 <bsbObject version="2" type="BSBKnob">
  <objectName>envTime</objectName>
  <x>493</x>
  <y>31</y>
  <width>80</width>
  <height>80</height>
  <uuid>{c053fcf2-4ccc-4b6b-8f57-a0fc9445584d}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>20</midicc>
  <description/>
  <minimum>0.10000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.00000000</value>
  <mode>lin</mode>
  <mouseControl act="">continuous</mouseControl>
  <resolution>0.01000000</resolution>
  <randomizable group="0">false</randomizable>
  <color>
   <r>0</r>
   <g>170</g>
   <b>255</b>
  </color>
  <textcolor>#512900</textcolor>
  <border>0</border>
  <borderColor>#512900</borderColor>
  <showvalue>true</showvalue>
  <flatstyle>true</flatstyle>
  <integerMode>false</integerMode>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>396</x>
  <y>118</y>
  <width>81</width>
  <height>29</height>
  <uuid>{671cf893-52e4-4704-95ab-6e7a726bec98}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <label>Distortion</label>
  <alignment>center</alignment>
  <valignment>top</valignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>false</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>0</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>496</x>
  <y>118</y>
  <width>79</width>
  <height>29</height>
  <uuid>{01c40abe-e442-43a4-bf76-9f0685ed303c}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <label>Envelope</label>
  <alignment>center</alignment>
  <valignment>top</valignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>false</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>0</borderwidth>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
