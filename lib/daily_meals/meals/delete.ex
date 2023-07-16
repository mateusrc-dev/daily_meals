defmodule DailyMeals.Meals.Delete do
  alias DailyMeals.{Error, Meal, Repo}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, Error.build_id_format_error()}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      meal -> Repo.delete(meal)
    end
  end
end
