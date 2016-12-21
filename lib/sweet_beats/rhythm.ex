defmodule SweetBeats.Rhythm do

  @tempo 125 # eighth notes
  @rest "."

  def start_link(sample_file, notes) do
    pid = spawn_link(__MODULE__, :play, [sample_file, notes])
    {:ok, pid}
  end

  def play(sample_file, notes) do
    notes
    |> Enum.each(fn(note) ->
         spawn fn -> play_sample(sample_file, note) end
         :timer.sleep(@tempo)
       end)

    play(sample_file, notes)
  end

  defp play_sample(_sample_file, @rest), do: nil
  defp play_sample(sample_file, _note) do
    System.cmd("play", ["-q", "samples/#{sample_file}"])
  end
end
