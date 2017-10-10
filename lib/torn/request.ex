defmodule Torn.Request do
  @enforce_keys [:api_key, :selections]
  defstruct [:id, :api_key, :selections, :timestamp, {:endpoint, "user"}]

  def url(%Torn.Request{api_key: api_key, id: id, selections: selections,
    timestamp: timestamp, endpoint: endpoint}) do
      "https://api.torn.com/#{endpoint}/#{format_id(id)}?selections=" <>
        "#{format_selections(selections)}&key=#{api_key}#{format_timestamp(timestamp)}"
  end

  defp format_selections(selections) do
    Enum.join(selections, ",")
  end

  defp format_id(id) do
    if id == nil, do: "", else: Integer.to_string(id)
  end

  defp format_timestamp(timestamp) do
    if timestamp == nil, do: "", else: "&timestamp=#{Torn.Util.to_torn_timestamp(timestamp)}"
  end
end
