/**
 * Author:    Albert Madrenys
 * Created:   12/10/2023
 * MU611A — Software Sound Synthesis
 * Csound: Music Programming Basics — Exercise 1
 **/

<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

0dbfs = 1
instr 1
  out oscili(p4, p5)
endin

schedule(1, 0.5 + 6*0, 0.5, 0dbfs/3, 554.37);
schedule(1, 1.0 + 6*0, 0.5, 0dbfs/3, 587.33);
schedule(1, 2.0 + 6*0, 0.5, 0dbfs/3, 880.00);
schedule(1, 2.5 + 6*0, 0.5, 0dbfs/3, 932.33);
schedule(1, 3.5 + 6*0, 0.5, 0dbfs/3, 587.33);
schedule(1, 4.0 + 6*0, 0.5, 0dbfs/3, 554.37);
schedule(1, 5.0 + 6*0, 0.5, 0dbfs/3, 1046.50);
schedule(1, 5.5 + 6*0, 0.5, 0dbfs/3, 932.33);

schedule(1, 0.0 + 6*0, 1.0, 0dbfs/3, 293.66);
schedule(1, 1.5 + 6*0, 1.0, 0dbfs/3, 349.23);
schedule(1, 3.0 + 6*0, 1.0, 0dbfs/3, 329.63);
schedule(1, 4.5 + 6*0, 1.0, 0dbfs/3, 392.00);

schedule(1, 0.5 + 6*1, 0.5, 0dbfs/2, 880.00);
schedule(1, 1.0 + 6*1, 0.5, 0dbfs/2, 1174.66);
schedule(1, 2.0 + 6*1, 0.5, 0dbfs/2, 932.33);
schedule(1, 2.5 + 6*1, 0.5, 0dbfs/2, 783.99);
schedule(1, 3.5 + 6*1, 0.5, 0dbfs/2, 659.25);
schedule(1, 4.0 + 6*1, 0.5, 0dbfs/2, 698.46);
schedule(1, 5.0 + 6*1, 0.5, 0dbfs/2, 880.00);
schedule(1, 5.5 + 6*1, 0.5, 0dbfs/2, 554.37);

schedule(1, 0.0 + 6*1, 1.0, 0dbfs/2, 349.23);
schedule(1, 1.5 + 6*1, 1.0, 0dbfs/2, 392.00);
schedule(1, 3.0 + 6*1, 1.0, 0dbfs/2, 349.23);
schedule(1, 4.5 + 6*1, 1.0, 0dbfs/2, 440.00);

schedule(1, 0.0 + 6*2, 2.0, 0dbfs/2, 440.00);
schedule(1, 2.0 + 6*2, 0.5, 0dbfs/2, 698.46);
schedule(1, 2.5 + 6*2, 0.5, 0dbfs/2, 587.33);
schedule(1, 3.0 + 6*2, 1.5, 0dbfs/2, 587.33);
schedule(1, 4.5 + 6*2, 1.0, 0dbfs/2, 554.37);

schedule(1, 0.0 + 6*2, 2.0, 0dbfs/2, 349.23);
schedule(1, 2.0 + 6*2, 0.5, 0dbfs/2, 440.00);
schedule(1, 2.5 + 6*2, 0.5, 0dbfs/2, 349.23);
schedule(1, 3.0 + 6*2, 1.5, 0dbfs/2, 466.16);
schedule(1, 4.5 + 6*2, 1.0, 0dbfs/2, 440.00);

schedule(1, 0.0 + 6*3, 2.0, 0dbfs/2, 440.00);
schedule(1, 2.0 + 6*3, 0.5, 0dbfs/2, 698.46);
schedule(1, 2.5 + 6*3, 0.5, 0dbfs/2, 587.33);
schedule(1, 3.0 + 6*3, 1.5, 0dbfs/2, 587.33);
schedule(1, 4.5 + 6*3, 1.0, 0dbfs/2, 554.37);

schedule(1, 0.0 + 6*3, 2.0, 0dbfs/2, 349.23);
schedule(1, 2.0 + 6*3, 0.5, 0dbfs/2, 440.00);
schedule(1, 2.5 + 6*3, 0.5, 0dbfs/2, 349.23);
schedule(1, 3.0 + 6*3, 1.5, 0dbfs/2, 466.16);
schedule(1, 4.5 + 6*3, 1.0, 0dbfs/2, 440.00);

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
 <bsbObject type="BSBScope" version="2">
  <objectName/>
  <x>30</x>
  <y>101</y>
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
