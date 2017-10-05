defmodule Turtlebot.Repo.Migrations.ReviveBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:revives) do
      add :user_id, references(:users)
    end
  end
end
