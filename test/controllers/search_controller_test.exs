defmodule Interview.SearchControllerTest do
  use Interview.ConnCase

  import Interview.Factory

  test "index returns a list of Events" do
    conn = build_conn()
    event = insert(:event)

    conn = get conn, search_path(conn, :index)

    assert json_response(conn, 200) == [
      %{ "start" => event.start,
         "end" => event.end,
         "method" => event.method,
         "url" => event.url } ]
  end

  test "create adds a new Event" do
    conn = build_conn()
    params = params_for(:event)

    conn = post conn, search_path(conn, :create, "1", params)

    assert json_response(conn, 201) == %{
      "start" => params.start,
      "end" => params.end,
      "method" => params.method,
      "url" => params.url }
  end

  test "create with empty params returns 422" do
    conn = build_conn()
    params = %{}

    conn = post conn, search_path(conn, :create, "1", params)

    assert json_response(conn, 422)
  end

  test "search with empty params returns 422" do
    conn = build_conn()
    params = %{}

    # Strong params, must match!
    assert_raise Phoenix.ActionClauseError, fn ->
      conn = get conn, search_path(conn, :search, "1", params)
      json_response(conn, 422)
    end
  end
end
