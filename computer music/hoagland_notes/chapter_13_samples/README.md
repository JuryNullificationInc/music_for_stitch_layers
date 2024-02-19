`SndBuf` is a unit generator for playing back files on disk. Interesting tips for `SndBuf u`:
- `u.samples()` gets the total samples in the file
- `u.rate` sets the playback rate
    - Negative rates play the samples backward
- `u.pos` sets the position of the playback, in terms of samples
    - `u.samples() => u.pos` stops the playback by setting the position to the last sample, meaning there's nothing left to play