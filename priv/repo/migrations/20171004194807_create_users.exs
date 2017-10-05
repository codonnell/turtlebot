defmodule Turtlebot.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :torn_id, :integer
      add :api_key, :string
    end
  end
end
