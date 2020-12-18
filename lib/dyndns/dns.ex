defmodule Dyndns.Dns do
  @moduledoc """
  The Dns context.
  """

  import Ecto.Query, warn: false

  alias Dyndns.Repo

  alias Dyndns.Dns.Entry
  alias Dyndns.Dns.Service

  require Logger

  def update_ip(ip) do
    {:ok, updates} = Service.update(ip)

    Enum.each(updates, fn %{"value" => new_ip} ->
      Logger.info("Updated ip to #{new_ip}")
    end)

    updates
    |> Enum.map(fn %{"value" => new_ip} -> Entry.changeset(%Entry{}, %{ip: new_ip}) end)
    |> Enum.map(&Repo.insert!/1)

    :ok
  end

  def get_latest do
    query = from e in Entry, order_by: [desc: e.id], limit: 1

    Repo.one(query)
  end

  @doc """
  Returns the list of entries.

  ## Examples

      iex> list_entries()
      [%Entry{}, ...]

  """
  def list_entries do
    Repo.all(Entry)
  end

  @doc """
  Gets a single entry.

  Raises `Ecto.NoResultsError` if the Entry does not exist.

  ## Examples

      iex> get_entry!(123)
      %Entry{}

      iex> get_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entry!(id), do: Repo.get!(Entry, id)
end
