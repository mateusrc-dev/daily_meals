defmodule DailyMeals.Meals.GetTest do
  use DailyMeals.DataCase, async: true
  alias DailyMeals.{Error, Meal, User}
  alias DailyMeals.Meals.Create, as: MealCreate
  alias DailyMeals.Users.Create, as: UserCreate
  alias DailyMeals.Meals.Get
  alias DailyMeals.Error
  import DailyMeals.Factory

  describe "by_id/1" do
    test "when all params are valid, returns the meal" do
      user_params = build(:user_params)

      {:ok, %User{id: id}} = UserCreate.call(user_params)

      params = build(:meal_params, %{user_id: id})

      meal = MealCreate.call(params)

      {:ok,
       %DailyMeals.Meal{
         id: id,
         date: date
       }} = meal

      response = Get.by_id(id)

      assert {:ok,
              %Meal{
                id: id,
                description: "comida muito muito gostosa",
                date: date,
                calories: "1 cal",
                user_id: _
              }} =
               response
    end

    test "when the id are invalid, returns an error" do
      user_params = build(:user_params)

      {:ok, %User{id: id}} = UserCreate.call(user_params)

      params = build(:meal_params, %{user_id: id})

      MealCreate.call(params)

      response = Get.by_id("23ef65a1-294e-46c3-934e-718ea3c74497")

      assert {:error,
              %Error{
                status: :not_found,
                result: "User not found!"
              }} = response
    end
  end
end
