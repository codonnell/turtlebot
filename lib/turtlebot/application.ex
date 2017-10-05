defmodule Turtlebot.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    # List all child processes to be supervised
    children = [
      supervisor(Turtlebot.Repo, [])
      # Starts a worker by calling: TestApp.Worker.start_link(arg)
      # {TestApp.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Turtlebot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
