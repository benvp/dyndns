defmodule Dyndns.Dns.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :ip, :string

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:ip])
    |> validate_required([:ip])
  end
end
