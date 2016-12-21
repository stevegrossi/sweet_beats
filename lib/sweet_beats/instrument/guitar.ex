defmodule SweetBeats.Instrument.Guitar do
  @behaviour SweetBeats.Instrument

  def play_note(note) do
    System.cmd("play", ["-qn", "synth", "1", "pluck", note])
  end
end
