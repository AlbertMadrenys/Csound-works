/**
 * Author:    Albert Madrenys
 * Created:   26/11/2023
 * MU611A — Software Sound Synthesis
 * Substractive Synthesis — Exercise 1
 **/
<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>
0dbfs = 1

instr 1
	pset 1, 0, 1, 440, 0.5, 8
 	iamp = p4
 	kfr cpsmidinn p5
 	
 	kcf_max = p6*kfr // MAX CF p6 times the fundamental (default is 8)
	kcf_min = kfr	// MIN CF 1 time the fundamental
 	iq = 0.7
	kenv madsr   0.1, 0.02, 0.8, 0.2
 	kcf = kenv*(kcf_max - kcf_min) + kcf_min
 	kamp = kenv*iamp*0.2 // source is a saw waveform
 	asig vco2 kamp, kfr
 	
 	// The first filter is a second-order resonant, followed in series by a 
 	// Moog Diode Ladder lowpass and a Sallen-Key highpass, both in parallel
 	// Moog cuttof will be on half of the center freq, while Sallen-Key will be on the double
 	ares reson asig, kcf, kcf/iq, 1
 	amoog moogvcf2 ares, kcf/iq*0.5, 0.2
 	asallen skf ares, kcf/iq*2, 1
  	out (balance(amoog+asallen, ares)) 
endin

instr 2
	anoise rand expseg(1,p3,0.001)
	afilt  reson anoise, p5, p6, 2
 	out afilt*p4
endin

ibpm = 95 // beats per minute
ibeatDur = 60/ibpm // beat duration
ibarDur = ibeatDur * 4 // bar duration (4/4 time sig)

ibarNum = 0
while ibarNum < 20 do
	// Main chord
	if ibarNum < 18 then
	ibeatNum = 0
	if ibarNum%2 == 0 then
		while ibeatNum < 4 do
			// I know that there's useless multiplications by 0, but it's easier to read and understand the delay calculations
			schedule(1, 0.00*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.20, 62)
			schedule(1, 0.50*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.15, 62)
			schedule(1, 0.00*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.2, 65)
			schedule(1, 0.50*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.15, 65)
			schedule(1, 0.00*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.2, 69)
			schedule(1, 0.50*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.15, 69)
			schedule(1, 0.00*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.2, 72)
			schedule(1, 0.50*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.15, 72)
			ibeatNum += 1
		od
	else
		if ibarNum%4 == 3 then
			iopeningIncr = 4
			icffactor = 0.5
		else
			iopeningIncr = 0
			icffactor = 8
		endif
		while ibeatNum < 4 do
			schedule(1, 0.00*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.2, 60, icffactor)
			schedule(1, 0.50*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.15, 60, icffactor+iopeningIncr*0.5)
			schedule(1, 0.00*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.2, 64, icffactor)
			schedule(1, 0.50*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.15, 64, icffactor+iopeningIncr*0.5)
			schedule(1, 0.00*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.2, 67, icffactor)
			schedule(1, 0.50*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.15, 67, icffactor+iopeningIncr*0.5)
			schedule(1, 0.00*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.2, 71, icffactor)
			schedule(1, 0.50*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, ibeatDur*0.25, 0.15, 71, icffactor+iopeningIncr*0.5)
			ibeatNum += 1
			icffactor += iopeningIncr
		od
	endif
	endif
	
	// Bass drum and snare
	if ibarNum > 3 then
	schedule(2, 0.00*ibeatDur + 0*ibeatDur + ibarNum*ibarDur, 0.4, 0.7, 80, 20)
	schedule(2, 0.00*ibeatDur + 1*ibeatDur + ibarNum*ibarDur, 0.3, 0.3, 380, 1200)
	schedule(2, 0.75*ibeatDur + 1*ibeatDur + ibarNum*ibarDur, 0.3, 0.3, 380, 1200)
	schedule(2, 0.00*ibeatDur + 2*ibeatDur + ibarNum*ibarDur, 0.4, 0.7, 75, 50)
	schedule(2, 0.50*ibeatDur + 2*ibeatDur + ibarNum*ibarDur, 0.4, 0.7, 75, 50)
	schedule(2, 0.00*ibeatDur + 3*ibeatDur + ibarNum*ibarDur, 0.3, 0.3, 380, 1200)
	schedule(2, 0.50*ibeatDur + 3*ibeatDur + ibarNum*ibarDur, 0.4, 0.7, 75, 50)
	endif
	
	// Melody
	if ibarNum > 7 then
	if ibarNum%2 == 0 then
	schedule(1, 0.00*ibeatDur + 1*ibeatDur + ibarNum*ibarDur, ibeatDur*0.2, 0.2, 81)
	schedule(1, 0.25*ibeatDur + 1*ibeatDur + ibarNum*ibarDur, ibeatDur*0.2, 0.2, 79)
	schedule(1, 0.75*ibeatDur + 1*ibeatDur + ibarNum*ibarDur, ibeatDur*0.2, 0.2, 81)
	schedule(1, 0.00*ibeatDur + 2*ibeatDur + ibarNum*ibarDur, ibeatDur*0.2, 0.2, 77)
	schedule(1, 0.50*ibeatDur + 2*ibeatDur + ibarNum*ibarDur, ibeatDur*0.2, 0.2, 81)
	schedule(1, 0.75*ibeatDur + 2*ibeatDur + ibarNum*ibarDur, ibeatDur*0.2, 0.2, 76)
	else
	schedule(1, 0.00*ibeatDur + 1*ibeatDur + ibarNum*ibarDur, ibeatDur*0.2, 0.2, 81)
	schedule(1, 0.25*ibeatDur + 1*ibeatDur + ibarNum*ibarDur, ibeatDur*0.2, 0.2, 79)
	schedule(1, 0.75*ibeatDur + 1*ibeatDur + ibarNum*ibarDur, ibeatDur*0.2, 0.2, 81)
	schedule(1, 0.00*ibeatDur + 2*ibeatDur + ibarNum*ibarDur, ibeatDur*0.2, 0.2, 77)
	schedule(1, 0.50*ibeatDur + 2*ibeatDur + ibarNum*ibarDur, ibeatDur*0.2, 0.2, 81)
	schedule(1, 0.75*ibeatDur + 2*ibeatDur + ibarNum*ibarDur, ibeatDur*0.2, 0.2, 76)
	schedule(1, 0.25*ibeatDur + 3*ibeatDur + ibarNum*ibarDur, ibeatDur*0.4, 0.2, 81)
	endif
	endif
	
	// Charles
	if ibarNum > 11 && ibarNum < 18 then
	ibeatNum = 0
	while ibeatNum < 4 do
		schedule(2, 0.00*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, 0.07, 0.1, 4000, 2000)
		schedule(2, 0.50*ibeatDur + ibeatNum*ibeatDur + ibarNum*ibarDur, 0.07, 0.1, 4000, 2000)
		
		ibeatNum += 1
	od
	endif
	
	// Bass
	if ibarNum > 11 then
	if ibarNum%2 == 0 then
	schedule(1, 0*ibeatDur + ibarNum*ibarDur, ibeatDur*4, 0.8, 38)
	else
	schedule(1, 0*ibeatDur + ibarNum*ibarDur, ibeatDur*2, 0.8, 36)
	schedule(1, 2*ibeatDur + ibarNum*ibarDur, ibeatDur*1, 0.8, 41)
	schedule(1, 3*ibeatDur + ibarNum*ibarDur, ibeatDur*1, 0.8, 36)
	endif
	endif
	
	ibarNum += 1
od

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>


















<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>0</x>
 <y>0</y>
 <width>0</width>
 <height>0</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
