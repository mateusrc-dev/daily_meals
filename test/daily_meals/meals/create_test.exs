defmodule DailyMeals.Meals.CreateTest do
  use DailyMeals.DataCase, async: true
  alias DailyMeals.{Error, Meal, User}
  alias DailyMeals.Meals.Create, as: MealCreate
  alias DailyMeals.Users.Create, as: UserCreate
  alias DailyMeals.Error
  import DailyMeals.Factory

  describe "call/1" do
    test "when all params are valid, returns the meal" do
      user_params = build(:user_params)

      {:ok, %User{id: id}} = UserCreate.call(user_params)

      params = build(:meal_params, %{user_id: id})

      %{date: date} = params

      response = MealCreate.call(params)

      assert {:ok,
              %Meal{
                id: _,
                description: "comida muito muito gostosa",
                date: _,
                calories: "1 cal",
                user_id: _,
                user: _,
                inserted_at: _,
                updated_at: _
              }} = response
    end

    test "when there are invalid params, returns an error" do
      user_params = build(:user_params)

      {:ok, %User{id: id}} = UserCreate.call(user_params)

      params =
        build(:meal_params, %{
          date: "20/20/2022",
          description: "comida",
          calories: "1 l",
          user_id: id
        })

      response = MealCreate.call(params)

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
