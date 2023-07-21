defmodule DailyMeals.Users.UpdateTest do
  use DailyMeals.DataCase, async: true
  alias DailyMeals.{Error, User}
  alias DailyMeals.Users.Create
  alias DailyMeals.Users.Update
  alias DailyMeals.Error
  import DailyMeals.Factory

  describe "call/1" do
    test "when all params are valid, returns the user" do
      user_params = build(:user_params)

      {:ok, %User{id: id}} = Create.call(user_params)

      params_update = %{
        "id" => id,
        "name" => "Mateus Carvalho",
        "cpf" => "12345678902",
        "email" => "mateus_raimundo95@email.com"
      }

      response = Update.call(params_update)

      assert {:ok,
              %User{
                id: id,
                name: "Mateus Carvalho",
                cpf: "12345678902",
                email: "mateus_raimundo95@email.com"
              }} =
               response
    end

    test "when the id are invalid, returns an error" do
      user_params = build(:user_params)

      {:ok, %User{id: id}} = UserCreate.call(user_params)

      params = build(:meal_params, %{user_id: id})

      MealCreate.call(params)

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
