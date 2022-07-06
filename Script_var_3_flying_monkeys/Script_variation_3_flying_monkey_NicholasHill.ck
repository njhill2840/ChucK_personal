/*
MTC 518 Script_Variation_yourname
"Flying Monkey Song" from WOO.
Briefly comment (1) through (10)
then follow directions at the bottom to continue script.
*/
SinOsc s => dac;//(1) sends sine sound to the DAC (digital audio converter)
0. => s.gain;//(2) establishes gain for sin, begins quiet so it doesnt start a sound right away
0.3 => float onGain;//(3) declaring a variable so that we can use it to start a note at the same gain level later

220. => float myPitch; 
myPitch => float doh;
(9.* myPitch)/8. => float re;
(5.* myPitch)/4. => float mi;
(4.* myPitch)/3. => float fa;
(3.* myPitch)/2. => float sol;
(5.* myPitch)/3. => float la;
(15.* myPitch)/8. => float ti;
2. * doh => float doh_440;
(1./126.)::minute => dur T;//(4) sets the tempo by defining duration each note will be. 1/126 is the same as 1/bpm. 1 note is 1 beat, hence numerator.
//                                denominator determines the number of beats, and it all modifies the recognize time type "minute"

for (int i; i < 2; i++)
{
s.freq(doh);
s.gain(onGain);
<<<"Oh">>>;//(4.5) Why is this hepful? It gives visual feedback with audio being played. If a mistake happens, watching the CM will allow you to determine 
//                   where the error was as opposed to analyzing each function within the code to find what is causing the audio to find the mistake
T => now;
sol => s.freq;
<<<"Oh">>>;
T => now;
doh => s.freq;
<<<"Oh">>>;
T => now;
s.gain(0.);
T => now;
s.freq(sol);
s.gain(onGain);
<<<"Oh">>>; 
T => now;
now + 1::T => time later;//(5) declares a time variable of "later" that is 1 beat long
(sol - doh)/10. => float x;//(6) declares variable x that splits the distance between the fifth, sol and doh, into ten steps
sol => float y;

while (now < later)//(7) Sets up a while loop with a time constraint so that the the gliss occurs within 1 beat (difference between now and later, as declared above)
{
    x -=> y; //(8) takes the 10 increments from line 43 and subtracts them from y variable (starts as sol, each loop will be 1 increment less)
    y => s.freq; //(9) sets the sounding frequency to be the new y value/next increment in the gliss each loop
    0.1::T => now;//(10) declares the length of each increment of gliss, 1/10 of beat, which will fit all ten steps in within the allotted 1 beat
}
s.freq(doh);
s.gain(onGain);
<<<"Oh">>>; //For Nick--gliss ending pitch 
T => now;
s.gain(0.);
T => now;
}
    
/*
Staying in time/ gliss from doh to doh_440 over a dotted-half note's span of time, 
rest for one one beat, the play doh for 1 beat, then 3 beats of rest.
*/



3*T => dur NickT;
now + 1::NickT => time Nicklater;
(doh_440-doh)/50. => float a;
doh => float b;
s.gain(onGain);

while (now < Nicklater)
{
    a +=> b;
    b => s.freq;
    .06::T => now;
}

s.gain (0.);
T => now;

s.freq (doh);
s.gain (onGain);
T => now;
s.gain (0.);
NickT => now;



