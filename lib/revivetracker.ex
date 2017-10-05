defmodule ReviveTracker do
  alias Torn.User.Events

  def new_revives(api_key) do
    {:ok, resp} = Events.get(api_key, Events.HTTPClient)
    Enum.filter(resp.body,
                fn {_id, event} -> 
                  case Events.parse_revive(event) do
                    {:ok, _} -> true
                    _ -> false
                  end 
                end)

  end
end
