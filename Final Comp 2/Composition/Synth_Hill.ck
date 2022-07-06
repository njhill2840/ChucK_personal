TriOsc chord[6];  
TriOsc chord2[6];             // (1) Three oscillators for a chord


((1.0/chord.cap() - 0.1)) => float chordGain;
((1.0/chord.cap() - 0.1)) => float onGain; //(4) onGain for SinOsc's


148 => float bpm;//(5) tempo
(1./bpm)::minute => dur tempo; //(6) basic beat and division
tempo/4 => dur sixteenth;
4::tempo => dur measure; 



// (9) connect SinOsc array to dac
for (0 => int i; i < chord.cap(); i++)
{   
    chord[i] => dac;             
}
//(10) fun to play, copied from listing
fun void playChord(int root, string quality, string inversion, dur howLong)
{
    for (0 => int i; i < chord.cap(); i++)
    {
        chordGain => chord[i].gain; 
    }
    
    Std.mtof(root) => chord[0].freq; 
    
    //setting up chords for later
    0 => chord[3].gain;  
    0 => chord[4].gain;
    0 => chord[5].gain;    
    
    // set fifth of chord, allow for inversions
    if (inversion == "root")
    {
        Std.mtof(root+7) => chord[2].freq; 
    }   
    else if (inversion == "secnd")//second intentionally misspelled because of words/numbers ChucK already claims
    {
        Std.mtof(root-5) => chord[2].freq; 
    }        
    
    // third sets quality, major or minor, third same distance away in 2nd inversion
    if (quality == "major")
    {
        Std.mtof(root+4) => chord[1].freq;  // Major chord.
    }
    else if (quality == "minor") {
        Std.mtof(root+3) => chord[1].freq;  // Minor chord.
    }
    else
    {
        <<< "You must specify major or minor!!" >>>;
    }
    (7./8.)::howLong => now;//duration altered to build in room for a rest
    for (0 => int i; i < chord.cap(); i++)
    {
        
        0. => chord[i].gain; // rest
    }
    (1./8.)::howLong => now;
    
}

//play same chords but up an octave--requires no change to my input when running
fun void playChordUp(int root, string quality, string inversion, dur howLong)
{
    for (0 => int i; i < chord.cap(); i++)
    {
        chordGain => chord[i].gain; 
    }
    
    Std.mtof(root) => chord[0].freq; 
    Std.mtof(root+12) => chord[3].freq;  
    
    // set fifth of chord
    if (inversion == "root")
    {
        Std.mtof(root+7) => chord[2].freq; 
        Std.mtof(root+12+7) => chord[4].freq;
    }   
    else if (inversion == "secnd")
    {
        Std.mtof(root-5) => chord[2].freq;
        Std.mtof(root+12-5) => chord[4].freq; 
    }        
    
    // third sets quality, major or minor
    if (quality == "major")
    {
        Std.mtof(root+4) => chord[1].freq;  // Major chord.
        Std.mtof(root+12+4) => chord[5].freq;
    }
    else if (quality == "minor") {
        Std.mtof(root+3) => chord[1].freq; 
        Std.mtof(root+12+3) => chord[5].freq; // Minor chord.
    }
    else
    {
        <<< "You must specify major or minor!!" >>>;
    }
    (7./8.)::howLong => now;//duration altered to build in room for a rest
    for (0 => int i; i < chord.cap(); i++)
    {
        
        0. => chord[i].gain; // rest
    }
    (1./8.)::howLong => now;
    
}




//
//chord prog for beginning
fun void intro()
{
   
    for (0 => int i; i < 1; i++)//only repeat once to achieve volume fade
    {
         0 => chordGain;//sets chords at 0
        onGain/8=> float steps;//makes increments
        steps +=> chordGain;//increase by increments
        playChord(64, "minor", "secnd", 4::tempo);
        
         steps +=> chordGain; 
        playChord(62, "major", "secnd", 4::tempo);
        
         steps +=> chordGain;
        playChord(55, "major", "root", 4::tempo);
        
         steps +=> chordGain;
        playChord(57, "major", "root", 4::tempo);
        
         steps +=> chordGain;
        playChord(64, "minor", "secnd", 4::tempo);
         
          steps +=> chordGain;
        playChord(62, "major", "secnd", 4::tempo);
        
         steps +=> chordGain;
        playChord(57, "minor", "root", 4::tempo);
         
         steps +=> chordGain;
        playChord(59, "major", "root", 4::tempo);
    }

       
    
    
}




fun void accomp1()//chords at sustained volume
{
    for (int i; i < 1; i++)
    {
        
        playChord(64, "minor", "secnd", 4::tempo); 
        playChord(62, "major", "secnd", 4::tempo);
        
        playChord(55, "major", "root", 4::tempo);
        playChord(57, "major", "root", 4::tempo);
        
        playChord(64, "minor", "secnd", 4::tempo); 
        playChord(62, "major", "secnd", 4::tempo);
        
        playChord(57, "minor", "root", 4::tempo);
        playChord(59, "major", "root", 4::tempo);
    }
}

fun void accomp2()//now adds octave
{
    for (int i; i < 1; i++)
    {
        
        playChordUp(64, "minor", "secnd", 4::tempo); 
        playChordUp(62, "major", "secnd", 4::tempo);
        
        playChordUp(55, "major", "root", 4::tempo);
        playChordUp(57, "major", "root", 4::tempo);
        
        playChordUp(64, "minor", "secnd", 4::tempo); 
        playChordUp(62, "major", "secnd", 4::tempo);
        
        playChordUp(57, "minor", "root", 4::tempo);
        playChordUp(59, "major", "root", 4::tempo);
    }
}

//sets up chord progression for entire song to be sporked
fun void playAllAccomp()
{
    intro();
    accomp1();
    accomp1();
    accomp2();
  
}

playAllAccomp();//play entire prog
0 => chordGain;//quiet for 8 bars
32::tempo => now;

playAllAccomp();//play entire song--fade still fits so its kept
intro(); //need a few more measures, and fade works within songs

0 => chordGain;//guarantees quiet
tempo => now;

 
    