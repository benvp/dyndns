defmodule Dyndns.Dns.Service do
  @config Application.get_env(:dyndns, Dyndns.Dns)

  @base_url @config[:host_url]
  @domain @config[:domain]
  @subdomains @config[:subdomains]
  @token @config[:token]

  def get_record_by_name(name) do
    url = "#{@base_url}/domains/#{@domain}/records"

    case HTTPoison.get(url, %{
           Authorization: "Bearer #{@token}"
         }) do
      {:ok, res} ->
        record =
          res.body
          |> Jason.decode!()
          |> Map.get("records")
          |> Enum.find(fn r -> r["name"] == name end)

        {:ok, record}

      v ->
        v
    end
  end

  def update(ip) do
    updates =
      @subdomains
      |> Enum.map(fn d ->
        {:ok, update} = update_subdomain(d, ip)
        update
      end)

    {:ok, updates}
  end

  defp update_subdomain(subdomain, ip) do
    with {:ok, record} <- get_record_by_name(subdomain) do
      url = "#{@base_url}/domains/records/#{record["id"]}"

      res =
        HTTPoison.patch(
          url,
          Jason.encode!(%{
            name: record["name"],
            ttl: record["ttl"],
            type: record["type"],
            value: ip
          }),
          %{
            Authorization: "Bearer #{@token}"
          }
        )

      case res do
        {:ok, value} -> {:ok, Jason.decode!(value.body)}
        v -> v
      end
    else
      err ->
        err
    end
  end
end
