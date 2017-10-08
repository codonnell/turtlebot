# Ecto must be started in the test env
Application.ensure_all_started(:ecto)

ExUnit.start()
