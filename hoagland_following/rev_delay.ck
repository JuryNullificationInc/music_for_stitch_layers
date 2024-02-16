<<< "Reverbs & delays" >>>;

SinOsc osc => ADSR env1 => NRev rev => dac;
env1 => Delay delay => dac;
delay => delay;

0.2 => rev.mix;

0.25 => osc.gain;
0.5::second => dur beat;
(1::ms, beat/8, 0, 1::ms) => env1.set;

beat => delay.max;
beat / 4 => delay.delay;
0.5 => delay.gain;

[0,4,7] @=> int major[];
[0,3,7] @=> int minor[];

60 => int offset;
int position;

for (0 => int i; i < 4; i++)
{
    for (0 => int j; j < minor.cap(); j++)
    {
        Std.mtof(minor[j] + offset + position) => osc.freq;
        1 => env1.keyOn;
        beat => now;
    }
}