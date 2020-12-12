defmodule DyndnsWeb.DnsController do
  use DyndnsWeb, :controller

  alias Dyndns.Dns

  def update(conn, %{"ip" => ip}) do
    IO.inspect(ip)

    case Dns.update_ip(ip) do
      {:ok, entry} ->
        conn
        |> json(%{ip: entry.ip, success: true})

      _ ->
        conn
        |> json(%{ip: nil, success: false})
    end
  end
end
