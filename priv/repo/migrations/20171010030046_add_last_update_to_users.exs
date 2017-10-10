defmodule Turtlebot.Repo.Migrations.AddLastUpdateToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :last_update, :naive_datetime
    end
  end
end
