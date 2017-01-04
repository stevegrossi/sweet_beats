defmodule SweetBeats.Rhythm do
  use GenServer

  @rest "."
  @microseconds_between_notes 250_000

  def start_link(start_time, sample_file, notes) do
    notes_queue = EQueue.from_list(notes)
    GenServer.start_link(__MODULE__, {start_time, sample_file, notes_queue})
  end

  def init(state) do
    send(self(), :play)
    {:ok, state}
  end

  def handle_info(:play, {start_time, sample_file, notes_queue}) do
    {:value, current_note, updated_queue} = EQueue.pop(notes_queue)
    play_sample(sample_file, current_note)
    shifted_notes = EQueue.push(updated_queue, current_note)

    delta = :os.system_time(:microsecond) - start_time
    time_to_next_note = @microseconds_between_notes - delta
    Process.send_after(self(), :play, round(time_to_next_note / 1000))
    next_start_time = :os.system_time(:microsecond) + time_to_next_note
    {:noreply, {next_start_time, sample_file, shifted_notes}}
  end

  defp play_sample(_sample_file, @rest), do: nil
  defp play_sample(sample_file, _note) do
    spawn(System, :cmd, ["play", ["-q", "samples/#{sample_file}"]])
  end
end
