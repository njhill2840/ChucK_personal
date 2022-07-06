
Clarinet clair => JCRev r => dac;
.75 => r.gain;
.0 => r.mix;
.6 => clair.noteOn;
 clair.clear( 1.0 ); //clear, "pure" sound--complete change in feel

76 => float bpm;//tempo has slowed
(1./bpm)::minute => dur tempo;

//melody doesnt have enough repetition or consistent rhytmic duration to benefit from index
0.2 => clair.gain;
Std.mtof(64) => clair.freq;
1.5::tempo => now;
Std.mtof(66) => clair.freq;
.5::tempo => now;
Std.mtof(67) => clair.freq;
tempo => now;
Std.mtof(64) => clair.freq;
.5::tempo => now;
clair.gain(0.);
tempo/2=> now;
clair.gain(.6);

Std.mtof(69) => clair.freq;
1.5::tempo => now;
Std.mtof(71) => clair.freq;
.25::tempo => now;
Std.mtof(72) => clair.freq;
.25::tempo => now;
Std.mtof(71) => clair.freq;
tempo => now;
Std.mtof(67) => clair.freq;
.5::tempo => now;
clair.gain(0.);
tempo/2=> now;
clair.gain(.6);

Std.mtof(69) => clair.freq;
1.5::tempo => now;
Std.mtof(71) => clair.freq;
.25::tempo => now;
Std.mtof(72) => clair.freq;
.25::tempo => now;
Std.mtof(71) => clair.freq;
tempo => now;
Std.mtof(67) => clair.freq;
.5::tempo => now;
clair.gain(0.);
tempo/2=> now;
clair.gain(.6);

//manufacture ritardando
Std.mtof(66) => clair.freq;
tempo/4*3 => now;
Std.mtof(64) => clair.freq;
tempo/4*3 => now;
Std.mtof(63) => clair.freq;
tempo/4*3 => now;
Std.mtof(60) => clair.freq;
tempo/4*3 => now;
Std.mtof(59) => clair.freq;
tempo/4*3 => now;
Std.mtof(57) => clair.freq;
tempo/4*3 => now;
Std.mtof(55) => clair.freq;
tempo/4*3 => now;
Std.mtof(54) => clair.freq;
4::tempo => now; //sustain to end


// basic play function (add more arguments as needed)
fun void play( float note, float velocity )
{
    // start the note
    Std.mtof( note ) => clair.freq;
    velocity => clair.noteOn;
}
