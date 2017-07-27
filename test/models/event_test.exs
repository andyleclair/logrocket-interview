defmodule Interview.EventTest do
  use Interview.ModelCase

  import Interview.Factory
  alias Interview.Event

  @valid_attrs %{app_id: 42, end: 42, method: "some content", start: 42, url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "between start and end" do
    event_1 = insert(:event, start: 1, end: 6)
    event_2 = insert(:event, start: 4, end: 10)
    event_3 = insert(:event, start: 7, end: 15)
    _ = insert(:event, start: 12, end: 15)
    query = Event.between(Event, 5, 11)

    assert Repo.all(query) == [ event_1, event_2, event_3 ]
  end

  test "with matching start dates sorts by end" do
    event_1 = insert(:event, start: 1, end: 10)
    event_2 = insert(:event, start: 1, end: 6)
    query = Event.sorted_by_start_time
    assert Repo.all(query) == [ event_2, event_1 ]
  end

end
