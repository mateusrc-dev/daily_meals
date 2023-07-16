defmodule DailyMeals do
  alias DailyMeals.Meals.Create, as: MealCreate

  defdelegate create_meal(params), to: MealCreate, as: :call
end
