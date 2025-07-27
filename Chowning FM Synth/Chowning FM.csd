/**
 * Author:    Albert Madrenys
 * Created:   01/12/2023
 * MU611A — Software Sound Synthesis
 * Non-Linear Distortion: FM synthesis — Exercise 1
 **/
<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>
0dbfs = 1

gibrass ftgen 0, 0.6, 128, 7, 0, 21, 1, 21, 0.75, 64, 0.625, 22, 0
giwoodamp ftgen 0, 0.5, 128, 5, 0.0001, 25, 1, 90, 1, 13, 0.0001
giwoodtim ftgen 0, 0.5, 128, 5, 0.0001, 25, 1, 103, 1
gibell ftgen 0, 15, 512, 5, 1, 512, 0.000001
gidrum ftgen 0, 0.2, 128, 8, 0.8, 32, 1, 32, 0.2, 32, 0
giwooddrumtim ftgen 0, 0.2, 128, 7, 1, 16, 0

instr 1
	idur = p3 // duration
	iamp = p4 // amplitude
	ifc = p5 // carrier freq
	ifm = p6 // modulating freq
	ii1 = p7 // modulation index 1
	ii2 = p8 // modulation index 2
	
	// We use two extra p-values that Chowning doesn't define, but we need them to send the correct envelope function tables
	ifna = p9 // amplitude envelope function table
	ifnb = p10 // timbre envelope function table
	
	aamp oscili iamp, 1/idur, ifna
	aienv oscili (ii2-ii1)*ifm, 1/idur, ifnb
	 
	amod oscili ii1*ifm + aienv, ifm // No cosines, Chowning use sines
	acar oscili aamp, ifc + amod
      out acar
endin

//p4 (amplitude) is arbitrary in Chowning's paper
schedule(1, 0, 0.6, 0dbfs*0.5, 440, 440, 0, 5, gibrass, gibrass) // Trumpet
schedule(1, 1, 0.5, 0dbfs*0.5, 900, 300.5, 0, 2, giwoodamp, giwoodtim) // Oboe
schedule(1, 2, 0.5, 0dbfs*0.5, 500, 100.5, 0, 1.5, giwoodamp, giwoodtim) // Basson
schedule(1, 3, 0.5, 0dbfs*0.5, 900, 600.5, 4, 2, giwoodamp, giwoodtim) // Clarinet
schedule(1, 4, 0.2, 0dbfs*0.5, 200, 280, 0, 2, gidrum, gidrum) // Drum
schedule(1, 5, 0.2, 0dbfs*0.5, 80, 55, 0, 25, gidrum, giwooddrumtim) // Wood-drum
schedule(1, 6, 15, 0dbfs*0.5, 200, 280, 0, 10, gibell, gibell) // Bell


</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>




















<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>0</x>
 <y>0</y>
 <width>355</width>
 <height>158</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
 <bsbObject type="BSBScope" version="2">
  <objectName/>
  <x>5</x>
  <y>8</y>
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
</bsbPanel>
<bsbPresets>
</bsbPresets>
