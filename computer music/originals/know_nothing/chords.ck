SinOsc chord[3];

for (0 => int i; i < chord.cap(); i++)
{
    chord[i] => dac;
    1.0/chord.cap() => chord[i].gain;
}

fun void playChord(int root, string quality, dur length)
{
    Std.mtof(root) => chord[0].freq;

    Std.mtof(root + 5) => chord[1].freq;

    Std.mtof(root + 7) => chord[2].freq;

    length => now;
}

1::second => dur beat;

playChord(60, "m", beat);