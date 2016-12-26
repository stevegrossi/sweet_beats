defmodule SweetBeats do
  use Application

  alias SweetBeats.Melody
  alias SweetBeats.Rhythm

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    start_time = :os.system_time(:microsecond)
    children = [
      worker(Melody, [start_time, SweetBeats.Instrument.Synth, ~w(
        E5 . B4 C5
        D5 . C5 B4
        A4 . A4 C5
        E5 . D5 C5
        B4 .  . C5
        D5 . E5 .
        C5 . A4 .
        A4 . .  .
        .  D5 . F5
        A5 . G5 F5
        E5 . .  C5
        E5 . D5 C5
        B4 . B4 C5
        D5 . E5 .
        C5 . A4 .
        A4 .  .  .
      )]),
      worker(Rhythm, [start_time, "kick2.wav",   ~w(X . . X . . . .)], id: 1),
      worker(Rhythm, [start_time, "kick1.wav",   ~w(X . . . X . . .)], id: 2),
      worker(Rhythm, [start_time, "hihat1.wav",  ~w(X X . X . . X .)], id: 3),
      worker(Rhythm, [start_time, "hihat2.wav",  ~w(. . X . . X . .)], id: 4),
      worker(Rhythm, [start_time, "snare2.wav",  ~w(. . . . X . . X)], id: 5),
      worker(Rhythm, [start_time, "clap.wav"  ,  ~w(. . . . X . . .)], id: 6),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SweetBeats.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
