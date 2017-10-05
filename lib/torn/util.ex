defmodule Torn.Util do
  @doc """
  Takes a NaiveDateTime and returns the number of seconds since the epoch.
  """
  def to_torn_timestamp(t) do
    NaiveDateTime.diff(t, ~N[1970-01-01 00:00:00])
  end

  @doc """
  Takes an integer and returns a NaiveDateTime representing the number of seconds since the epoch.
  """
  def from_torn_timestamp(t) do
    NaiveDateTime.add(~N[1970-01-01 00:00:00], t)
  end
end
