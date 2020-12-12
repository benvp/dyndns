defmodule Dyndns.DnsTest do
  use Dyndns.DataCase

  alias Dyndns.Dns

  describe "entries" do
    alias Dyndns.Dns.Entry

    @valid_attrs %{ip: "some ip"}
    @update_attrs %{ip: "some updated ip"}
    @invalid_attrs %{ip: nil}

    def entry_fixture(attrs \\ %{}) do
      {:ok, entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dns.create_entry()

      entry
    end

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Dns.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Dns.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = Dns.create_entry(@valid_attrs)
      assert entry.ip == "some ip"
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dns.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{} = entry} = Dns.update_entry(entry, @update_attrs)
      assert entry.ip == "some updated ip"
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Dns.update_entry(entry, @invalid_attrs)
      assert entry == Dns.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Dns.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Dns.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Dns.change_entry(entry)
    end
  end
end
