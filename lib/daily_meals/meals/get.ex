defmodule DailyMeals.Meals.Get do
  alias DailyMeals.{Error, Meal, Repo}
  alias Ecto.UUID

  def by_id_2(id) do
    with {:ok, uuid} <- UUID.cast(id),
         %Meal{} = meal <- Repo.get(Meal, uuid) do
      {:ok, meal}
    else
      :error -> {:error, Error.build_id_format_error()}
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end

  def by_id(id) do
    case UUID.cast(id) do
      :error -> {:error, Error.build_id_format_error()}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      meal -> {:ok, meal}
    end
  end
end
