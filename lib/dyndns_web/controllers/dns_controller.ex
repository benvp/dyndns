defmodule DyndnsWeb.DnsController do
  use DyndnsWeb, :controller

  alias Dyndns.Dns

  def update(conn, %{"ip" => ip}) do
    latest = Dns.get_latest()

    if latest == nil || latest.ip != ip do
      case Dns.update_ip(ip) do
        {:ok, entry} ->
          conn
          |> json(%{ip: entry.ip, success: true})

        _ ->
          conn
          |> json(%{ip: nil, success: false})
      end
    else
      conn
      |> json(%{ip: latest.ip, success: false})
    end
  end
end
