defmodule DailyMealsWeb.UsersController do
  use DailyMealsWeb, :controller
  alias DailyMeals.User
  alias DailyMealsWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- DailyMeals.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- DailyMeals.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- DailyMeals.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- DailyMeals.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
