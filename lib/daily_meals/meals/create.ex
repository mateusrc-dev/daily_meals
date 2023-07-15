defmodule DailyMeals.Meals.Create do
  alias DailyMeals.{Meal, Repo}

  def call(params) do
    params
    |> Meal.changeset()
    |> Repo.insert()
  end
end
