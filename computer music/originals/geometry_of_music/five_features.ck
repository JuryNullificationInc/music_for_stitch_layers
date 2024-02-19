// The Five Features of tonal music:
// 1. Conjunct Melodic Motion: melodies tend to move by short distances from note to note
// 2. Acoustic Consonance: Consonant harmonies are preferred to dissonant harmonies, and tend to be used at points of musical stability.
// 3. Harmonic Consistency: The harmonies in a passage of music, whatever they may be, tend to be structurally similar to one another.
// 4. Limited Macroharmony: The total collection of notes heard over moderate spans of musical time. 
// 5. Centricity: Over moderate spans of musical time, one note is heard as being more prominent than the others.

// 0:0 -> C
// 1:2 -> D
// 2:4 -> E
// 3:5 -> F
// 4:7 -> G
// 5:9 -> A
// 6:11 -> B
// 7:12 -> C
[0,2,4,5,7,9,11,12] @=> int scale[]; // Feature 3(?)

// Cmaj -> (0,2,4)
// Dmnr -> (1,3,5)
// Emnr -> (2,4,6)
// Fmaj -> (3,5,7)

60 => int offset;

Math.random2(1, scale.cap() - 1) => int index;

1::second => dur beat;

SndBuf chord[3];

me.dir() + "mid_buzz.wav" => string filename;

for (0 => int i; i < chord.cap(); i++)
{
    filename => chord[i].read;
    chord[i] => dac;
    1.0/chord.cap() => chord[i].gain;
}

fun int melodicMotion(int prevIndex, int motionConstraint) // Feature 1
{
    Math.random2(1, motionConstraint) => int step;
    return (prevIndex + step) % (scale.cap() - 1);
}

fun void doChord(int index, int secondOffset, int thirdOffset, dur length)
{
    Std.mtof(scale[index] + offset) => chord[0].freq;
    Std.mtof(scale[index] + offset + secondOffset) => chord[1].freq;
    Std.mtof(scale[index] + offset + thirdOffset) => chord[2].freq;
    length => now;
}

fun void playChord(int select, dur length) 
{
    if (select == 0) // C major chord
    {
        doChord(0, 2, 4, length); // Feature 5
    }
    else if (select == 1) // D minor
    {
        doChord(1, 3, 5, length); // Feature 5
    }
    else if (select == 2) // E minor
    {
        doChord(2, 4, 6, length); // Feature 5
    }
    else if (select == 3) // F major
    {
        doChord(3, 5, 7, length); // Feature 5
    }
}

while (true) 
{
    Math.random2(0, 3) => int select;
    playChord(select, beat);
}