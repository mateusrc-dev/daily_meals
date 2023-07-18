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

  describe "show/2" do
    test "when there is a meal with the given id, is possible show this meal in screen", %{
      conn: conn
    } do
      params = %{
        "description" => "comida muito muito gostosa",
        "date" => "10/10/2023",
        "calories" => "1 cal"
      }

      meal =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      %{
        "meal" => %{
          "id" => id
        }
      } = meal

      response =
        conn
        |> get(Routes.meals_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "meal" => %{
                 "description" => "comida muito muito gostosa",
                 "date" => _date,
                 "calories" => "1 cal",
                 "id" => _id
               }
             } = response
    end

    test "when there is a meal with the given invalid id, returns an error", %{
      conn: conn
    } do
      params = %{
        "description" => "comida muito muito gostosa",
        "date" => "10/10/2023",
        "calories" => "1 cal"
      }

      conn
      |> post(Routes.meals_path(conn, :create, params))
      |> json_response(:created)

      response =
        conn
        |> get(Routes.meals_path(conn, :show, "23ef65a1-294e-46c3-934e-718ea3c74499"))
        |> json_response(:not_found)

      assert %{"message" => "User not found!"} = response
    end
  end

  describe "update/2" do
    test "when all params are valid, is possible updated the meal", %{conn: conn} do
      params = %{
        "description" => "comida muito muito gostosa",
        "date" => "10/10/2023",
        "calories" => "1 cal"
      }

      meal =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      %{
        "meal" => %{
          "id" => id
        }
      } = meal

      params_update = %{
        "description" => "comida maravilhosa linda demais maravilhosa",
        "date" => "10/10/2021",
        "calories" => "2 cal"
      }

      response =
        conn
        |> put(Routes.meals_path(conn, :update, id, params_update))
        |> json_response(:ok)

      assert %{
               "meal" => %{
                 "calories" => "2 cal",
                 "date" => "2021-10-10T00:00:00Z",
                 "description" => "comida maravilhosa linda demais maravilhosa",
                 "id" => _id
               }
             } = response
    end

    test "when is not send the date, is possible updated the meal without change the date", %{
      conn: conn
    } do
      params = %{
        "description" => "comida muito muito gostosa",
        "date" => "10/10/2023",
        "calories" => "1 cal"
      }

      meal =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      %{
        "meal" => %{
          "id" => id
        }
      } = meal

      params_update = %{
        "description" => "comida muito muito gostosa maravilhosa linda deliciosa",
        "calories" => "3 cal"
      }

      response =
        conn
        |> put(Routes.meals_path(conn, :update, id, params_update))
        |> json_response(:ok)

      assert %{
               "meal" => %{
                 "calories" => "3 cal",
                 "date" => "2023-10-10T00:00:00Z",
                 "description" => "comida muito muito gostosa maravilhosa linda deliciosa",
                 "id" => _id
               }
             } = response
    end

    test "when there is a meal with the given invalid id, returns an error", %{conn: conn} do
      params = %{
        "description" => "comida muito muito gostosa",
        "date" => "10/10/2023",
        "calories" => "1 cal"
      }

      conn
      |> post(Routes.meals_path(conn, :create, params))
      |> json_response(:created)

      params_update = %{
        "description" => "comida maravilhosa linda demais maravilhosa",
        "date" => "10/10/2021",
        "calories" => "2 cal"
      }

      response =
        conn
        |> put(
          Routes.meals_path(conn, :update, "23ef65a1-294e-46c3-934e-718ea3c74499", params_update)
        )
        |> json_response(:not_found)

      assert %{"message" => "User not found!"} = response
    end
  end

  describe "delete/2" do
    test "when there is a meal with the given id, is possible deleted the meal", %{conn: conn} do
      params = %{
        "description" => "comida muito muito gostosa",
        "date" => "10/10/2023",
        "calories" => "1 cal"
      }

      meal =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      %{
        "meal" => %{
          "id" => id
        }
      } = meal

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end

    test "when there is a meal with the given invalid id, returns an error", %{conn: conn} do
      params = %{
        "description" => "comida muito muito gostosa",
        "date" => "10/10/2023",
        "calories" => "1 cal"
      }

      conn
      |> post(Routes.meals_path(conn, :create, params))
      |> json_response(:created)

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, "23ef65a1-294e-46c3-934e-718ea3c74499"))
        |> json_response(:not_found)

      assert %{"message" => "User not found!"} = response
    end
  end
end
