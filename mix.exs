defmodule Turtlebot.Mixfile do
  use Mix.Project

  def project do
    [
      app: :turtlebot,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :nostrum],
      mod: {Turtlebot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nostrum, git: "https://github.com/Kraigie/nostrum.git"},
      {:gun, git: "https://github.com/ninenines/gun.git", ref: "dd1bfe4d6f9fb277781d922aa8bbb5648b3e6756", override: true},
      {:ecto, "~> 2.0"},
      {:postgrex, "~> 0.11"},
      {:httpoison, "~> 0.11"},
      {:poison, "~> 3.1"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp aliases do
    [
      test: "test --no-start"
    ]
  end
end
