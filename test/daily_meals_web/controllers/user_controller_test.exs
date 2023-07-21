defmodule DailyMealsWeb.UsersControllerTest do
  use DailyMealsWeb.ConnCase, async: true

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = %{
        "name" => "Mateus Raimundo de Carvalho",
        "cpf" => "12345678901",
        "email" => "mateus@email.com"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "user" => %{
                 "id" => _id,
                 "name" => "Mateus Raimundo de Carvalho",
                 "cpf" => "12345678901",
                 "email" => "mateus@email.com"
               },
               "message" => "User created!"
             } = response
    end

    test "when there is some error, returns an error", %{conn: conn} do
      params = %{
        "name" => "Mateus Raimundo de Carvalho",
        "cpf" => "1234567890",
        "email" => "mateusemail.com"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "cpf" => ["should be 11 character(s)"],
          "email" => ["has invalid format"]
        }
      }

      assert expected_response == response
    end
  end

  describe "show/2" do
    test "when there is a user with the given id, is possible show this user in screen", %{
      conn: conn
    } do
      params = %{
        "name" => "Mateus Raimundo de Carvalho",
        "cpf" => "12345678901",
        "email" => "mateus@email.com"
      }

      user =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      %{
        "user" => %{
          "id" => id
        }
      } = user

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "id" => id,
                 "name" => "Mateus Raimundo de Carvalho",
                 "cpf" => "12345678901",
                 "email" => "mateus@email.com"
               }
             } = response
    end

    test "when there is a user with the given invalid id, returns an error", %{
      conn: conn
    } do
      params = %{
        "name" => "Mateus Raimundo de Carvalho",
        "cpf" => "12345678901",
        "email" => "mateus@email.com"
      }

      conn
      |> post(Routes.users_path(conn, :create, params))
      |> json_response(:created)

      response =
        conn
        |> get(Routes.users_path(conn, :show, "23ef65a1-294e-46c3-934e-718ea3c74499"))
        |> json_response(:not_found)

      assert %{"message" => "User not found!"} = response
    end
  end

  describe "update/2" do
    test "when all params are valid, is possible updated the user", %{conn: conn} do
      params = %{
        "name" => "Mateus Raimundo de Carvalho",
        "cpf" => "12345678901",
        "email" => "mateus@email.com"
      }

      user =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      %{
        "user" => %{
          "id" => id
        }
      } = user

      params_update = %{
        "name" => "Mateus Carvalho",
        "cpf" => "12345678902",
        "email" => "mateus_raimundo@email.com"
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, params_update))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "id" => id,
                 "name" => "Mateus Carvalho",
                 "cpf" => "12345678902",
                 "email" => "mateus_raimundo@email.com"
               }
             } = response
    end

    test "when there is a user with the given invalid id, returns an error", %{conn: conn} do
      params = %{
        "name" => "Mateus Carvalho",
        "cpf" => "12345678902",
        "email" => "mateus_raimundo@email.com"
      }

      conn
      |> post(Routes.users_path(conn, :create, params))
      |> json_response(:created)

      params_update = %{
        "name" => "Mateus Raimundo de Carvalho",
        "cpf" => "12345678901",
        "email" => "mateus@email.com"
      }

      response =
        conn
        |> put(
          Routes.users_path(conn, :update, "23ef65a1-294e-46c3-934e-718ea3c74499", params_update)
        )
        |> json_response(:not_found)

      assert %{"message" => "User not found!"} = response
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, is possible deleted the user", %{conn: conn} do
      params = %{
        "name" => "Mateus Raimundo de Carvalho",
        "cpf" => "12345678901",
        "email" => "mateus@email.com"
      }

      user =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      %{
        "user" => %{
          "id" => id
        }
      } = user

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end

    test "when there is a user with the given invalid id, returns an error", %{conn: conn} do
      params = %{
        "name" => "Mateus Raimundo de Carvalho",
        "cpf" => "12345678901",
        "email" => "mateus@email.com"
      }

      conn
      |> post(Routes.users_path(conn, :create, params))
      |> json_response(:created)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, "23ef65a1-294e-46c3-934e-718ea3c74499"))
        |> json_response(:not_found)

      assert %{"message" => "User not found!"} = response
    end
  end
end
