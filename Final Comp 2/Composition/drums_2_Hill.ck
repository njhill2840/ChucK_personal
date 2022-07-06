SndBuf kick => Gain master  => dac;   //send kick to master to dac, send all other sounds to master (to dac)
SndBuf clap => master;

me.dir(-1) + "/audio/acoust_kick.wav" => kick.read;//kick sound
me.dir(-1) + "/audio/clap_01.wav" => clap.read;//clap sound

148 => float bpm;//tempo set
(1./bpm)::minute => dur tempo;
tempo/4 => dur sixteenth;

0 => int beat;
0.8 => clap.gain;

[1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0] @=> int kickA[];//new kick pattern--didn't end up using
[0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0] @=> int clapA[];//clap pattern


clap.samples() => clap.pos;
kick.samples() => kick.pos;


for (int i; i< 24; i++) //play 24 measures
{
    0 => int beat;
    
    while (beat < clapA.cap()) //plays entire clap index on while loop
    {
        if (clapA[beat]) //plays clap index that lines up w beat
        {
            0 => clap.pos;
        }
        tempo/4 => now;
        beat++;
    }
}

