defmodule Torn.Api do
  @doc """
  Makes a request to the Torn API using client. Returns either {:ok, body},
  where body is the body of the JSON response, decoded, or {:error, reason}.
  """
  def get(request, client) do
    with {:ok, resp} <- client.get(Torn.Request.url(request)),
         {:ok, body} <- Poison.decode(resp.body),
      do: parse_body(body)
  end

  defp parse_body(body) do
    case body do
      %{"error" => error} -> {:error, error}
      body -> {:ok, body}
    end
  end
end
