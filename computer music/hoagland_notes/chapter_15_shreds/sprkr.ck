SndBuf kick => dac;

me.dir() + "kick.wav" => string kickFileName;
kickFileName => kick.read;

fun void SilenceAllBuffers() 
{
    kick.samples() => kick.pos;
}
SilenceAllBuffers();

0.5::second => dur beat;

fun void Drum(int select, dur duration, float gain)
{
    if (select == 0)
    {
        gain => kick.gain;
        0 => kick.pos;
    }
    duration => now;
    SilenceAllBuffers();
}

fun void GoDrums() 
{
    while (true) 
    {
        Drum(0, beat * 0.75, 0.5);
        Drum(0, beat * 0.25, 0.05);
    }
}

SinOsc osc1 => ADSR env1 => NRev rev1 => dac;

0.15 => osc1.gain;
(1::ms, beat / 4, 0, 1::ms) => env1.set;
0.1 => rev1.mix;

60 => int offset;
0 => int position;

[0,4,7,12] @=> int major[];

fun void GoArp() 
{
    while (true) 
    {
        for(0 => int i; i < major.cap(); i++)
        {
            Std.mtof(major[i] + offset + position) => osc1.freq;
            1 => env1.keyOn;
            beat / 4 => now;
        }
    }
}

spork ~ GoArp();

beat * 4 => now;

spork ~ GoDrums();

beat * 4 => now;

