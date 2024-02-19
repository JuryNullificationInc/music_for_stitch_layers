SndBuf guitar => dac;

me.dir() + "guitar.wav" => string filename;
filename => guitar.read;

<<< guitar.samples() >>>;
