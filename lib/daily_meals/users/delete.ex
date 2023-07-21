defmodule DailyMeals.Users.Delete do
  alias DailyMeals.{Error, User, Repo}

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> Repo.delete(user)
    end
  end
end
