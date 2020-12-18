defmodule DyndnsWeb.DnsController do
  use DyndnsWeb, :controller

  alias Dyndns.Dns

  def update(conn, %{"ip" => ip}) do
    latest = Dns.get_latest()

    if latest == nil || latest.ip != ip do
      :ok = Dns.update_ip(ip)

      conn
      |> json(%{success: true})
    else
      conn
      |> json(%{success: false})
    end
  end
end
