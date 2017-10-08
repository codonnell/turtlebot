defmodule Turtlebot.Consumer do
  use Nostrum.Consumer
  require Logger
  alias Nostrum.Api
  alias Turtlebot.{Command, CommandRegistry}

  def start_link do
    Consumer.start_link(__MODULE__, :state)
  end

  def handle_action({:reply, {channel_id, msg}}) do
    Logger.debug "Reply: #{msg}"
    Api.create_message(channel_id, msg)
  end

  def handle_action({:ok}), do: :ok

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}, state) do
    IO.inspect msg
    with {:ok, name} <- Command.name(msg.content),
         {:ok, cmd} <- CommandRegistry.fetch(:command_registry, name),
      do: handle_action(cmd.handler.(msg))
    # Logger.debug "#{msg.author.id}: #{msg.content}"
    # case msg.content do
    #   "!sleep" ->
    #     Api.create_message(msg.channel_id, "I'll read you a bedtime story...")
    #   "!ping" ->
    #     Api.create_message(msg.channel_id, "No way, I aint no bitch!")
    #   "!revcount " <> id ->
    #     Api.create_message(msg.channel_id, "#{id} has done #{Turtlebot.Revive.count_revives_by(String.to_integer(id))} revives")
    #   _ ->
    #     :noop
    # end

    {:ok, state}
  end

  def handle_event(_, state) do
    {:ok, state}
  end
end
