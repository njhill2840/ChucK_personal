SqrOsc s => dac;
.04 => float onGain => s.gain;


148 => float bpm;//(5) tempo
(1./bpm)::minute => dur tempo; //(6) basic beat and division
tempo/4 => dur sixteenth;
4::tempo => dur measure; 

0 => int bassline;//declare bassline to track measures--i didnt want another i
while (bassline<5) //while loop that incorporates whole bassline
{  
    for (0 => int i; i < 4; i++) //first note--plays 1 measure/4 quarters
    {
        Std.mtof(40) => s.freq;
        .95::tempo => now;
        0 => s.gain;
        .05::tempo => now;
        onGain => s.gain;
    }
    
    for (0 => int i; i < 4; i++) //second note
    {   
        Std.mtof(38) => s.freq;
        .95::tempo => now;
        0 => s.gain;
        .05::tempo => now;
        onGain => s.gain;
    }
    for (0 => int i; i < 4; i++) //etc
    {
        Std.mtof(31) => s.freq;
        .95::tempo => now;
        0 => s.gain;
        .05::tempo => now;
        onGain => s.gain;
    }
    for (0 => int i; i < 4; i++)
    {
        Std.mtof(33) => s.freq;
        .95::tempo => now;
        0 => s.gain;
        .05::tempo => now;
        onGain => s.gain;
    }
    for (0 => int i; i < 4; i++)
    {
        Std.mtof(40) => s.freq;
        .95::tempo => now;
        0 => s.gain;
        .05::tempo => now;
        onGain => s.gain;
    }
    for (0 => int i; i < 4; i++)
    {
        Std.mtof(38) => s.freq;
        .95::tempo => now;
        0 => s.gain;
        .05::tempo => now;
        onGain => s.gain;
    }
    for (0 => int i; i < 3; i++) //shorter selection
    {
        Std.mtof(33) => s.freq;
        .95::tempo => now;
        0 => s.gain;
        .05::tempo => now;
        onGain => s.gain;
    }
    
    Std.mtof(33) => s.freq; //add some flair--eighth notes that had to be pulled out of loop
    .5::tempo => now;
    Std.mtof(34) => s.freq;
    .5::tempo => now;
    
    for (0 => int i; i < 4; i++)
    {
        Std.mtof(35) => s.freq;
        .95::tempo => now;
        0 => s.gain;
        .05::tempo => now;
        onGain => s.gain;
    }
    bassline++;
}    

    
74 => bpm; //tempo change comes from the bass (also reflected in score)
(1./bpm)::minute => tempo;

for (0 => int i; i < 4; i++) //repeats same note to give some stability to change
{
    Std.mtof(40) => s.freq;
    .98::tempo => now;
    0 => s.gain;
    .02::tempo => now;
    onGain => s.gain;
}


for (0 => int i; i < 8; i++)
{
    
   onGain - onGain/8 => onGain; //(gain divided by beats) is subtracted from gain, becomes new gain
   onGain => s.gain; //gain set to new gain--fade out bass
    
    Std.mtof(40) => s.freq;
    .98::tempo => now;
    0 => s.gain;
    .02::tempo => now;
    onGain => s.gain;
}

0 => s.gain; //ensures tempo WILL get to 0
tempo => now;
