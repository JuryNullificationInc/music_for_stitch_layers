TriOsc osc => ADSR env1 => NRev rev => Pan2 pan => dac;

0.15 => rev.mix;

-1.0 => pan.pan;
env1 => Delay delay[2];

0.25::second => dur beat;

delay[0] => dac.left;
delay[1] => dac.right;
beat => delay[0].max => delay[1].max;
0.5 => delay[0].gain => delay[1].gain;
delay[0] => delay[0];
delay[1] => delay[1];
beat / 4 => delay[0].delay;
beat / 2 => delay[1].delay;


(1::ms, beat/8, 0, 1::ms) => env1.set;
0.25 => osc.gain;

[0,4,7] @=> int major[];
[0,3,7] @=> int minor[];

60 => int offset;
int position;

for (0 => int i; i < 4; i++)
{
    for (-1.0 => float j; j < 1.0; 0.1 +=> j)
    {
        beat / Math.random2(2, 16) => env1.decayTime;
        Math.random2(0,3) * 12 => position;
        Math.random2f(-1.0, 1.0) => float panValue;
        Math.random2(0, minor.cap() - 1) => int note;
        panValue => pan.pan;
        <<< "pan:", panValue >>>;
        Std.mtof(minor[note] + offset + position) => osc.freq;
        1 => env1.keyOn;
        beat => now;
    }
}