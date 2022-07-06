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




.6 => brass.gain;
for (0 => int i; i< measures; i++) //8 measures of fade in melody
{
    .5/measures +=> rmixLevel; //fade in reverb
    rmixLevel => r.mix;
    1 => brass.lip;
    vibFreq + (3*steps) => brass.vibratoFreq;
    vibGain + steps => brass.vibratoGain;
    

    
    for( int i; i < notes.cap(); i++ ) //melody played by index beat above
    {
        play( 12 + notes[i], .6);
        tempo/2 => now; //8th notes
    }
}

for (0 => int i; i< measures; i++)//8 measures w reverb
{ 
    for( int i; i < notes.cap(); i++ )
    {
        play( 12 + notes[i], .6);
        tempo/2 => now;
    }
}

// basic play function (add more arguments as needed)
fun void play( float note, float velocity )
{
    // start the note
    Std.mtof( note ) => brass.freq;
    velocity => brass.noteOn;
}
