<<< "Tutorial base" >>>;

SinOsc osc => dac;
0.25 => osc.gain;

0.5::second => dur beat;

[0,4,7] @=> int major[];
[0,3,7] @=> int minor[];

48 => int offset;
int position;

for (0 => int i; i < 4; i++)
{
    for (0 => int j; j < minor.cap(); j++)
    {
        Std.mtof(minor[j] + offset + position) => osc.freq;
        beat => now;
    }
}