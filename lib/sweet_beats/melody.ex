defmodule SweetBeats.Melody do
  use GenServer

  @rest "."
  @microseconds_between_notes 250_000

  def start_link(start_time, instrument \\ Guitar, notes) do
    notes_queue = EQueue.from_list(notes)
    GenServer.start_link(__MODULE__, {start_time, instrument, notes_queue})
  end

  def init(state) do
    send(self(), :play)
    {:ok, state}
  end

  def handle_info(:play, {start_time, instrument, notes_queue}) do
    {:value, current_note, updated_queue} = EQueue.pop(notes_queue)
    play_note(instrument, current_note)
    shifted_notes = EQueue.push(updated_queue, current_note)

    delta = :os.system_time(:microsecond) - start_time
    time_to_next_note = @microseconds_between_notes - delta
    Process.send_after(self(), :play, round(time_to_next_note / 1000))
    next_start_time = :os.system_time(:microsecond) + time_to_next_note
    {:noreply, {next_start_time, instrument, shifted_notes}}
  end

  defp play_note(_instrument, @rest), do: nil
  defp play_note(instrument, note) do
    spawn(Kernel, :apply, [instrument, :play_note, [note]])
  end
end
