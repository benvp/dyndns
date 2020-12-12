defmodule Dyndns.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :ip, :string

      timestamps()
    end

  end
end
