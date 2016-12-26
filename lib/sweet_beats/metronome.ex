defmodule SweetBeats.Metronome do
  use GenServer

  @notes_per_beat 4

 def start_link({:bpm, bpm}) do
   GenServer.start_link(__MODULE__, bpm, name: __MODULE__)
 end

 def init(bpm) do
   start_timer(bpm)
   {:ok, bpm}
 end

 def handle_info(:tick, state) do
   Registry.dispatch(SweetBeats.Registry, "track", fn tracks ->
     for {pid, _} <- tracks, do: send(pid, :play)
   end)

   {:noreply, state}
 end

 defp start_timer(bpm) do
   beats_per_second = bpm / 60
   notes_per_second = beats_per_second * @notes_per_beat
   fraction_of_second_per_note = 1 / notes_per_second
   interval = round(fraction_of_second_per_note * 1000)
   :timer.send_interval(interval, __MODULE__, :tick)
 end
end
