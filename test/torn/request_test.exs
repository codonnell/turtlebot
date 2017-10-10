defmodule Torn.RequestTest do
  use ExUnit.Case
  alias Torn.Request

  test "formats urls properly" do
    base_url = "https://api.torn.com"
    req = %Request{selections: ["profile"], api_key: "foo", endpoint: "user"}
    assert base_url <> "/user/?selections=profile&key=foo" == Request.url(req)
    assert base_url <> "/user/1?selections=profile&key=foo" == Request.url(%{req | id: 1})
    timestamp = Torn.Util.from_torn_timestamp(0)
    assert base_url <> "/user/?selections=profile&key=foo&timestamp=0" ==
      Request.url(%{req | timestamp: timestamp})
  end
end
