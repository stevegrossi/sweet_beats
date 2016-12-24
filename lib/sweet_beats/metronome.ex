defmodule SweetBeats.Metronome do
  use GenServer

 def start_link(tempo) do
   GenServer.start_link(__MODULE__, tempo, name: __MODULE__)
 end

 def init(tempo) do
   start_timer(tempo)
   {:ok, tempo}
 end

 def handle_info(:tick, state) do
   Registry.dispatch(SweetBeats.Registry, "track", fn tracks ->
     for {pid, _} <- tracks, do: send(pid, :play)
   end)

   {:noreply, state}
 end

 defp start_timer(tempo) do
   :timer.send_interval(tempo, __MODULE__, :tick)
 end
end
