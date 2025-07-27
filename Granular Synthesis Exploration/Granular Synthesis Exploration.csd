/**
 * Author:    Albert Madrenys
 * Created:   16/12/2023
 * MU611A - Software Sound Synthesis
 * Granular Synthesis - Exercise 1
 **/
<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>
0dbfs = 1

// grain envelope
gife ftgen 0,0,16384,20,1,1
gifw ftgen 0,0,0,1,"flutec3.wav",0,0,1

instr 1
	pset 1, 0, 1, 0dbfs*0.2, 1, 1, 1, 1, 2, 2, 0.02, 0.02
	ia  = p4 // amplitude
	kpitch line p5, p3, p6 // pitch ratio
	ktime line p7, p3, p8 // time ratio
	kols line p9, p3, p10 // grain overlaps
	kgd line p11, p3, p12 // grain duration
	
	kps = ktime/kols // pointer rate
	kds = kols/kgd // grain density (grains/sec)
  	asig syncgrain ia, kds, kpitch, kgd, kps, gifw, gife, 3
  aenv linen asig, 0.1, p3, 0.05
  out aenv
endin

schedule(1, 0,  3,  0.2, 1,    1,    0.5,  0.5,  2,   0.1, 0.3,  0.02)
schedule(1, 4,  7,  0.2, 1,    0.8,  0.5,  0.5,  2,   0.1, 0.3,  0.02)
schedule(1, 12, 7,  0.2, 0.25, 0.40, 0.5,  0.5,  1,   0.1, 0.1,  0.1)
schedule(1, 16, 7,  0.2, 1.2,  0.8,  0.5,  0.5,  1,   0.1, 0.1,  0.05)
schedule(1, 20, 10, 0.2, 1.2,  0.8,  0.5,  0.5,  1,   0.1, 0.1,  0.05)
schedule(1, 20, 10, 0.2, 1.5,  0.8,  0.5,  0.5,  1,   0.1, 0.1,  0.05)
schedule(1, 23, 12, 0.2, 0.4,  0.6,  0.5,  0.5,  0.5, 1.5, 0.1,  0.1)
schedule(1, 25, 20, 0.2, 0.1,  0.1,  0.25, 0.25, 2,   0.5, 0.3,  0.3)
schedule(1, 28, 10, 0.2, 0.4,  0.7,  0.25, 0.25, 0.5, 0.5, 0.05, 0.3)
schedule(1, 30, 10, 0.2, 1.8,  0.7,  0.25, 0.25, 1,   2,   0.03, 0.1)
schedule(1, 32, 13, 0.2, 0.7,  0.1,  0.25, 0.25, 0.7, 0.6, 0.1,  0.05)
schedule(1, 35, 14, 0.2, 0.8,  0.8,  0.25, 0.25, 0.5, 0.5, 0.5,  0.5)
schedule(1, 37, 15, 0.2, 1.2,  1.6,  0.25, 0.25, 1,   2,   0.3,  0.05)
schedule(1, 39, 10, 0.2, 1.6,  1.2,  0.25, 0.25, 0.5, 0.5, 0.05, 0.3)
schedule(1, 36, 20, 0.2, 2,    0.2,  0.2,  0.2,  2,   1.5, 0.1,  0.03)

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>
























<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>0</x>
 <y>0</y>
 <width>523</width>
 <height>439</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
 <bsbObject type="BSBScope" version="2">
  <objectName/>
  <x>173</x>
  <y>289</y>
  <width>350</width>
  <height>150</height>
  <uuid>{2f8d5ff8-3459-4397-99b8-e6cc60c2b06f}</uuid>
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
</bsbPanel>
<bsbPresets>
</bsbPresets>
