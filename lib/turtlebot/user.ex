defmodule Turtlebot.User do
  use Ecto.Schema

  alias Turtlebot.Repo
  alias Ecto.Changeset

  schema "users" do
    field :discord_id, :integer
    field :torn_id, :integer
    field :api_key, :string
    has_many :revives, Turtlebot.Revive
  end

  @doc """
  Stores a user in the database.
  """
  def store_user(user) do
    user
    |> Changeset.cast(%{}, [:torn_id, :api_key])
    |> Changeset.validate_required([:torn_id, :api_key])
    |> Changeset.validate_number(:torn_id, greater_than: 0)
    |> Repo.insert()
  end

  @doc """
  Unregisters a user by deleting their api key.
  """
  def unregister(user) do
    user
    |> Changeset.change(%{api_key: nil})
    |> Repo.update
  end

  @doc """
  Reregisters an existing user by updating their api key.
  """
  def reregister(user, api_key) do
    user
    |> Changeset.cast(%{api_key: api_key}, [:api_key])
    |> Changeset.validate_required([:api_key])
    |> Repo.update
  end
end
