defmodule Torn.ApiTest do
  use ExUnit.Case

  defmodule MockHTTPClient do
    # This is total overkill, but I really like pattern matching on the request
    def get(url) do
      request = recover_request(url)
      get_with_request(request)
    end

    defp get_with_request(%Torn.Request{api_key: "invalid"}) do
      wrap_resp(%{"error" => %{"code" => 2, "error" => "Incorrect Key"}})
    end

    defp get_with_request(%Torn.Request{api_key: "httperror"}) do
      {:error, %HTTPoison.Error{id: nil, reason: :nxdomain}}
    end

    defp get_with_request(%Torn.Request{api_key: "valid"}) do
      wrap_resp(%{"name" => "foo", "player_id" => 1234})
    end


    defp wrap_resp(map) do
      {:ok, %{body: Poison.encode!(map)}}
    end

    defp recover_request(url) do
      regex = ~r"https://api.torn.com/(?<endpoint>\w+)/(?<id>\d*)\?selections=(?<selections>[^&]+)&key=(?<api_key>[^&]+)(?<timestamp>&timestamp=\d+)?"
      captures = Regex.named_captures(regex, url)
      %Torn.Request{api_key: captures["api_key"], endpoint: captures["endpoint"],
                    selections: parse_selections(captures["selections"]),
                    id: parse_id(captures["id"]),
                    timestamp: parse_timestamp(captures["timestamp"])}
    end

    defp parse_selections(selections) do
      String.split(selections, ",")
    end

    defp parse_id(id) do
      if id == "" do
        nil
      else
        id
      end
    end

    defp parse_timestamp(timestamp) do
      if timestamp == "" do
        nil
      else
        timestamp
        |> String.trim_leading("&timestamp=")
        |> String.to_integer
      end
    end
  end

  test "api error results in error" do
    request = %Torn.Request{selections: ["profile"], api_key: "invalid"}
    assert {:error, _} = Torn.Api.get(request, MockHTTPClient)
  end

  test "http error results in error" do
    request = %Torn.Request{selections: ["profile"], api_key: "httperror"}
    assert {:error, %HTTPoison.Error{}} = Torn.Api.get(request, MockHTTPClient)
  end

  test "returns ok when no errors" do
    request = %Torn.Request{selections: ["basic"], api_key: "valid"}
    assert {:ok, _} = Torn.Api.get(request, MockHTTPClient)
  end
end
