defmodule DailyMealsWeb.MealsController do
  use DailyMealsWeb, :controller
  alias DailyMeals.Meal
  alias DailyMealsWeb.FallbackController

  action_fallback(FallbackController)

  def create(conn, %{"description" => description, "date" => date, "calories" => calories}) do
    date_parser =
      date
      |> String.trim()
      |> String.split("/")
      |> List.update_at(0, &String.to_integer/1)
      |> List.update_at(1, &String.to_integer/1)
      |> List.update_at(2, &String.to_integer/1)

    [head | tail] = date_parser

    date_time = UTCDateTime.from_date(Date.new!(List.last(tail), List.first(tail), head))

    meal_params = %{description: description, date: date_time, calories: calories}

    with {:ok, %Meal{} = meal} <- DailyMeals.create_meal(meal_params) do
      conn
      |> put_status(:created)
      |> render("create.json", meal: meal)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Meal{} = meal} <- DailyMeals.get_meal_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", meal: meal)
    end
  end
end
