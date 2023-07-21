defmodule DailyMeals.Users.DeleteTest do
  use DailyMeals.DataCase, async: true
  alias DailyMeals.{Error, User}
  alias DailyMeals.Users.Create
  alias DailyMeals.Users.Delete
  alias DailyMeals.Error
  import DailyMeals.Factory

  describe "call/1" do
    test "when the id is valid, is possible delete an user" do
      user_params = build(:user_params)

      {:ok, %User{id: id}} = Create.call(user_params)

      response = Delete.call(id)

      assert {:ok,
              %User{
                id: id,
                cpf: "12345678901",
                email: "mateus@email.com",
                name: "Mateus Raimundo de Carvalho",
                meal: _,
                inserted_at: _,
                updated_at: _
              }} = response
    end

    test "when the id are invalid, returns an error" do
      user_params = build(:user_params)

      Create.call(user_params)

      response = Delete.call("23ef65a1-294e-46c3-934e-718ea3c74497")

      assert {:error,
              %Error{
                status: :not_found,
                result: "User not found!"
              }} = response
    end
  end
end
