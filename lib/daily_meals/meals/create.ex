defmodule DailyMeals.Meals.Create do
  alias DailyMeals.{Meal, Repo}
  alias DailyMeals.Meal

  def call(params) do
    params
    |> Meal.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Meal{}} = result) do
    result
  end

  defp handle_insert({:error, result}) do
    {:error, %{status: :bad_request, result: result}}
  end
end
