# SweetBeats

Experiments in making music with Elixir, for a forthcoming talk at the [Indy Elixir](https://www.meetup.com/indyelixir/events/235620850/) meetup.

## Installation

```
$ git clone git@github.com:stevegrossi/sweet_beats.git
$ brew install sox
$ mix run --no-halt
```

Learn more about the [SoX library](http://sox.sourceforge.net/) ([docs](http://sox.sourceforge.net/sox.html))

## Tentative API

Each "track" is a looping worker process supervised by the main application:

```elixir
worker(Melody, [Guitar, ~w(G . A . B . A . )]),
worker(Rhythm, ["kick2.wav", ~w(X . X .)], id: 1),
```

There are currently two types of processes

### `Melody`

This module is for generating musical tones. It takes two arguments, the first is an instrument module (e.g. `Guitar`) which plays notes by implementing the `Instrument` behaviour. The second argument is an array of notes. Specify sharps with `#`, e.g. `F#`; flats with `b`, e.g. `Gb`; and rests with `.`. You can also optionally specify the octave with an integer, e.g. `G#2`

### `Rhythm`

This module is for playing audio file samples from the `/samples` directory. Any [file format that SoX supports](http://sox.sourceforge.net/AudioFormats-11.html) should work. The worker process takes two arguments: the first is the name of the sample file, and the second is an array of beats. `.` signifies a rest (play nothing), and any other character (I prefer `X`) will play the sound file on that beat.

## Improvements I’d Like to Make

- More and better `Instrument`s!
- Processes will eventually get out of sync. I'm considering fixing this with either
  - a single metronome process which publishes beats, which each track process subscribes to, or
  - a time-based solution, where tracks adjust `sleep` times for drift from their moment of initialization
- A better API? At least one that allows composition.
- Specifiable tempo per-track

## Additional Resources

- http://elixirsips.com/episodes/062_quickie_synth.html, a bt out of date, but this tutorial was the inspiration behind this project
- Samples from [99Sounds](http://99sounds.org/drum-samples/)
