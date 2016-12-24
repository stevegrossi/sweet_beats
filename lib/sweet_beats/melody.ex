defmodule SweetBeats.Melody do
  use GenServer

  @rest "."

  def start_link(instrument \\ Guitar, notes) do
    GenServer.start_link(__MODULE__, {instrument, notes})
  end

  def init(state) do
    {:ok, _} = Registry.register(SweetBeats.Registry, "track", [])
    {:ok, state}
  end

  def handle_info(:play, {instrument, [head | tail]}) do
    play_note(instrument, head)
    shifted_notes = tail ++ [head]
    {:noreply, {instrument, shifted_notes}}
  end

  defp play_note(_instrument, @rest), do: nil
  defp play_note(instrument, note) do
    spawn(Kernel, :apply, [instrument, :play_note, [note]])
  end
end
