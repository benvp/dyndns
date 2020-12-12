defmodule Dyndns.Repo do
  use Ecto.Repo,
    otp_app: :dyndns,
    adapter: Ecto.Adapters.Postgres
end
