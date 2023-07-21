defmodule DailyMealsWeb.MealsController do
  # alias DailyMealsWeb.MealsView
  use DailyMealsWeb, :controller
  alias DailyMeals.Meal
  alias DailyMealsWeb.FallbackController
  alias DailyMeals.Error

  action_fallback(FallbackController)

  def create(conn, %{
        "description" => description,
        "date" => date,
        "calories" => calories,
        "user_id" => user_id
      }) do
    date_parser =
      date
      |> String.trim()
      |> String.split("/")
      |> List.update_at(0, &String.to_integer/1)
      |> List.update_at(1, &String.to_integer/1)
      |> List.update_at(2, &String.to_integer/1)

    [head | tail] = date_parser

    case Date.new(List.last(tail), List.first(tail), head) do
      {:error, :invalid_date} ->
        {:error, Error.build(:bad_request, "Invalid date insert")}

      {:ok, date_correct} ->
        date_time = UTCDateTime.from_date(date_correct)

        meal_params = %{
          description: description,
          date: date_time,
          calories: calories,
          user_id: user_id
        }

        with {:ok, %Meal{} = meal} <- DailyMeals.create_meal(meal_params) do
          conn
          |> put_status(:created)
          |> render("create.json", meal: meal)
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Meal{}} <- DailyMeals.delete_meal(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Meal{} = meal} <- DailyMeals.get_meal_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    end
  end

  def update(
        conn,
        %{
          "id" => id,
          "description" => description,
          "date" => date,
          "calories" => calories,
          "user_id" => user_id
        } =
          _params
      ) do
    date_parser =
      date
      |> String.trim()
      |> String.split("/")
      |> List.update_at(0, &String.to_integer/1)
      |> List.update_at(1, &String.to_integer/1)
      |> List.update_at(2, &String.to_integer/1)

    [head | tail] = date_parser

    date_time = UTCDateTime.from_date(Date.new!(List.last(tail), List.first(tail), head))

    meal_params = %{
      "id" => id,
      "description" => description,
      "date" => date_time,
      "calories" => calories,
      "user_id" => user_id
    }

    with {:ok, %Meal{} = meal} <- DailyMeals.update_meal(meal_params) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    end
  end

  def update(conn, params) do
    with {:ok, %Meal{} = meal} <- DailyMeals.update_meal(params) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    end
  end
end
