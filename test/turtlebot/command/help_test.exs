defmodule Turtlebot.Command.HelpTest do
  use ExUnit.Case, async: true
  alias Turtlebot.CommandRegistry

  setup do
    {:ok, registry} = start_supervised(Turtlebot.CommandRegistry)
    command_stub = %Turtlebot.Command{name: "stub", usage: "usage", description: "description",
      handler: fn(_) -> {:ok} end}
    CommandRegistry.put(registry, command_stub)
    %{registry: registry, command_stub: command_stub}
  end

  test "command help contains description and usage",
  %{registry: registry, command_stub: command_stub} do
    {:ok, help} = CommandRegistry.fetch(registry, "help")
    {:reply, {_channel_id, msg}} = help.handler.(%{contents: "!help #{command_stub.name}",
      channel_id: 0})
    IO.puts msg
    assert String.contains? msg, command_stub.usage
    assert String.contains? msg, command_stub.description
  end

  test "help lists every command", %{registry: registry} do
    {:ok, help} = CommandRegistry.fetch(registry, "help")
    {:reply, {_channel_id, msg}} = help.handler.(%{contents: "!help", channel_id: 0})
    assert Enum.all?(CommandRegistry.list_commands(registry), fn(name) -> 
      String.contains?(msg, name) 
    end)
  end
end
