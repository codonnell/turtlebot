defmodule Torn.User.Events.HTTPClient do
  use HTTPoison.Base


  def process_url(url) do
    "https://api.torn.com" <> url
  end

  def parse_event_pair({id, event}) do
    {String.to_integer(id), Map.update!(event, "timestamp", &Torn.Util.from_torn_timestamp/1)}
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Map.fetch!("events")
    |> Enum.into(%{}, &parse_event_pair/1)
  end
end
