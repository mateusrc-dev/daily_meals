defmodule DailyMeals.Users.Get do
  alias DailyMeals.{Error, User, Repo}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> {:ok, user}
    end
  end
end
