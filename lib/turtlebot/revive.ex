defmodule Turtlebot.Revive do
  use Ecto.Schema

  alias Turtlebot.{Repo, Revive}

  import Ecto.Query, only: [from: 2]

  schema "revives" do
    field :reviver, :integer
    field :timestamp, :naive_datetime
    belongs_to :user, Turtlebot.User
  end

  @doc """
  Stores a revive in the database. The revive's user must already be in the database.
  """
  def store_revive_for(user, revive) do
    user
    |> Ecto.build_assoc(:revives, Map.from_struct(revive))
    |> Repo.insert
  end

  @doc """
  Retrieves all of a user's revives.
  """
  def revives_for(user) do
    Repo.all(from r in Revive,
             where: ^user.id == r.user_id,
             select: r)
  end

  @doc """
  Retrieves all of the revives by a reviver.
  """
  def revives_by(reviver) do
    Repo.all(from r in Revive,
             where: ^reviver == r.reviver,
             select: r)
             |> Repo.preload(:user)
  end

  @doc """
  Returns the number of revives by a reviver.
  """
  def count_revives_by(reviver) do
    Repo.one(from r in Revive,
             where: ^reviver == r.reviver,
             select: count(r.id))
  end
end
