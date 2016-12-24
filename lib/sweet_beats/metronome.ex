defmodule SweetBeats.Metronome do
  use GenServer

  @tempo 125 # milliseconds, i.e. eighth notes

 def start_link do
   GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
 end

 def init(state) do
   start_timer()
   {:ok, state}
 end

 def handle_info(:tick, state) do
   Registry.dispatch(SweetBeats.Registry, "track", fn tracks ->
     for {pid, _} <- tracks, do: send(pid, :play)
   end)

   {:noreply, state}
 end

 defp start_timer() do
   :timer.send_interval(@tempo, __MODULE__, :tick)
 end
end
