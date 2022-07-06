//MTC 518 Medium Script 3 Free-form Drum machine based on Listing4.10

/*

Using Listing4.10 as a model, create a drum machine that uses four different timbres in compound time. Use arrays as a score as in Listing4.10.

Make at least one sound/array activate a conditional statement such that there's a statistical basis for whether or note a soundfile plays. So, if an array guiding playback looks like this [101100]  perhaps the 1 at index 2 triggers a "dice roll" decision whether or not to play.

*/

SndBuf kick => Gain master => dac;   //send kick to master to dac, send all other sounds to master (to dac)
SndBuf snare => master;              
SndBuf hihat => master;
SndBuf crash => master;
SndBuf fill => master;



me.dir()+"/audio/kick_01.wav" => kick.read;      //load sound files 
me.dir()+"/audio/snare_01.wav" => snare.read;
me.dir()+"/audio/hihat_01.wav" => hihat.read;
me.dir()+"/audio/crash_cymbal_01.wav" => crash.read;
me.dir()+"/audio/tom_fill_01.wav" => fill.read;

0.3 => hihat.gain; //HH gain set

64. => float bpm;
(1/bpm)::minute => dur tempo; //set tempo and duration. macro beat will be 64 bpm

[1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0] @=> int kickHits[];  // Arrays to control when kick 
[0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,1] @=> int snareHits[]; //and snare

crash.samples() => crash.pos; //crash pos set to last sample so doesnt play at beginning
fill.samples() => fill.pos; //fill pos ""

while (true)
{
    0 => int beat; //reset beat counter every time
    
    while (beat < kickHits.cap())
    {
        // play kick drum on based on array value of beat number
        if (kickHits[beat])  
        {                    
            0 => kick.pos;   
        }
        
        // play snare drum on based on array value of beat number
        if (snareHits[beat]) 
        {                   
            0 => snare.pos; 
        }
        
        //play crash cymbal on 1st subdiv. of measure, only when random dice roll is 5 or 6
        if ((beat == 0) && (Math.random2(1,6)>4) )
        { 
            0.2 => crash.gain;
            0 => crash.pos;
        }

       

        //play a fill on 2nd 8th of beat 4, if dice roll is 4-6, should be more often than crash
 
        if ((beat == 20) && (Math.random2(1,6)>3))
        {        
            0 => fill.pos;
        }
        
        0.2 => crash.gain;
        0.5 => fill.gain;
        
        0 => hihat.pos;// Play hihat on every beat, every time 
        tempo/6 => now;        // time plays, so sound plays. Tempo/6 to allow for 16th subdivision
        beat++; //adds to beat each loop
                  
    }                      //repeats loop
}








