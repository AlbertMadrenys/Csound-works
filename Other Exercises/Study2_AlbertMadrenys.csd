/**
 * Author:    Albert Madrenys
 * Created:   12/10/2023
 * MU611A — Software Sound Synthesis
 * Csound: Music Programming Basics — Exercise 2
 **/

<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

0dbfs = 1

instr 1
	asig  oscili  p4, p5
	aenv linen asig, 0.1, p3, 0.1
	out aenv
endin

instr 2
	a1 vco2 p4, p5
	a2 vco2 p4, p5*1.002
	a3 vco2 p4, p5*0.998
	a4 vco2 p4, p5*1.004
	a5 vco2 p4, p5*0.996
	a6 vco2 p4, p5*1.006
	a7 vco2 p4, p5*0.994
	
	amix = (a1+a2+a3+a4+a5+a6+a7)*0.142
	asig linen amix, 0.01, p3, 0.1
	out asig
endin

/* Bar 1 */

; Line 1
schedule(2, 0.00 + 2.5*00, 0.75, 0dbfs/3, 110.00);
schedule(2, 0.75 + 2.5*00, 0.75, 0dbfs/3, 110.00);
schedule(2, 1.50 + 2.5*00, 0.50, 0dbfs/3, 110.00);
schedule(2, 2.00 + 2.5*00, 0.50, 0dbfs/3, 110.00);

schedule(2, 0.00 + 2.5*01, 0.75, 0dbfs/3, 130.81);
schedule(2, 0.75 + 2.5*01, 0.75, 0dbfs/3, 130.81);
schedule(2, 1.50 + 2.5*01, 0.50, 0dbfs/3, 130.81);
schedule(2, 2.00 + 2.5*01, 0.50, 0dbfs/3, 130.81);

schedule(2, 0.00 + 2.5*02, 0.75, 0dbfs/3, 098.00);
schedule(2, 0.75 + 2.5*02, 0.75, 0dbfs/3, 098.00);
schedule(2, 1.50 + 2.5*02, 0.50, 0dbfs/3, 098.00);
schedule(2, 2.00 + 2.5*02, 0.50, 0dbfs/3, 098.00);

schedule(2, 0.00 + 2.5*03, 0.75, 0dbfs/3, 087.31);
schedule(2, 0.75 + 2.5*03, 0.75, 0dbfs/3, 087.31);
schedule(2, 1.50 + 2.5*03, 0.50, 0dbfs/3, 087.31);
schedule(2, 2.00 + 2.5*03, 0.50, 0dbfs/3, 098.00);

/* Bar 2 */

; Line 1
schedule(2, 0.00 + 2.5*04, 0.75, 0dbfs/3, 110.00);
schedule(2, 0.75 + 2.5*04, 0.75, 0dbfs/3, 110.00);
schedule(2, 1.50 + 2.5*04, 0.50, 0dbfs/3, 110.00);
schedule(2, 2.00 + 2.5*04, 0.50, 0dbfs/3, 110.00);

schedule(2, 0.00 + 2.5*05, 0.75, 0dbfs/3, 130.81);
schedule(2, 0.75 + 2.5*05, 0.75, 0dbfs/3, 130.81);
schedule(2, 1.50 + 2.5*05, 0.50, 0dbfs/3, 130.81);
schedule(2, 2.00 + 2.5*05, 0.50, 0dbfs/3, 130.81);

schedule(2, 0.00 + 2.5*06, 0.75, 0dbfs/3, 098.00);
schedule(2, 0.75 + 2.5*06, 0.75, 0dbfs/3, 098.00);
schedule(2, 1.50 + 2.5*06, 0.50, 0dbfs/3, 098.00);
schedule(2, 2.00 + 2.5*06, 0.50, 0dbfs/3, 098.00);

schedule(2, 0.00 + 2.5*07, 0.75, 0dbfs/3, 087.31);
schedule(2, 0.75 + 2.5*07, 0.75, 0dbfs/3, 087.31);
schedule(2, 1.50 + 2.5*07, 0.50, 0dbfs/3, 087.31);
schedule(2, 2.00 + 2.5*07, 0.50, 0dbfs/3, 098.00);

; Line 2
schedule(2, 0.00 + 2.5*04, 1.50, 0dbfs/3, 261.63);
schedule(2, 1.50 + 2.5*04, 1.00, 0dbfs/3, 329.63);

schedule(2, 0.00 + 2.5*05, 1.50, 0dbfs/3, 392.00);
schedule(2, 1.50 + 2.5*05, 1.00, 0dbfs/3, 329.63);

schedule(2, 0.00 + 2.5*06, 1.50, 0dbfs/3, 392.00);
schedule(2, 1.50 + 2.5*06, 1.00, 0dbfs/3, 329.63);

schedule(2, 0.00 + 2.5*07, 1.50, 0dbfs/3, 392.00);
schedule(2, 1.50 + 2.5*07, 1.00, 0dbfs/3, 329.63);

/* Bar 3 */

; Line 1
schedule(2, 0.00 + 2.5*08, 0.75, 0dbfs/3, 110.00);
schedule(2, 0.75 + 2.5*08, 0.75, 0dbfs/3, 110.00);
schedule(2, 1.50 + 2.5*08, 0.50, 0dbfs/3, 110.00);
schedule(2, 2.00 + 2.5*08, 0.50, 0dbfs/3, 110.00);

schedule(2, 0.00 + 2.5*09, 0.75, 0dbfs/3, 130.81);
schedule(2, 0.75 + 2.5*09, 0.75, 0dbfs/3, 130.81);
schedule(2, 1.50 + 2.5*09, 0.50, 0dbfs/3, 130.81);
schedule(2, 2.00 + 2.5*09, 0.50, 0dbfs/3, 130.81);

schedule(2, 0.00 + 2.5*10, 0.75, 0dbfs/3, 098.00);
schedule(2, 0.75 + 2.5*10, 0.75, 0dbfs/3, 098.00);
schedule(2, 1.50 + 2.5*10, 0.50, 0dbfs/3, 098.00);
schedule(2, 2.00 + 2.5*10, 0.50, 0dbfs/3, 098.00);

schedule(2, 0.00 + 2.5*11, 0.75, 0dbfs/3, 087.31);
schedule(2, 0.75 + 2.5*11, 0.75, 0dbfs/3, 087.31);
schedule(2, 1.50 + 2.5*11, 0.50, 0dbfs/3, 087.31);
schedule(2, 2.00 + 2.5*11, 0.50, 0dbfs/3, 098.00);

; Line 2
schedule(2, 0.00 + 2.5*08, 1.50, 0dbfs/3, 261.63);
schedule(2, 1.50 + 2.5*08, 1.00, 0dbfs/3, 329.63);

schedule(2, 0.00 + 2.5*09, 1.50, 0dbfs/3, 392.00);
schedule(2, 1.50 + 2.5*09, 1.00, 0dbfs/3, 329.63);

schedule(2, 0.00 + 2.5*10, 1.50, 0dbfs/3, 392.00);
schedule(2, 1.50 + 2.5*10, 1.00, 0dbfs/3, 329.63);

schedule(2, 0.00 + 2.5*11, 1.50, 0dbfs/3, 392.00);
schedule(2, 1.50 + 2.5*11, 1.00, 0dbfs/3, 329.63);

; Line 3

schedule(1, 0.25 + 2.5*08, 0.25, 0dbfs/3, 523.25);
schedule(1, 0.50 + 2.5*08, 0.25, 0dbfs/3, 587.33);
schedule(1, 1.00 + 2.5*08, 0.25, 0dbfs/3, 587.33);
schedule(1, 1.25 + 2.5*08, 0.25, 0dbfs/3, 659.25);
schedule(1, 1.75 + 2.5*08, 0.25, 0dbfs/3, 659.25);
schedule(1, 2.25 + 2.5*08, 0.25, 0dbfs/3, 880.00);

schedule(1, 0.25 + 2.5*09, 0.25, 0dbfs/3, 523.25);
schedule(1, 0.50 + 2.5*09, 0.25, 0dbfs/3, 587.33);
schedule(1, 1.00 + 2.5*09, 0.25, 0dbfs/3, 587.33);
schedule(1, 1.25 + 2.5*09, 0.25, 0dbfs/3, 659.25);
schedule(1, 1.75 + 2.5*09, 0.25, 0dbfs/3, 659.25);
schedule(1, 2.25 + 2.5*09, 0.25, 0dbfs/3, 783.99);

schedule(1, 0.25 + 2.5*10, 0.25, 0dbfs/3, 493.88);
schedule(1, 0.50 + 2.5*10, 0.25, 0dbfs/3, 523.25);
schedule(1, 1.00 + 2.5*10, 0.25, 0dbfs/3, 523.25);
schedule(1, 1.25 + 2.5*10, 0.25, 0dbfs/3, 587.33);
schedule(1, 1.75 + 2.5*10, 0.25, 0dbfs/3, 587.33);
schedule(1, 2.25 + 2.5*10, 0.25, 0dbfs/3, 698.46);

schedule(1, 0.25 + 2.5*11, 0.25, 0dbfs/3, 440.00);
schedule(1, 0.50 + 2.5*11, 0.25, 0dbfs/3, 493.88);
schedule(1, 1.00 + 2.5*11, 0.25, 0dbfs/3, 493.88);
schedule(1, 1.25 + 2.5*11, 0.25, 0dbfs/3, 523.25);
schedule(1, 1.75 + 2.5*11, 0.25, 0dbfs/3, 523.25);
schedule(1, 2.25 + 2.5*11, 0.25, 0dbfs/3, 880.00);

/* Bar 4 */

; Line 1
schedule(2, 0.00 + 2.5*12, 0.75, 0dbfs/3, 110.00);
schedule(2, 0.75 + 2.5*12, 0.75, 0dbfs/3, 110.00);
schedule(2, 1.50 + 2.5*12, 0.50, 0dbfs/3, 110.00);
schedule(2, 2.00 + 2.5*12, 0.50, 0dbfs/3, 110.00);

schedule(2, 0.00 + 2.5*13, 0.75, 0dbfs/3, 130.81);
schedule(2, 0.75 + 2.5*13, 0.75, 0dbfs/3, 130.81);
schedule(2, 1.50 + 2.5*13, 0.50, 0dbfs/3, 130.81);
schedule(2, 2.00 + 2.5*13, 0.50, 0dbfs/3, 130.81);

schedule(2, 0.00 + 2.5*14, 0.75, 0dbfs/3, 098.00);
schedule(2, 0.75 + 2.5*14, 0.75, 0dbfs/3, 098.00);
schedule(2, 1.50 + 2.5*14, 0.50, 0dbfs/3, 098.00);
schedule(2, 2.00 + 2.5*14, 0.50, 0dbfs/3, 098.00);

schedule(2, 0.00 + 2.5*15, 0.75, 0dbfs/3, 087.31);
schedule(2, 0.75 + 2.5*15, 0.75, 0dbfs/3, 087.31);
schedule(2, 1.50 + 2.5*15, 0.50, 0dbfs/3, 087.31);
schedule(2, 2.00 + 2.5*15, 0.50, 0dbfs/3, 098.00);

; Line 3

schedule(1, 0.25 + 2.5*12, 0.25, 0dbfs/3, 523.25);
schedule(1, 0.50 + 2.5*12, 0.25, 0dbfs/3, 587.33);
schedule(1, 1.00 + 2.5*12, 0.25, 0dbfs/3, 587.33);
schedule(1, 1.25 + 2.5*12, 0.25, 0dbfs/3, 659.25);
schedule(1, 1.75 + 2.5*12, 0.25, 0dbfs/3, 659.25);
schedule(1, 2.25 + 2.5*12, 0.25, 0dbfs/3, 880.00);

schedule(1, 0.25 + 2.5*13, 0.25, 0dbfs/3, 523.25);
schedule(1, 0.50 + 2.5*13, 0.25, 0dbfs/3, 587.33);
schedule(1, 1.00 + 2.5*13, 0.25, 0dbfs/3, 587.33);
schedule(1, 1.25 + 2.5*13, 0.25, 0dbfs/3, 659.25);
schedule(1, 1.75 + 2.5*13, 0.25, 0dbfs/3, 659.25);
schedule(1, 2.25 + 2.5*13, 0.25, 0dbfs/3, 783.99);

schedule(1, 0.25 + 2.5*14, 0.25, 0dbfs/3, 493.88);
schedule(1, 0.50 + 2.5*14, 0.25, 0dbfs/3, 523.25);
schedule(1, 1.00 + 2.5*14, 0.25, 0dbfs/3, 523.25);
schedule(1, 1.25 + 2.5*14, 0.25, 0dbfs/3, 587.33);
schedule(1, 1.75 + 2.5*14, 0.25, 0dbfs/3, 587.33);
schedule(1, 2.25 + 2.5*14, 0.25, 0dbfs/3, 698.46);

schedule(1, 0.25 + 2.5*15, 0.25, 0dbfs/3, 440.00);
schedule(1, 0.50 + 2.5*15, 0.25, 0dbfs/3, 493.88);
schedule(1, 1.00 + 2.5*15, 0.25, 0dbfs/3, 493.88);
schedule(1, 1.25 + 2.5*15, 0.25, 0dbfs/3, 523.25);
schedule(1, 1.75 + 2.5*15, 0.25, 0dbfs/3, 523.25);
schedule(1, 2.25 + 2.5*15, 0.25, 0dbfs/3, 880.00);

/* Bar 5 (final chord) */

schedule(2, 0 + 2.5*16, 2.00, 0dbfs/4, 110.00);
schedule(2, 0 + 2.5*16, 2.00, 0dbfs/4, 329.63);
schedule(2, 0 + 2.5*16, 2.00, 0dbfs/4, 523.25);
schedule(1, 0 + 2.5*16, 2.00, 0dbfs/4, 880.00);

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>
















<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>0</x>
 <y>0</y>
 <width>539</width>
 <height>270</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="background">
  <r>240</r>
  <g>240</g>
  <b>240</b>
 </bgcolor>
 <bsbObject version="2" type="BSBScope">
  <objectName/>
  <x>10</x>
  <y>88</y>
  <width>350</width>
  <height>150</height>
  <uuid>{fa056e34-4263-4a32-8a84-a6193dfbe4e3}</uuid>
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
