defmodule PingPong do
  @finish_game 11

  def ready do
    receive do
      {sender, action, @finish_game} ->
        IO.puts "And #{inspect sender} wins with a final #{inspect action} on round {11}"
        ready

      {sender, action, turn} ->
        hit_to sender, switch(action), turn+1
        ready

    after
      1_000 -> IO.puts "Timing out player #{inspect player_pid}"
    end
  end

  def hit_to(opponent_id, action, turn) do
    IO.puts "#{turn}. #{inspect player_pid} hit_to #{inspect opponent_id} #{inspect action}"
    send opponent_id, {player_pid, action, turn}
  end

  defp switch(action) do
    case action do
      :ping -> :pong
      _     -> :ping
    end
  end

  defp player_pid, do: self
end

player_1 = self
player_2 =
  PingPong
  |> Task.start(:ready, [])
  |> elem(1)

IO.puts "1st_player: #{inspect player_1}"
IO.puts "2nd_player: #{inspect player_2}"

PingPong.hit_to player_2, :ping, 1

PingPong.ready
