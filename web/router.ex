defmodule Interview.Router do
  use Interview.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Interview do
    pipe_through :api

    get "/", SearchController, :index
    get "/:app_id", SearchController, :search
    post "/:app_id", SearchController, :create
    resources "/events", EventController
  end
end
