defmodule DailyMealsWeb.WelcomeController do
  use DailyMealsWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("Welcome :)")
  end
end
