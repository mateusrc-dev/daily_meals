defmodule DailyMealsWeb.MealsView do
  use DailyMealsWeb, :view

  alias DailyMeals.Meal

  def render("create.json", %{meal: %Meal{} = meal}) do
    %{
      message: "Meal created!",
      meal: meal
    }
  end

  def render("meal.json", %{meal: %Meal{} = meal}) do
    %{meal: meal}
  end
end
