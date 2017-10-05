defmodule Turtlebot.Repo.Migrations.CreateRevives do
  use Ecto.Migration

  def change do
    create table(:revives) do
      add :reviver, :integer, null: false
      add :timestamp, :naive_datetime, null: false
    end
  end
end
