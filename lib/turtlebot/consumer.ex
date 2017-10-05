defmodule Turtlebot.Consumer do
  # use Nostrum.Consumer
  # alias Nostrum.Api
  #
  # def start_link do
  #   Consumer.start_link(__MODULE__, :state)
  # end
  #
  # def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}, state) do
  #   case msg.content do
  #     "!sleep!" ->
  #       Api.create_message(msg.channel_id, "I'll read you a bedtime story...")
  #     "!ping" ->
  #       Api.create_message(msg.channel_id, "No way, I aint no bitch!")
  #     _ ->
  #       :noop
  #   end
  #
  #   {:ok, state}
  # end
  #
  # def handle_event(_, state) do
  #   {:ok, state}
  # end
end
