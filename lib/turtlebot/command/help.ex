defmodule Turtlebot.Command.Help do
  alias Turtlebot.{CommandRegistry, Command}
  require Logger

  @doc """
  Defines a help command struct, using the passed in registry as a command registry
  """
  def cmd(registry) do
    %Command{
      name: "help",
      usage: "```!help → Lists available commands\n!help [command] → Describes how to use the command```",
      description: "Provides a list of available commands as well as a description of how to use them.",
      handler: handler(registry),
      state: %{registry: registry}
    }
  end

  defp handler(registry) do
    fn(msg) ->
      if msg.content == "!help" do 
        Logger.debug "Help command list"
        {:reply, {msg.channel_id, command_list(registry)}}
      else
        "!help " <> name = msg.content
        Logger.debug "Help for #{name}"
        case CommandRegistry.fetch(registry, name) do
          {:ok, cmd} -> {:reply, {msg.channel_id, command_help(cmd)}}
          :error -> {:reply, {msg.channel_id, "Unknown command: #{name}"}}
        end
      end
    end
  end

  defp command_help(command) do
    "#{command.description}\n#{command.usage}"
  end

  defp command_list(registry) do
    ~s(Commands: #{Enum.join(CommandRegistry.list_commands(registry), ", ")})
  end
end
