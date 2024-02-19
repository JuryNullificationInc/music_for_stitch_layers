SndBuf buf => dac;
0.5 => buf.gain;

me.dir() + "mid_buzz.wav" => string filename;
filename => buf.read;

1::second => now;