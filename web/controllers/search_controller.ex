defmodule Interview.SearchController do
  use Interview.Web, :controller

  alias Interview.Event

  def index(conn, _params) do
    events = Repo.all(Event)
    render(conn, "index.json", events: events)
  end

  def search(conn, %{ "app_id" => app_id,
                      "start" => start_time,
                      "end" => end_time }) do
    events = Event.between(start_time, end_time)
      |> Event.by_app_id(app_id)
      |> Event.sorted_by_start_time
      |> Repo.all
    render(conn, "search.json", events: events)
  end

  def create(conn, event_params) do

    changeset = Event.changeset(%Event{}, event_params)

    case Repo.insert(changeset) do
      {:ok, event} ->
        conn
        |> put_status(:created)
        |> render("show.json", event: event)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Interview.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
