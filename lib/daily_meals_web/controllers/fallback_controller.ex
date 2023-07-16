defmodule DailyMealsWeb.FallbackController do
  use DailyMealsWeb, :controller

  alias DailyMealsWeb.ErrorView

  def call(conn, {:error, %{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
