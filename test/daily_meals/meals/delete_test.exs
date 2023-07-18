defmodule DailyMeals.Meals.DeleteTest do
  use DailyMeals.DataCase, async: true
  alias DailyMeals.{Error, Meal}
  alias DailyMeals.Meals.Create
  alias DailyMeals.Meals.Delete
  alias DailyMeals.Error
  import DailyMeals.Factory

  describe "call/1" do
    test "when the id is valid, is possible delete an meal" do
      params = build(:meal_params)

      meal = Create.call(params)

      {:ok,
       %Meal{
         id: id
       }} = meal

      response = Delete.call(id)

      assert {:ok,
              %Meal{
                id: _id,
                description: "comida muito muito gostosa",
                date: _,
                calories: "1 cal",
                inserted_at: _,
                updated_at: _
              }} =
               response
    end

    test "when the id are invalid, returns an error" do
      params = build(:meal_params)

      Create.call(params)

      response = Delete.call("23ef65a1-294e-46c3-934e-718ea3c74497")

      assert {:error,
              %Error{
                status: :not_found,
                result: "User not found!"
              }} = response
    end
  end
end
