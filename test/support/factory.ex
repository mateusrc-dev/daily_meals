defmodule DailyMeals.Factory do
  use ExMachina

  def meal_params_factory do
    %{
      description: "comida muito muito gostosa",
      date: UTCDateTime.from_date(Date.new!(2023, 10, 10)),
      calories: "1 cal"
    }
  end
end
