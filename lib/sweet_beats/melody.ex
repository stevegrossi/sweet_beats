defmodule SweetBeats.Melody do

  @tempo 125 # eighth notes
  @rest "."

  def start_link(instrument \\ Guitar, notes) do
    pid = spawn_link(__MODULE__, :play, [instrument, notes])
    {:ok, pid}
  end

  def play(instrument, notes) do
    notes
    |> Enum.each(fn(note) ->
         spawn fn -> note(instrument, note) end
         :timer.sleep(@tempo)
       end)

    play(instrument, notes)
  end

  defp note(_instrument, @rest), do: nil
  defp note(instrument, note) do
    apply(instrument, :play_note, [note])
  end
end
