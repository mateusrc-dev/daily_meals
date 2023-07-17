defmodule DailyMealsWeb.MealsControllerTest do
  use DailyMealsWeb.ConnCase, async: true
  alias DailyMeals.Meal
  import DailyMeals.Factory

  describe "create/2" do
    test "when all params are valid, creates the meal", %{conn: conn} do
      params = %{
        "description" => "comida muito muito gostosa",
        "date" => "10/10/2023",
        "calories" => "1 cal"
      }

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "meal" => %{
                 "calories" => "1 cal",
                 "date" => "2023-10-10T00:00:00Z",
                 "description" => "comida muito muito gostosa",
                 "id" => _id
               },
               "message" => "Meal created!"
             } = response
    end

    test "when there is some error, returns an error", %{conn: conn} do
      params = %{
        "description" => "comida",
        "date" => "10/10/2023",
        "calories" => "1 c"
      }

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "calories" => ["has invalid format"],
          "description" => ["should be at least 10 character(s)"]
        }
      }

      assert expected_response == response
    end

    test "when there an date invalid, returns an error of date invalid", %{conn: conn} do
      params = %{
        "description" => "comida linda maravilhosa",
        "date" => "10/13/2023",
        "calories" => "1 cal"
      }

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid date insert"}

      assert expected_response == response
    end
  end

  describe "delete/2" do
    test "when there is a meal with the given id, is possible deleted the meal", %{conn: conn} do
      params = %{
        "description" => "comida muito muito gostosa",
        "date" => "10/10/2023",
        "calories" => "1 cal"
      }

      user =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      %{
        "meal" => %{
          "id" => id
        }
      } = user

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end
end
