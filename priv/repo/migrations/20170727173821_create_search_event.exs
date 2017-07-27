defmodule Interview.Repo.Migrations.CreateSearchEvent do
  use Ecto.Migration

  def change do
    create table(:search_events) do
      add :app_id, :integer
      add :start_time, :integer
      add :end_time, :integer
      add :method, :string
      add :url, :string

      timestamps()
    end

  end
end
