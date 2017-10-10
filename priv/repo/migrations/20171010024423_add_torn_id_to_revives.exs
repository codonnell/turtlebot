defmodule Turtlebot.Repo.Migrations.AddTornIdToRevives do
  use Ecto.Migration

  def change do
    alter table(:revives) do
      add :torn_id, :integer
    end
  end
end
