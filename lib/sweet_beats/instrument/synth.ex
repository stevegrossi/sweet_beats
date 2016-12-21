defmodule SweetBeats.Instrument.Synth do
  @behaviour SweetBeats.Instrument

  @duration "0.25"

  def play_note(note) do
    System.cmd("play", ["-qn", "synth", @duration, "square", note])
  end
end
