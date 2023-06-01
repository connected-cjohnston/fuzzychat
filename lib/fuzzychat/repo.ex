defmodule Fuzzychat.Repo do
  use Ecto.Repo,
    otp_app: :fuzzychat,
    adapter: Ecto.Adapters.Postgres
end
