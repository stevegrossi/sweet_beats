defmodule SweetBeats do
  use Application

  alias SweetBeats.Metronome
  alias SweetBeats.Melody
  alias SweetBeats.Rhythm

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      worker(Registry, [:duplicate, SweetBeats.Registry]),
      worker(Metronome, []),
      worker(Melody, [SweetBeats.Instrument.Guitar, ~w(
        D# . .  . A# . . . A# . G# . A# . .  .
        G# . F# . G# . . . G# . F# . D# . F# .
      )]),
      worker(Rhythm, ["kick2.wav",   ~w(X . . X . . . .)], id: 1),
      worker(Rhythm, ["kick1.wav",   ~w(X . . . X . . .)], id: 2),
      worker(Rhythm, ["hihat1.wav",  ~w(X X . X . . X .)], id: 3),
      worker(Rhythm, ["hihat2.wav",  ~w(. . X . . X . .)], id: 4),
      worker(Rhythm, ["snare2.wav",  ~w(. . . . X . . X)], id: 5),
      worker(Rhythm, ["clap.wav"  ,  ~w(. . . . X . . .)], id: 6),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SweetBeats.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
