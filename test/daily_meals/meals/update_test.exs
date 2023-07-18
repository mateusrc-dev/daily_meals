defmodule DailyMeals.Meals.UpdateTest do
  use DailyMeals.DataCase, async: true
  alias DailyMeals.{Error, Meal}
  alias DailyMeals.Meals.Create
  alias DailyMeals.Meals.Update
  alias DailyMeals.Error
  import DailyMeals.Factory

  describe "call/1" do
    test "when all params are valid, returns the meal" do
      params = build(:meal_params)

      meal = Create.call(params)

      {:ok,
       %DailyMeals.Meal{
         id: id
       }} = meal

      params_update = %{
        "id" => id,
        "description" => "comida muito muito gostosa maravilhosa linda demais",
        "date" => UTCDateTime.from_date(Date.new!(2021, 10, 10)),
        "calories" => "3 cal"
      }

      response = Update.call(params_update)

      assert {:ok,
              %Meal{
                id: _id,
                description: "comida muito muito gostosa maravilhosa linda demais",
                date: _date,
                calories: "3 cal"
              }} =
               response
    end

    test "when the id are invalid, returns an error" do
      params = build(:meal_params)

      Create.call(params)

      params_update = %{
        "id" => "23ef65a1-294e-46c3-934e-718ea3c74497",
        "description" => "comida muito muito gostosa maravilhosa linda demais",
        "date" => UTCDateTime.from_date(Date.new!(2021, 10, 10)),
        "calories" => "3 cal"
      }

      response = Update.call(params_update)

      assert {:error,
              %Error{
                status: :not_found,
                result: "User not found!"
              }} = response
    end
  end
end
