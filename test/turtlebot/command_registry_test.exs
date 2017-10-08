defmodule Turtlebot.CommandRegistryTest do
  use ExUnit.Case, async: true
  alias Turtlebot.CommandRegistry

  setup do
    {:ok, registry} = start_supervised(Turtlebot.CommandRegistry)
    command_stub = %Turtlebot.Command{name: "stub", usage: "usage", description: "description",
      handler: fn(_) -> {:ok} end}
    %{registry: registry, command_stub: command_stub}
  end

  test "stores commands by name", %{registry: registry, command_stub: command_stub} do
    assert CommandRegistry.fetch(registry, command_stub.name) == :error

    CommandRegistry.put(registry, command_stub)
    assert CommandRegistry.fetch(registry, command_stub.name) == {:ok, command_stub}
  end

  test "command registry starts with help", %{registry: registry} do
    name = 
      with {:ok, cmd} <- CommandRegistry.fetch(registry, "help"),
        do: cmd.name
    assert name == "help"
  end
end
