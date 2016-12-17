defmodule SweetBeats do

  @tempo 250

  @doc ~S"""
  Splits a string of notes and plays them. Spaces denote rests.

      iex> SweetBeats.song("BAGABBB AAA BDD BAGABBBBAABAG")

  """
  def song(notes) do
    notes
    |> String.graphemes
    |> Enum.each(fn(note) ->
         spawn fn -> note(note) end
         :timer.sleep(@tempo)
       end)
  end

  defp note(" "), do: nil
  defp note(note) do
    System.cmd("play", ["-qn", "synth", "1", "pluck", note])
  end
end
