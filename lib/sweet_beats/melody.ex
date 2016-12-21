defmodule SweetBeats.Melody do

  @tempo 125 # eighth notes

  def start_link(notes) do
    pid = spawn_link(__MODULE__, :play, [notes])
    {:ok, pid}
  end

  def play(notes) do
    notes
    |> Enum.each(fn(note) ->
         spawn fn -> note(note) end
         :timer.sleep(@tempo)
       end)

    play(notes)
  end

  defp note(" "), do: nil
  defp note(note) do
    System.cmd("play", ["-qn", "synth", "1", "pluck", note])
  end
end
