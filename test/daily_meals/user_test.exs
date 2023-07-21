defmodule DailyMeals.UserTest do
  use DailyMeals.DataCase, async: true
  alias DailyMeals.User
  alias Ecto.Changeset
  import DailyMeals.Factory

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Mateus Raimundo de Carvalho"}, valid?: true} =
               response
    end

    test "when updating a changeset, returns an valid changeset with the given changes" do
      params = build(:user_params)

      update_params = %{
        name: "Mateus Carvalho"
      }

      response = params |> User.changeset() |> User.changeset(update_params)

      assert %Changeset{
               changes: %{
                 name: "Mateus Carvalho"
               },
               valid?: true
             } = response
    end

    test "when there are some error, returns an invalid changeset" do
      params =
        build(:user_params, %{
          email: "mateusemail.com"
        })

      response = User.changeset(params)

      expected_response = %{email: ["has invalid format"]}

      assert errors_on(response) == expected_response
    end
  end
end
