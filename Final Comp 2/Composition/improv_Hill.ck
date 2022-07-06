Brass brass => JCRev r => dac;
.75 => r.gain;
0=> r.mix;


148 => float bpm;//(5) tempo
(1./bpm)::minute => dur tempo; //(6) basic beat and division
tempo/4 => dur sixteenth;
4::tempo => dur measure;

//various gains to achieve reverb fade
8=> int measures;
1/measures => float steps;
0 => float vibGain => brass.vibratoGain;
0 => float vibFreq => brass.vibratoFreq;
0 +=> float rmixLevel;



// our notes
[ 64, 66, 67, 71, 72, 66, 71, 66 ] @=> int notes[];




.6 => float brassGain;
brassGain => brass.gain;





for (0 => int i; i< 8; i++) //uses random math function to improvise on penta scale in key for 8 measures
{ 
    for( int i; i < notes.cap(); i++ )
    {
        Math.random2(0,(notes.cap()-1)) => int improv;
        play( 12 + notes[improv], .6);
        tempo/2 => now;
    }
}

for (0 => int i; i< 8; i++) //8 more, but w reverb
{
    .5/measures +=> rmixLevel; //messy, but functional, way to set up brass sound and gradually add reverb gain
    rmixLevel => r.mix;
    1 => brass.lip;
    vibFreq + (3*steps) => brass.vibratoFreq;
    vibGain + steps => brass.vibratoGain;
    
    
    
    for( int i; i < notes.cap(); i++ )
    {
        Math.random2(0,(notes.cap()-1)) => int improv;
        play( 12 + notes[improv], .6);
        tempo/2 => now;
    }
}

for (0 => int i; i <8; i++) //sustain note to end
{
    play( 12 + notes[0], .6);
    tempo => now;
    brassGain/4 -=> brassGain;
    brassGain => brass.gain;
}
    
// basic play function (add more arguments as needed)
fun void play( float note, float velocity )
{
    // start the note
    Std.mtof( note ) => brass.freq;
    velocity => brass.noteOn;
}
