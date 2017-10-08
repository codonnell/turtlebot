defmodule Turtlebot.Command do
  @enforce_keys [:name, :description, :usage, :handler]
  defstruct [:name, :description, :usage, :handler, {:state, nil}]
  @typep channel_id :: Nostrum.Struct.Guild.Channel.id
  @typedoc """
  A discord bot action.
  """
  @type action :: {:reply, {channel_id, String.t}} | {:ok}

  def leader(), do: Application.get_env(:turtlebot, :leader, "!")

  def name(msg_string) do
    if String.starts_with?(msg_string, leader()) do
      {:ok, msg_string |> String.split |> Enum.at(0) |> String.trim_leading(leader())}
    else
      {:error, "Message does not start with #{leader()}"}
    end
  end
end
