defmodule DailyMeals do
  alias DailyMeals.Meals.Create, as: MealCreate
  alias DailyMeals.Meals.Get, as: MealGet

  defdelegate create_meal(params), to: MealCreate, as: :call
  defdelegate get_meal_by_id(id), to: MealGet, as: :by_id
end
