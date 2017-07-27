defmodule Interview.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :app_id, :integer
      add :start, :integer
      add :end, :integer
      add :method, :string
      add :url, :string

      timestamps()
    end

  end
end
