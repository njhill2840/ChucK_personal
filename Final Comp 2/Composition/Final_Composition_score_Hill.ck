//Compostion score

148 => float bpm; //set tempo
(1./bpm)::minute => dur tempo;
4::tempo => dur measure;

Machine.add(me.dir() + "/drums_Hill.ck") => int drumsID; //add drums
8::tempo => now;

Machine.add(me.dir() + "/Synth_Hill.ck") => int synthID; //add chords
32::measure => now;

Machine.add(me.dir() + "/melody_Hill.ck") => int melodyID; //add melody
8::measure => now;

Machine.add(me.dir() + "/bass_Hill.ck") => int bassID; //add bass line
8::measure => now;

Machine.add(me.dir() + "/drums_2_Hill.ck") => int drums2ID; //add claps
8::measure => now;

Machine.add(me.dir() + "/drums_3_Hill.ck") => int drums3ID; //add more intricate drums/no build time
8::measure => now;

Machine.add(me.dir() + "/improv_Hill.ck") => int improvID; //improv section
16::measure => now;


74 =>  bpm; //set new tempo
(1./bpm)::minute =>  tempo;
4::tempo =>  measure; 

measure => now;

Machine.add(me.dir() + "/slow_mel_Hill.ck") => int slowID; //slow "surprise" section
5::measure =>now;

148 =>  bpm; //tempo back to normal
(1./bpm)::minute =>  tempo;
4::tempo =>  measure;

//add ALL the instruments (not really all--but gives a full feeling and important instruments are revisited) to the end
Machine.add(me.dir() + "/melody_Hill.ck") ; 
Machine.add(me.dir() + "/bass_out_Hill.ck") => int bassOutID  ;
Machine.add(me.dir() + "/drums_2_Hill.ck")  ;
Machine.add(me.dir() + "/drums_3_Hill.ck")  ;
Machine.add(me.dir() + "/synth_out_Hill.ck") => int synthOutID;




