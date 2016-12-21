defmodule SweetBeats.Instrument.Trombone do
  @behaviour SweetBeats.Instrument

  @duration "0.25"

  def play_note(note) do
    System.cmd("play", ["-qn", "synth", @duration, "sawtooth", note])
  end
end
