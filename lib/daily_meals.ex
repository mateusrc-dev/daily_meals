defmodule DailyMeals do
  alias DailyMeals.Meals.Create, as: MealCreate
  alias DailyMeals.Meals.Get, as: MealGet
  alias DailyMeals.Meals.Delete, as: MealDelete
  alias DailyMeals.Meals.Update, as: MealUpdate

  alias DailyMeals.Users.Create, as: UserCreate
  alias DailyMeals.Users.Get, as: UserGet
  alias DailyMeals.Users.Update, as: UserUpdate
  alias DailyMeals.Users.Delete, as: UserDelete

  defdelegate create_meal(params), to: MealCreate, as: :call
  defdelegate delete_meal(id), to: MealDelete, as: :call
  defdelegate get_meal_by_id(id), to: MealGet, as: :by_id
  defdelegate update_meal(params), to: MealUpdate, as: :call

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate update_user(params), to: UserUpdate, as: :call
  defdelegate delete_user(id), to: UserDelete, as: :call
end
