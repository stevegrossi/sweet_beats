defmodule SweetBeats.Rhythm do
  use GenServer

  @rest "."

  def start_link(sample_file, notes) do
    GenServer.start_link(__MODULE__, {sample_file, notes})
  end

  def init(state) do
    {:ok, _} = Registry.register(SweetBeats.Registry, "track", [])
    {:ok, state}
  end

  def handle_info(:play, {sample_file, [head | tail]}) do
    play_sample(sample_file, head)
    shifted_notes = tail ++ [head]
    {:noreply, {sample_file, shifted_notes}}
  end

  defp play_sample(_sample_file, @rest), do: nil
  defp play_sample(sample_file, _note) do
    spawn(System, :cmd, ["play", ["-q", "samples/#{sample_file}"]])
  end
end
