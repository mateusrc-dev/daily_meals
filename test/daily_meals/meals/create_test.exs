defmodule DailyMeals.Meals.CreateTest do
  use DailyMeals.DataCase, async: true
  alias DailyMeals.{Error, Meal}
  alias DailyMeals.Meals.Create
  alias DailyMeals.Error
  import DailyMeals.Factory

  describe "call/1" do
    test "when all params are valid, returns the meal" do
      params = build(:meal_params)

      %{date: date} = params

      response = Create.call(params)

      assert {:ok,
              %Meal{
                id: _id,
                description: "comida muito muito gostosa",
                date: date,
                calories: "1 cal"
              }} =
               response
    end

    test "when there are invalid params, returns an error" do
      params =
        build(:meal_params, %{date: "20/20/2022", description: "comida", calories: "1 l"})

      response = Create.call(params)

      expected_response = %{
        calories: ["has invalid format"],
        date: ["is invalid"],
        description: ["should be at least 10 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
