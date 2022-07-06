SndBuf kick => Gain master => ADSR env => dac;   //send kick to master to dac, send all other sounds to master (to dac)
SndBuf snare => master;              
SndBuf hihat => master;
SndBuf crash => master;


//file directories to find sound
me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;
me.dir(-1) + "/audio/snare_01.wav" => snare.read;
me.dir(-1) + "/audio/acoust_kick.wav" => kick.read;
me.dir(-1) + "/audio/crash_cymbal_01.wav" => crash.read;

//tempo
148 => float bpm;
(1./bpm)::minute => dur tempo;
tempo/4 => dur sixteenth;

//gains and ints for later
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

//indexes for beats/patterns
[1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0] @=> int kickA[];
[1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1] @=> int snareA[];
[0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0] @=> int snareB[];
[0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,1] @=> int snareC[];
[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] @=> int crashA[];
[1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0] @=> int crashB[];

crash.samples() => crash.pos; //crash pos set to last sample so doesnt play at beginning
hihat.samples() => hihat.pos; 
snare.samples() => snare.pos;

for (int i; i< 10; i++)//10 measures of kick only
{
    0 => int beat;
    
    while (beat < kickA.cap())//kick plays on index of beat
    {
        if (kickA[beat])
        {
            0 => kick.pos;
            .70 => env.gain; //envelope made sound less choppy
            env.set(A :: sixteenth, D :: sixteenth, S, R:: sixteenth);
            1 => env.keyOn;
        }
        tempo/4 => now;
        1 => env.keyOff;
        beat++;
    }
}

for (int i; i< 8; i++)//8 measures of kick and snare
{
    0 => int beat;
    
    while (beat < snareA.cap())
    {
        if (kickA[beat])
        {
            0 => kick.pos;
            .70 => env.gain; 
            env.set(A :: sixteenth, D :: sixteenth, S, R:: sixteenth);
            1 => env.keyOn;
        }
        if (snareA[beat])
        {
            0 => snare.pos;
        }
        tempo/4 => now;
        beat++;
    }
}


for (int i; i< 8; i++)//8 measures of kick snare and HH
{
    0 => int beat;
    
    while (beat < kickA.cap())
    {
        if (kickA[beat])
        {
            0 => kick.pos;
            .70 => env.gain; 
            env.set(A :: sixteenth, D :: sixteenth, S, R:: sixteenth);
            1 => env.keyOn;
        }
        if (snareB[beat])
        {
            0 => snare.pos;
        }
        
        if ((i == 3) && (snareC[beat]))//16ths at the end of every measures was a lot, now just 4th time
        {
            0 => snare.pos;
        }
        0 => hihat.pos;// Play hihat on every beat, every time 
        tempo/4 => now;
        beat++;
    }
}


for (int i; i< 8; i++)//8 measures of 2 loops to change up pattern
{
    0 => beat;
    while (beat < kickA.cap())//loop 1
    {
        if (kickA[beat])
        {
            0 => kick.pos;
            .70 => env.gain; 
            env.set(A :: sixteenth, D :: sixteenth, S, R:: sixteenth);
            1 => env.keyOn; 
        }
        if (snareB[beat])
        {
            0 => snare.pos;
        }
        0 => hihat.pos;// Play hihat on every beat, every time 
        tempo/4 => now; 
        beat++;
    }
    0 => beatA;//declare at 0 AFTER loop 1 over
    while (beatA < kickA.cap())//loop 2--beatA so that loops play separately
    {
        if (kickA[beatA])
        {
            0 => kick.pos;
            .70 => env.gain; 
            env.set(A :: sixteenth, D :: sixteenth, S, R:: sixteenth);
            1 => env.keyOn;
        }
        if (snareA[beatA])
        {
            0 => snare.pos;
        }
        if (snareC[beatA])
        {
            0 => snare.pos;
        }
        0 => hihat.pos;// Play hihat on every beat, every time 
        tempo/4 => now;
        beatA++;
    }
    if (i == 7)//end with a big impact after loops are done
    {
        0 => kick.pos;
        .70 => env.gain; 
        env.set(A :: sixteenth, D :: sixteenth, S, R:: sixteenth);
        1 => env.keyOn;
        0 => snare.pos;
        0 => crash.pos;
        4::tempo => now;
    }
}

