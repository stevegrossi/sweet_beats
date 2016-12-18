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

  def beats(files) do
    files
    |> Enum.each(fn(sample) ->
         spawn fn -> play_sample(sample) end
         :timer.sleep(@tempo)
       end)
    beats(files)
  end

  def composition do
    spawn fn -> song("BAGABBB AAA BDD BAGABBBBAABAG") end
    spawn fn -> beats(~w(snare1 kick3 kick3 kick3)) end
    spawn fn -> beats(["kick1", " " ," ", "clap"]) end
    spawn fn -> beats([" ", " " ,"tom2", "tom1"]) end
  end

  defp note(" "), do: nil
  defp note(note) do
    System.cmd("play", ["-qn", "synth", "1", "pluck", note])
  end

  defp play_sample(" "), do: nil
  defp play_sample(filename) do
    System.cmd("play", ["-q", "media/#{filename}.wav"])
  end
end
