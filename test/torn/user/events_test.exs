defmodule Torn.User.EventsTest do
  use ExUnit.Case
  import Torn.User.Events

  test "parse_revive" do
    msg = ~s'<a href="profiles.php?XID=1946152>sullengenie</a> revived you, you are now out of the hospital.'
    timestamp = ~N[1970-01-01 00:00:00]
    expected = %{"id" => 1946152, "timestamp" => timestamp}
    event = %{"event" => msg, "seen" => 0, "timestamp" => timestamp}
    assert {:ok, expected} == parse_revive(event)

    other_msg = ~s'CrazedOne - Director of Just Fer Cruisin...'
    other_event = %{"event" => other_msg, "seen" => 0, "timestamp" => timestamp}
    assert {:error, "The event is not a revive"} == parse_revive(other_event)
  end
end
