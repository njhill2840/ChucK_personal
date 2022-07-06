/*MTC 518 YOURNAME
Script Variation Modify the French Ambulance code. With a pulse == 0.5::second,
use an array for the pitches C4, D4, E4, F4. Make the ambulance play E4 to C4 four times, then F4 to D4 four times.
Then make the pulse twice as fast, play each seques eight times. 
*/

SinOsc s => dac;
.5::second => dur Pulse;
.5 => float onGain => s.gain;

[64, 60, 65, 62] @=> int sirenPitches[];


//four times each at initial pulse speed

<<< "First pitches, slow" >>>;

for (0 => int i; i < sirenPitches.cap(); i++)
     
     {Std.mtof(sirenPitches[0]) => s.freq;
     Pulse => now;
     
     Std.mtof(sirenPitches[1]) => s.freq;
     Pulse => now;
     
 }
 
 <<< "Pitch change" >>>;
 
 for (0 => int i; i < sirenPitches.cap(); i++)
     
     {Std.mtof(sirenPitches[2]) => s.freq;
     Pulse => now;
     
     Std.mtof(sirenPitches[3]) => s.freq;
     Pulse => now;
     
 }
 
 //8 and double
 
 <<< "First pitches, fast" >>>;
 
 Pulse/2 => Pulse;    
 
 for (0 => int i; i < 2*sirenPitches.cap(); i++)
     
     {Std.mtof(sirenPitches[0]) => s.freq;
     Pulse => now;
     
     Std.mtof(sirenPitches[1]) => s.freq;
     Pulse => now;
     
 }
 
 <<< "Pitch change again" >>>;
 
 for (0 => int i; i < 2*sirenPitches.cap(); i++)
     
     {Std.mtof(sirenPitches[2]) => s.freq;
     Pulse => now;
     
     Std.mtof(sirenPitches[3]) => s.freq;
        Pulse => now;
        
    }

    

