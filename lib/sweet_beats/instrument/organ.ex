defmodule SweetBeats.Instrument.Organ do
  @behaviour SweetBeats.Instrument

  @duration "0.5"

  def play_note(note) do
    System.cmd("play", ["-qn", "synth", "sine", note, "fade", "0.1", @duration, "0.1"])
  end
end
