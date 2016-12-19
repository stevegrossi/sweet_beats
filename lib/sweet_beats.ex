defmodule SweetBeats do
  use Application

  alias SweetBeats.Melody
  alias SweetBeats.Rhythm

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: SweetBeats.Worker.start_link(arg1, arg2, arg3)
      worker(Melody, ["BAGABBB AAA BDD BAGABBBBAABAG   "]),
      worker(Rhythm, ["kick3",   "X X X X "], id: 1),
      worker(Rhythm, ["snare2",  "    X   "], id: 2),
      worker(Rhythm, ["hihat1",  " X   X  "], id: 3),
      worker(Rhythm, ["hihat2",  "   X   X"], id: 4),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SweetBeats.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
