defmodule DailyMeals do
  alias DailyMeals.Meals.Create, as: MealCreate
  alias DailyMeals.Meals.Get, as: MealGet
  alias DailyMeals.Meals.Delete, as: MealDelete

  defdelegate create_meal(params), to: MealCreate, as: :call
  defdelegate delete_meal(id), to: MealDelete, as: :call
  defdelegate get_meal_by_id(id), to: MealGet, as: :by_id
end
