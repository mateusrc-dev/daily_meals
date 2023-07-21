defmodule DailyMeals.Users.CreateTest do
  use DailyMeals.DataCase, async: true
  alias DailyMeals.{Error, User}
  alias DailyMeals.Users.Create
  alias DailyMeals.Error
  import DailyMeals.Factory

  describe "call/1" do
    test "when all params are valid, returns the user" do
      user_params = build(:user_params)

      response = Create.call(user_params)

      assert {:ok,
              %User{
                id: _,
                name: "Mateus Raimundo de Carvalho",
                cpf: "12345678901",
                email: "mateus@email.com"
              }} = response
    end

    test "when there are invalid params, returns an error" do
      user_params = build(:user_params, %{email: "mateusemail.com", cpf: "1234567"})

      response = Create.call(user_params)

      expected_response = %{cpf: ["should be 11 character(s)"], email: ["has invalid format"]}

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
