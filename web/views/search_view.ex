defmodule Interview.SearchView do
  use Interview.Web, :view

  def render("index.json", %{events: events}) do
    Enum.map(events, &event_json/1)
  end

  def render("search.json", %{events: events}) do
    Enum.map(events, &event_json/1)
  end

  def render("show.json", %{event: event}) do
    event_json(event)
  end

  def event_json(event) do
    %{ start: event.start,
       end: event.end,
       method: event.method,
       url: event.url}
  end
end
