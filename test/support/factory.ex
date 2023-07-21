defmodule DailyMeals.Factory do
  use ExMachina
  alias DailyMeals.Meal

  def meal_params_factory do
    %{
      description: "comida muito muito gostosa",
      date: UTCDateTime.from_date(Date.new!(2023, 10, 10)),
      calories: "1 cal",
      user_id: "48ed93c0-5968-4fd8-9a2a-f64478678522"
    }
  end

  def meal_factory do
    %Meal{
      description: "comida muito muito gostosa",
      date: UTCDateTime.from_date(Date.new!(2023, 10, 10)),
      calories: "1 cal",
      id: "23ef65a1-294e-46c3-934e-718ea3c74499",
      user_id: "48ed93c0-5968-4fd8-9a2a-f64478678522"
    }
  end

  def user_params_factory do
    %{
      name: "Mateus Raimundo de Carvalho",
      cpf: "12345678901",
      email: "mateus@email.com"
    }
  end
end
