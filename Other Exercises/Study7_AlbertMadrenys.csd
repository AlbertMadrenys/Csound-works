/**
 * Author:    Albert Madrenys
 * Created:   3/11/2023
 * MU611A — Software Sound Synthesis
 * Additive Synthesis — Exercise 1
 **/

<CsoundSynthesizer>
<CsOptions>
-odac --midi-key=5 --midi-velocity-amp=4
</CsOptions>
<CsInstruments>
0dbfs = 1

;;channels
chn_k "0",3
chn_k "1",3
chn_k "2",3
chn_k "3",3
chn_k "4",3

massign 1,2
gaw[] init 96   // organ buffers
gifn0 ftgen 0,0,8192,10,1,0,1/3,0,1/5    // lowest octave wave

// organ generator: 96 buffers
instr 1
 ifn = -1                                         // internal sine wave table
 aph phasor cpsmidinn(24+p4)    // MIDI note 24 is the lowest organ frequency
 kvibamp chnget "vibamp"
 kvibfreq chnget "vibfreq"
 kvib oscili kvibamp, kvibfreq
 
 gaw[p4] tablei aph+kvib, gifn0, 1, 0, 1     // lowest octave uses a square wave
 gaw[p4+12] tablei aph*2+kvib, ifn, 1, 0, 1
 gaw[p4+24] tablei aph*4+kvib, ifn, 1, 0, 1 
 gaw[p4+36] tablei aph*8+kvib, ifn, 1, 0, 1
 gaw[p4+48] tablei aph*16+kvib, ifn, 1, 0, 1
 gaw[p4+60] tablei aph*32+kvib, ifn, 1, 0, 1
 gaw[p4+72] tablei aph*64+kvib, ifn, 1, 0, 1
 gaw[p4+84] tablei aph*128+kvib, ifn, 1, 0, 1
endin

idur = 315360000  // 100 years
ik = 0
while ik < 12 do     // one instance per semitone to generate 96 signals
  schedule(1, 0, idur,  ik)
  ik += 1
od

gabus[] init 5  // partial busses

// notes
instr 2
 ibas = p5 - 36                                                 // base tone (8') 
 kw[] fillarray -12, 0, 12, 24, 36  // partial semitones

 if ibas >= 12 && ibas < 96 then                      // if within the range of the organ
  aenv linenr 1,0.005,0.005,0.01                      // simple ON/OFF trapezoidal envelope with short attack and short decay.
  kk = 0
  while kk < 5 do
   kn = ibas+kw[kk]
   if kn < 96 then                                          // ignore foldbacks
    gabus[kk] = gabus[kk] + gaw[kn]*aenv*p4   // mix buffer to partial bus with envelope and amplitude
   endif
   kk += 1
  od
 endif 
endin

gkdb[] fillarray 1,1,0,0,0  							 // drawbars
gkvol  init        0.05                     // main volume

instr 4
  gkdb[0] chnget "0"
  gkdb[1] chnget "1"
  gkdb[2] chnget "2"
  gkdb[3] chnget "3"
  gkdb[4] chnget "4"
endin

schedule(4,0,-1)
// main mixer and output
instr 3
 kamp chnget "totalVolume"
 kk = 0
 amix = 0
 while kk < 5 do
  amix += gabus[kk]*gkdb[kk]       				// mix busses, scaled by drawbars
  gabus[kk] = 0                            // clear busses
  kk += 1
 od 
  out amix*gkvol*kamp                      // output
endin

schedule(3,0,idur)                         // only 1 instance is used

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>














<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>788</x>
 <y>182</y>
 <width>955</width>
 <height>446</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
 <bsbObject version="2" type="BSBController">
  <objectName>hor0</objectName>
  <x>154</x>
  <y>80</y>
  <width>30</width>
  <height>80</height>
  <uuid>{059ddfcd-c43f-423f-ac0e-496a3eb2791c}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <objectName2>0</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1.00000000</yMax>
  <xValue>0.00000000</xValue>
  <yValue>1.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <bordermode>noborder</bordermode>
  <borderColor>#00ff00</borderColor>
  <color>
   <r>0</r>
   <g>234</g>
   <b>0</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>30</r>
   <g>30</g>
   <b>30</b>
  </bgcolor>
  <bgcolormode>true</bgcolormode>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor0</objectName>
  <x>189</x>
  <y>80</y>
  <width>30</width>
  <height>80</height>
  <uuid>{1067bc42-2aef-4c6c-9694-888ea6e1ef9b}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <objectName2>1</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1.00000000</yMax>
  <xValue>0.00000000</xValue>
  <yValue>0.66250000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <bordermode>noborder</bordermode>
  <borderColor>#00ff00</borderColor>
  <color>
   <r>0</r>
   <g>234</g>
   <b>0</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>30</r>
   <g>30</g>
   <b>30</b>
  </bgcolor>
  <bgcolormode>true</bgcolormode>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor0</objectName>
  <x>225</x>
  <y>81</y>
  <width>30</width>
  <height>80</height>
  <uuid>{327a843a-f3b4-4044-ad07-51f45e655dfb}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <objectName2>2</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1.00000000</yMax>
  <xValue>0.00000000</xValue>
  <yValue>0.60000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <bordermode>noborder</bordermode>
  <borderColor>#00ff00</borderColor>
  <color>
   <r>0</r>
   <g>234</g>
   <b>0</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>30</r>
   <g>30</g>
   <b>30</b>
  </bgcolor>
  <bgcolormode>true</bgcolormode>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor0</objectName>
  <x>260</x>
  <y>81</y>
  <width>30</width>
  <height>80</height>
  <uuid>{08b1ff82-a829-4beb-8980-e5aef9bc2b25}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <objectName2>3</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1.00000000</yMax>
  <xValue>0.00000000</xValue>
  <yValue>0.52500000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <bordermode>noborder</bordermode>
  <borderColor>#00ff00</borderColor>
  <color>
   <r>0</r>
   <g>234</g>
   <b>0</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>30</r>
   <g>30</g>
   <b>30</b>
  </bgcolor>
  <bgcolormode>true</bgcolormode>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor0</objectName>
  <x>296</x>
  <y>81</y>
  <width>30</width>
  <height>80</height>
  <uuid>{ebf00514-6f7e-497c-91ae-5c9649e9f3f5}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <objectName2>4</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1.00000000</yMax>
  <xValue>0.00000000</xValue>
  <yValue>0.67500000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <bordermode>noborder</bordermode>
  <borderColor>#00ff00</borderColor>
  <color>
   <r>0</r>
   <g>234</g>
   <b>0</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>30</r>
   <g>30</g>
   <b>30</b>
  </bgcolor>
  <bgcolormode>true</bgcolormode>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>156</x>
  <y>165</y>
  <width>174</width>
  <height>22</height>
  <uuid>{b4ab9ac2-3b0c-4f0c-80f3-13afc55b9a0d}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <label>16'         8'          4'         2'         1'</label>
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
 <bsbObject version="2" type="BSBVSlider">
  <objectName>vibamp</objectName>
  <x>234</x>
  <y>205</y>
  <width>20</width>
  <height>100</height>
  <uuid>{a44720a0-8314-43f4-950d-80883d0129af}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.53000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>vibfreq</objectName>
  <x>307</x>
  <y>205</y>
  <width>20</width>
  <height>100</height>
  <uuid>{aabf0d2d-4541-463e-a412-f09c8583f7f8}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <minimum>0.00000000</minimum>
  <maximum>10.00000000</maximum>
  <value>4.60000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>totalVolume</objectName>
  <x>155</x>
  <y>205</y>
  <width>20</width>
  <height>100</height>
  <uuid>{001dcfc2-9df3-4d2b-9e04-3dc80e87bd32}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.79000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBLabel">
  <objectName/>
  <x>143</x>
  <y>313</y>
  <width>215</width>
  <height>31</height>
  <uuid>{611d8ad4-9d4e-4ac1-aa54-b5b2ea465ad5}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <label>volume              vib amp           vib speed</label>
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
</bsbPanel>
<bsbPresets>
</bsbPresets>
