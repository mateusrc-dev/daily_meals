defmodule DailyMeals.Meals.Create do
  alias DailyMeals.{Error, Meal, Repo}
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
    {:error, Error.build(:bad_request, result)}
  end
end
