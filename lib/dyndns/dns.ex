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
    {:ok, %{"value" => new_ip}} = Service.update(ip)

    Logger.info("Updated ip to #{new_ip}")

    %Entry{}
    |> Entry.changeset(%{ip: new_ip})
    |> Repo.insert()
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
