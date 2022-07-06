SndBuf kick => Gain master => ADSR env => dac;   //send kick to master to dac, send all other sounds to master (to dac)
SndBuf snare => master;              
SndBuf hihat => master;
SndBuf crash => master;



//file directory to find sounds
me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;
me.dir(-1) + "/audio/snare_01.wav" => snare.read;
me.dir(-1) + "/audio/acoust_kick.wav" => kick.read;
me.dir(-1) + "/audio/crash_cymbal_01.wav" => crash.read;

//tempo
148 => float bpm;
(1./bpm)::minute => dur tempo;
tempo/4 => dur sixteenth;

//gains and ints I need later
0 => int beat;
16 => int beatA;
0.1 => hihat.gain;
0.8 => snare.gain;
0.5 => kick.gain;

//kick ADSR
0.01 => float A;
0.03 => float D;
0.8 => float S;
0.9 => float R;


[1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0] @=> int kickA[];
[1,0,0,0,1,0,1,0,1,0,0,0,1,0,0,0] @=> int kickB[];
[1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1] @=> int snareA[];
[0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0] @=> int snareB[];
[0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,1] @=> int snareC[];
[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] @=> int crashA[];
[1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0] @=> int crashB[];

crash.samples() => crash.pos; //crash pos set to last sample so doesnt play at beginning
hihat.samples() => hihat.pos; 
snare.samples() => snare.pos;




for (int i; i< 8; i++)//8 measure repeat
{
 
    0 => beat;
    while (beat < kickA.cap())
    {
        if (kickA[beat]) //kick plays on index beats
        {
            0 => kick.pos;
            .70 => env.gain; 
            env.set(A :: sixteenth, D :: sixteenth, S, R:: sixteenth);
            1 => env.keyOn; 
        }
        if (snareB[beat])//snare ""
        {
            0 => snare.pos;
        }
        if ((i == 4)&& (crashA[beat])) //only plays crash on measure 5
        {
            0 => crash.pos;
        }
        0 => hihat.pos;// Play hihat on every beat, every time 
        tempo/4 => now; 
        beat++;
    }
    if (i == 7)  //ends section with a crash
    {
        0 => crash.pos;
    }
}

for (int i; i< 8; i++)
{
  
    while (beat < kickB.cap()) //kick plays on index beats
    {
        if (kickB[beat])
        {
            0 => kick.pos;
            .70 => env.gain; 
            env.set(A :: sixteenth, D :: sixteenth, S, R:: sixteenth);
            1 => env.keyOn; 
        }
        if (snareB[beat])//snare ""
        {
            0 => snare.pos;
        }
        if ((i == 4)&& (crashA[beat])) //only plays crash on measure 5
        {
            0 => crash.pos;
        }
        0 => hihat.pos;// Play hihat on every beat, every time 
        tempo/4 => now; 
        beat++;
    }
    0 => beatA;
    while (beatA < kickB.cap())
    {
        if (kickB[beatA])
        {
            0 => kick.pos;
            .70 => env.gain; 
            env.set(A :: sixteenth, D :: sixteenth, S, R:: sixteenth);
            1 => env.keyOn;
        }
        if (snareA[beatA])//snareA plays
        {
            0 => snare.pos;
        }
        if (snareC[beatA])//snareC plays--they sound more or less like one index, but without writing an additional one
        {
            0 => snare.pos;
        }
        0 => hihat.pos;// Play hihat on every beat, every time 
        tempo/4 => now;
        beatA++;
    }
}