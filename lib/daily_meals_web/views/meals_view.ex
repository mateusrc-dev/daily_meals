defmodule DailyMealsWeb.MealsView do
  use DailyMealsWeb, :view

  alias DailyMeals.Meal

  def render("create.json", %{meal: %Meal{} = meal}) do
    %{
      message: "Meal created!",
      meal: meal
    }
  end
end
