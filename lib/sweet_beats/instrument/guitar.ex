defmodule SweetBeats.Instrument.Guitar do
  @behaviour SweetBeats.Instrument

  @duration "1"

  def play_note(note) do
    System.cmd("play", ["-qn", "synth", @duration, "pluck", note])
  end
end
