defmodule DailyMeals.Factory do
  use ExMachina
  alias DailyMeals.Meal

  def meal_params_factory do
    %{
      description: "comida muito muito gostosa",
      date: UTCDateTime.from_date(Date.new!(2023, 10, 10)),
      calories: "1 cal"
    }
  end

  def meal_factory do
    %Meal{
      description: "comida muito muito gostosa",
      date: UTCDateTime.from_date(Date.new!(2023, 10, 10)),
      calories: "1 cal",
      id: "23ef65a1-294e-46c3-934e-718ea3c74499"
    }
  end
end
