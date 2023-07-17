defmodule DailyMealsWeb.MealsViewTest do
  use DailyMealsWeb.ConnCase, async: true
  alias DailyMealsWeb.MealsView
  alias DailyMeals.Meal
  import Phoenix.View
  import DailyMeals.Factory

  test "renders create.json" do
    meal = build(:meal)

    %{date: date_meal} = meal

    response = render(MealsView, "create.json", meal: meal)

    assert %{
             meal: %Meal{
               id: "23ef65a1-294e-46c3-934e-718ea3c74499",
               description: "comida muito muito gostosa",
               date: date_meal,
               calories: "1 cal",
               inserted_at: nil,
               updated_at: nil
             },
             message: "Meal created!"
           } = response
  end
end
