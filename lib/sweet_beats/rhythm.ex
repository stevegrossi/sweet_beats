defmodule SweetBeats.Rhythm do

  @tempo 250

  def start_link(sample_file, notation) do
    pid = spawn_link(__MODULE__, :play, [sample_file, notation])
    {:ok, pid}
  end

  def play(sample_file, notation) do
    notation
    |> String.graphemes
    |> Enum.each(fn(note) ->
         spawn fn -> play_sample(sample_file, note) end
         :timer.sleep(@tempo)
       end)

    play(sample_file, notation)
  end

  defp play_sample(_sample_file, " "), do: nil
  defp play_sample(sample_file, _note) do
    System.cmd("play", ["-q", "media/#{sample_file}.wav"])
  end
end
