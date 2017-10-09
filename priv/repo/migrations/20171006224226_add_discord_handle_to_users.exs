defmodule Turtlebot.Repo.Migrations.AddDiscordHandleToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :discord_id, :integer
    end
  end
end
