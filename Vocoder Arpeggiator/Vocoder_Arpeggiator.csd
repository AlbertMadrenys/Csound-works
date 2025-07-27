////////////////////////////////////////////////////////////////////
// Title: Vocoder Arpeggiator
// Author: Albert Madrenys Planas
// 
// MU616A[A] — Musical Signal Processing — Final Project
// Maynooth University
/////////////////////////////////////////////////////////////////////

<Cabbage> bounds(0, 0, 0, 0)
form caption("Vocoder Arpeggiator") size(500, 310), guiMode("queue"), pluginId("VocA"), colour(227,222,200)
keyboard bounds(14, 196, 473, 95) channel("keyboard") whiteNoteColour(242, 198, 101, 255) mouseOverKeyColour(239,117,70)

image bounds(16, 22, 40, 40) channel("image10009") shape("circle") colour(0, 0, 0, 255)
checkbox bounds(22, 28, 30, 30) channel("playing")  shape("circle") colour:1(0, 0, 0, 255) colour:0(202, 60, 74, 255)
label bounds(64, 34, 152, 17) channel("playingLabel") fontColour(0, 0, 0, 255) align("left") text("Capturing notes")

checkbox bounds(20, 90, 29, 28) channel("lowCPUMode") alpha(0.92) colour:1(239, 117, 70, 255)
label bounds(66, 96, 142, 17) channel("label10011") fontColour(0, 0, 0, 255) text("CPU Save Mode") align("left")

filebutton bounds(224, 20, 100, 40) channel("loadFile") text("Import file", "Import file")
button bounds(364, 20, 100, 40) channel("removeFile") text("Remove file", "Remove file")

label bounds(14, 146, 177, 20) channel("numNotesCaptured") fontColour(0, 0, 0, 255) align("left") text("0 notes captured")
label bounds(16, 170, 450, 15) channel("filenameLabel") fontColour(0, 0, 0, 255) align("left") text("Using microphone")

rslider bounds(244, 74, 60, 60) channel("harmSpeed") range(0, 0.2, 0, 1, 0.001) trackerColour(153, 190, 183, 255) outlineColour(0, 0, 0, 255) colour(242, 198, 101, 255) markerColour(0, 0, 0, 255) fontColour(0, 0, 0, 255) textColour(0, 0, 0, 255)
rslider bounds(382, 74, 60, 60) channel("cutFreq") range(2, 14, 8, 1, 0.001) trackerColour(153, 190, 183, 255) outlineColour(0, 0, 0, 255) colour(242, 198, 101, 255) markerColour(0, 0, 0, 255) fontColour(0, 0, 0, 255) textColour(0, 0, 0, 255)
label bounds(204, 148, 140, 17) channel("label10012") fontColour(0, 0, 0, 255) text("Arpeggio Delay")
label bounds(346, 148, 140, 17) channel("label10013") fontColour(0, 0, 0, 255) text("Low-pass Cutoff")

</Cabbage>

<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0
</CsOptions>

<CsInstruments>

nchnls = 2
0dbfs = 1

; Note capturing variables
gimaxNotes init 5
gknoteArray[] init gimaxNotes
gkcurrentNotes init 0

; State of the program
gkplaying init 0
gkfile init 0
gSfilename init ""

; Channels
chn_k "harmSpeed", 1
chn_k "cutFreq", 1
chn_k "lowCPUMode", 1
chn_k "playing", 3
chn_k "removeFile", 3
chn_S "loadFile", 3
chn_k "keyboard", 2
chn_k "numNotesCaptured", 2
chn_k "filenameLabel", 2
chn_k "playingLabel", 2

; Instrument to handle channels
schedule("ChnHandler", 0, -1)
instr ChnHandler
    Sfile, kfileTrig cabbageGetValue "loadFile"
    if kfileTrig == 1 && strlenk(Sfile) > 0 then
        schedulek "FileOn", 0, -1
    endif
    
    kremVal, kremTrig cabbageGetValue "removeFile"
    if kremTrig == 1 && kremVal == 1 then
	    schedulek "FileOff", 0, -1
    endif
    
    kplayVal, kplayTrig cabbageGetValue "playing"
    if kplayTrig == 1 then
	    if kplayVal == 1 then
	        schedulek "StartPlay", 0, -1
	    else
	        schedulek "StopPlay", 0, -1
	    endif
    endif
endin

; All of the following instruments have to be scheduled with -1 duration,
;   since they handle global k-variables. They will turn off themselves.

; Start playing a file instead of the mic
instr FileOn
    gSfilename cabbageGetValue "loadFile"
    gkfile = 1
    cabbageSet "filenameLabel", "text", gSfilename
    turnoff2 100, 0, 0
    turnoff
endin

; Stop using the file and instead use the mic
instr FileOff
    gSfilename strcpyk ""
    chnset gSfilename, "loadFile"
    cabbageSet "filenameLabel", "text", "Using microphone"
    gkfile = 0
    turnoff2 100, 0, 0
    turnoff
endin

; Start playing and stop capturing notes
instr StartPlay
    gkplaying = 1
    cabbageSetValue "playing", 1, 1
    cabbageSet "keyboard", "whiteNoteColour", 153, 190, 183
    cabbageSet "playingLabel", "text", "Playing"
    turnoff2 100, 0, 0
    turnoff
endin

; Stop playing and return to capturing notes
instr StopPlay
    gkcurrentNotes = 0
    gkplaying = 0
    cabbageSetValue "playing", 0, 1
    cabbageSet "keyboard", "whiteNoteColour", 242, 198, 101
    cabbageSet "numNotesCaptured", "text", "0 notes captured"
    cabbageSet "playingLabel", "text", "Capturing notes"
    turnoff2 100, 0, 0
    turnoff
endin

; Capture new note with frequency in p4
instr AddNote
    gknoteArray[gkcurrentNotes] = p4
    gkcurrentNotes = gkcurrentNotes+1
    Sformatted sprintfk "%.0f notes captured", gkcurrentNotes
    cabbageSet 1, "numNotesCaptured", "text", Sformatted;strcat(S5, " notes captured")
    if gkcurrentNotes == gimaxNotes then
        schedulek "StartPlay", 0, -1
    endif
    turnoff2 100, 0, 0
    turnoff
endin

;MIDI Instrument
massign 1, 100
instr 100
    iamp ampmidi 0dbfs
    kfreq cpsmidib 2
    
    if gkplaying == 0 then
        schedulek "AddNote", 0, -1, kfreq ; capture new note if not playing
        
    elseif gkplaying == 1 then
        
        ; delay
        imaxdel init 1
        kdel init 0.5
        krel release
        if krel == 0 then ; no modifying the delay if the instrument is releasing
            kdel cabbageGetValue "harmSpeed" 
        endif
        
        ; input
        if strlen(gSfilename) > 0 then
            inumChn filenchnls gSfilename
            ain[] init inumChn
            ain diskin gSfilename, 1, 0, 1
        else
            ain[] init 2
            ain[0], ain[1] ins
        endif
        
        ; release time
        asig linenr ain[0], 0.1, 0.1, 0.01
        xtratim gimaxNotes*imaxdel+2/sr ; adding 2 samples because of the Butterworth filter
        
        ; frequency scaling
        kscal[] init gimaxNotes
        ki = 0
        while ki < gkcurrentNotes do
        
            kscal[ki] = gknoteArray[ki]/gknoteArray[0]
            
            if kfreq*kscal[ki] < 16 || kfreq*kscal[ki] > 1046 then ; limiting range from C0 to C6 notes
                kscal[ki] = 0
            endif
            ki = ki+1
        od
        
        ; If imode == 0, every note in the arpeggio will consist in their own carrier signal and analysis.
        ;   Use for better results at higher frequencies.
        ; If imode == 1, every note in the arpeggio will be a pitch scaled version of the fundamental.
        ;   Use for less CPU usage.
        imode chnget "lowCPUMode"
        
        avco[] init gimaxNotes
        avco[0] = vco2(iamp, kfreq*kscal[0])
        if imode==0 then 
            avco[1] = vco2(iamp, kfreq*kscal[1])
            avco[2] = vco2(iamp, kfreq*kscal[2])
            avco[3] = vco2(iamp, kfreq*kscal[3])
            avco[4] = vco2(iamp, kfreq*kscal[4])
        endif
        
        ; analysis
        isiz = 2048
        fsource pvsanal asig, isiz, isiz/4, isiz, 0 ; modulator analysis
        fcar0 pvsanal avco[0], isiz, isiz/4, isiz, 0 ; carrier analysis
        if imode==0 then 
            fcar1 pvsanal avco[1], isiz, isiz/4, isiz, 0
            fcar2 pvsanal avco[2], isiz, isiz/4, isiz, 0
            fcar3 pvsanal avco[3], isiz, isiz/4, isiz, 0
            fcar4 pvsanal avco[4], isiz, isiz/4, isiz, 0
        endif
        
        ; vocoder
        fvoc0 pvsvoc  fsource,  fcar0, 1, 1, 100
        if imode==0 then
            fvoc1 pvsvoc  fsource, fcar1, 1, 1, 100
            fvoc2 pvsvoc  fsource, fcar2, 1, 1, 100
            fvoc3 pvsvoc  fsource, fcar3, 1, 1, 100
            fvoc4 pvsvoc  fsource, fcar4, 1, 1, 100
        else
            fvoc1 pvscale fvoc0, kscal[1], 1 ; pitch scale
            fvoc2 pvscale fvoc0, kscal[2], 1
            fvoc3 pvscale fvoc0, kscal[3], 1
            fvoc4 pvscale fvoc0, kscal[4], 1
        endif
        
        ; resynthesise
        arec[] init gimaxNotes
        arec[0] pvsynth fvoc0
        arec[1] pvsynth fvoc1
        arec[2] pvsynth fvoc2
        arec[3] pvsynth fvoc3
        arec[4] pvsynth fvoc4
        
        ; variable delay to create the arpeggio effect
        adel[] init gimaxNotes
        adel[0] = arec [0]
        adel[1] vdelay arec[1], 1000*kdel*1, 1000*imaxdel
        adel[2] vdelay arec[2], 1000*kdel*2, 1000*imaxdel
        adel[3] vdelay arec[3], 1000*kdel*3, 1000*imaxdel
        adel[4] vdelay arec[4], 1000*kdel*4, 1000*imaxdel
        
        ; low-pass filter
        kcf chnget "cutFreq"
        alp[] init gimaxNotes
        alp[0] = butterlp(adel[0], kfreq*kscal[0]*kcf)
        alp[1] = butterlp(adel[1], kfreq*kscal[1]*kcf)
        alp[2] = butterlp(adel[2], kfreq*kscal[2]*kcf)
        alp[3] = butterlp(adel[3], kfreq*kscal[3]*kcf)
        alp[4] = butterlp(adel[4], kfreq*kscal[4]*kcf)
        
        ; final mixing
        afinal init 0
        clear afinal
        ki = 0
        while ki < gkcurrentNotes do
            afinal = afinal + alp[ki]/gkcurrentNotes;
            ki = ki+1
        od
        outs afinal, afinal
    endif
endin
    
</CsInstruments>
<CsScore>
f0 z
</CsScore>
</CsoundSynthesizer>
