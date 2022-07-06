/*
MTC 518 Script Variation Seven
Using the Listing 5.13 arrayAdder() function to convert a scale from minor to major,
modify the listing to create a script that plays all of the seven diatonic modes and prints its name. Wait a few seconds
between each rendition of a mode. You may need to code additional functions. 
*/

// You must name your sound s for functions to work without being changed.


SinOsc s => dac;        
60 => int start; //declare MIDI note as base of scale
2 => int pause;


// global scale array, adds intervals for Ionian to starting pitch       
[start,start +2,start +4,start +5,start +7, start +9,start +11,start +12] @=> int scale[];
 
playAll(scale, 1);


//function to "wait" between sounds "s", declare pause globally to start
fun void wait(int pause) 
{
    0. => s.gain;
    pause::second => now;
    .5 => s.gain;
    }

// function to modify (-) an element of an array
fun void arraySubtr( int temp[], int index)  
{                       
      1 -=> temp[index];
    }

// function to modify (+) an element of an array
fun void arrayAdd( int temp[], int index)  
{                            
    1 +=> temp[index];
    }

//play (Ionian) scale on sound "s", essentially the same as the 5.13 scale but starting on major
fun void playIonianScale(int temp[]) 
{ 
    for (0 => int i; i < temp.cap(); i++)
    {
        Std.mtof(temp[i]) => s.freq;
        <<< i, temp[i] >>>;
        0.4 :: second => now;
    }
    second => now;
     <<< "Ionian (Major)" >>>;
}



//play dorian scale on sound "s"
fun void playDorianScale (int temp[]) 
{
    for (0 => int i; i < temp.cap(); i++) //keeps array changes from happening with each reptition--they only happen once so intervals are accurate
    {                                     //consistent throughout remaining functions
        if (i < 1)
        {
            arraySubtr(scale, 2);
            }
            
        if (i == 7) //last time through, all the intervals perform the opposite array action--resets to Ionian, consistent throughout remaining functions
        {
            arrayAdd(scale, 2);
            }
        Std.mtof(temp[i]) => s.freq;
        <<< i, temp[i] >>>;
        0.4 :: second => now;
    }
    second => now;
    <<< "Dorian" >>>; 
}



//play phrygian scale on sound "s"
fun void playPhrygianScale (int temp[]) 
{
    for (0 => int i; i < temp.cap(); i++)
    {
        if (i < 1)
        {
            arraySubtr(scale, 1);
            arraySubtr(scale, 2);
            arraySubtr(scale, 5);
            arraySubtr(scale, 6);
            }
        if (i == 7)
        {
            arrayAdd(scale, 1);
            arrayAdd(scale, 2);
            arrayAdd(scale, 5);
            arrayAdd(scale, 6);
            }
        Std.mtof(temp[i]) => s.freq;
        <<< i, temp[i] >>>;
        0.4 :: second => now;
    }
    second => now;
    <<< "Phrygian" >>>; 
}



//play lydian scale on sound "s"
fun void playLydianScale (int temp[]) 
{
    for (0 => int i; i < temp.cap(); i++)
    {
        if (i < 1)
        {
            arrayAdd(scale, 3);
            }
        if (i == 7)
        {
            arraySubtr(scale, 3);
            }
        Std.mtof(temp[i]) => s.freq;
        <<< i, temp[i] >>>;
        0.4 :: second => now;
    }
    second => now;
    <<< "Lydian" >>>; 
}



//play mixolydian scale  on sound "s"
fun void playMixolydianScale (int temp[]) 
{
    for (0 => int i; i < temp.cap(); i++)
    {
        if (i < 1)
        {
            arraySubtr(scale, 6);
            }
        if (i == 7)
        {
            arrayAdd(scale, 6);
            }
        Std.mtof(temp[i]) => s.freq;
        <<< i, temp[i] >>>;
        0.4 :: second => now;
    }
    second => now;
    <<< "Mixolydian" >>>; 
}



//play aeolian scale on sound "s"
fun void playAeolianScale (int temp[]) 
{
    for (0 => int i; i < temp.cap(); i++)
    {
        if (i < 1)
        {
            arraySubtr(scale, 2);
            arraySubtr(scale, 5);
            arraySubtr(scale, 6);
            }
        if (i == 7)
        {
            arrayAdd(scale, 2);
            arrayAdd(scale, 5);
            arrayAdd(scale, 6);
            }
        Std.mtof(temp[i]) => s.freq;
        <<< i, temp[i] >>>;
        0.4 :: second => now;
    }
    second => now;
    <<< "Aeolian (Natural Minor)" >>>; 
}



//play locrian scale on sound "s"
fun void playLocrianScale (int temp[]) 
{
    for (0 => int i; i < temp.cap(); i++)
    {
        if (i < 1)
        {
            arraySubtr(scale, 1);
            arraySubtr(scale, 2);
            arraySubtr(scale, 4);
            arraySubtr(scale, 5);
            arraySubtr(scale, 6);
            }
        if (i == 7)
        {
            arrayAdd(scale, 1);
            arrayAdd(scale, 2);
            arrayAdd(scale, 4);
            arrayAdd(scale, 5);
            arrayAdd(scale, 6);
            }
        Std.mtof(temp[i]) => s.freq;
        <<< i, temp[i] >>>;
        0.4 :: second => now;
    }
    second => now;
    <<< "Locrian" >>>; 
}

    
    
    //play ALL modes on sound "s", define pause to use
    fun void playAll (int temp[], int times) 
    {
        for (0 => int i; i < times; i++)
        {    
            playIonianScale(temp);
            wait(pause);
            playDorianScale(temp);
            wait(pause);
            playPhrygianScale(temp);
            wait(pause);    
            playLydianScale(temp);
            wait(pause);    
            playMixolydianScale(temp);
            wait(pause);    
            playAeolianScale(temp);
            wait(pause);    
            playLocrianScale(temp);
            wait(pause);
        }
    }
    
    
    
    
    
    
    
    