defmodule Interview.Event do
  use Interview.Web, :model
  import Ecto.Query

  schema "events" do
    field :app_id, :integer
    field :start, :integer
    field :end, :integer
    field :method, :string
    field :url, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:app_id, :start, :end, :method, :url])
    |> validate_required([:app_id, :start, :end, :method, :url])
  end

  def by_app_id(queryable \\ Interview.Event, app_id) do
    from queryable, where: [app_id: ^app_id]
  end

  def between(queryable \\ Interview.Event, start_time, end_time) do
    from e in queryable,
      where: e.start >= ^start_time and e.start < ^end_time,
      or_where: e.end > ^start_time and e.end <= ^end_time
  end

  def sorted_by_start_time(queryable \\ Interview.Event) do
    from e in queryable, order_by: [:start, :end]
  end
end
