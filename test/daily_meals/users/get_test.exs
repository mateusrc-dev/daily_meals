defmodule DailyMeals.Users.GetTest do
  use DailyMeals.DataCase, async: true
  alias DailyMeals.{Error, User}
  alias DailyMeals.Users.Create
  alias DailyMeals.Users.Get
  alias DailyMeals.Error
  import DailyMeals.Factory

  describe "by_id/1" do
    test "when all params are valid, returns the user" do
      user_params = build(:user_params)

      {:ok, %User{id: id}} = Create.call(user_params)

      response = Get.by_id(id)

      assert {:ok,
              %User{
                id: id,
                name: "Mateus Raimundo de Carvalho",
                cpf: "12345678901",
                email: "mateus@email.com"
              }} =
               response
    end

    test "when the id are invalid, returns an error" do
      user_params = build(:user_params)

      Create.call(user_params)

      response = Get.by_id("23ef65a1-294e-46c3-934e-718ea3c74497")

      assert {:error,
              %Error{
                status: :not_found,
                result: "User not found!"
              }} = response
    end
  end
end
