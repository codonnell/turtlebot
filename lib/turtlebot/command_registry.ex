defmodule Turtlebot.CommandRegistry do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{"help" => Turtlebot.Command.Help.cmd(self())} end,
                                                                       name: :command_registry)
  end

  def fetch(registry, name) do
    Agent.get(registry, &Map.fetch(&1, name))
  end

  def put(registry, command) do
    Agent.update(registry, &Map.put(&1, command.name, command))
  end

  def list_commands(registry) do
    Agent.get(registry, &Map.keys(&1))
  end
end
