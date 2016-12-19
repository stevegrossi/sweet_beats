defmodule SweetBeats.Melody do

  @tempo 250

  def start_link(notation) do
    pid = spawn_link(__MODULE__, :play, [notation])
    {:ok, pid}
  end

  def play(notation) do
    notation
    |> String.graphemes
    |> Enum.each(fn(note) ->
         spawn fn -> note(note) end
         :timer.sleep(@tempo)
       end)

    play(notation)
  end

  defp note(" "), do: nil
  defp note(note) do
    System.cmd("play", ["-qn", "synth", "1", "pluck", note])
  end
end
