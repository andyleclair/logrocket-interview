defmodule Interview.Factory do

  use ExMachina.Ecto, repo: Interview.Repo

  def event_factory do
    %Interview.Event{
      app_id: 1,
      start: Enum.random(1..10000),
      end: Enum.random(10001..20000),
      method: "POST",
      url: sequence(:url, &"/thing-#{&1}")
    }
  end
end
