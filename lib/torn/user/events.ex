defmodule Torn.User.Events do
  def get(api_key, client) do
    client.get url(api_key)
  end

  def get(api_key, timestamp, client) do
    client.get url(api_key, timestamp)
  end

  def get!(api_key, client) do
    client.get! url(api_key)
  end

  def get!(api_key, timestamp, client) do
    client.get! url(api_key, timestamp)
  end

  defp url(api_key), do: "/user/?selections=events&key=#{api_key}"
  defp url(api_key, timestamp) do
    "/user/?selections=events&key=#{api_key}&timestamp=#{Torn.Util.to_torn_timestamp(timestamp)}"
  end

  def parse_revive(event) do
    case Regex.named_captures(~r/.*XID=(?<id>\d+).*revived.*/, event["event"]) do
      %{"id" => id} ->
        {:ok, %{"id" => String.to_integer(id), "timestamp" => event["timestamp"]}}
      _ ->
        {:error, "The event is not a revive"}
    end
  end
end
