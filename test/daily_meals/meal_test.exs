defmodule DailyMeals.MealTest do
  use DailyMeals.DataCase, async: true
  alias DailyMeals.Meal
  alias Ecto.Changeset
  import DailyMeals.Factory

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:meal_params)

      response = Meal.changeset(params)

      assert %Changeset{changes: %{description: "comida muito muito gostosa"}, valid?: true} =
               response
    end

    test "when updating a changeset, returns invalid changeset with the given changes" do
      params = build(:meal_params)

      new_date = UTCDateTime.from_date(Date.new!(2021, 11, 11))

      update_params = %{
        description: "comida muito delicia",
        date: new_date
      }

      response = params |> Meal.changeset() |> Meal.changeset(update_params)

      assert %Changeset{
               changes: %{
                 description: "comida muito delicia",
                 date: new_date
               },
               valid?: true
             } = response
    end

    test "when there are some error, returns an invalid changeset" do
      params =
        build(:meal_params, %{
          description: "comida",
          date: "2023, 10, 10",
          calories: "1 c"
        })

      response = Meal.changeset(params)

      expected_response = %{
        calories: ["has invalid format"],
        date: ["is invalid"],
        description: ["should be at least 10 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
