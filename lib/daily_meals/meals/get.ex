defmodule DailyMeals.Meals.Get do
  alias DailyMeals.{Meal, Repo}
  alias Ecto.UUID

  def by_id_2(id) do
    with {:ok, uuid} <- UUID.cast(id),
         %Meal{} = meal <- Repo.get(Meal, uuid) do
      {:ok, meal}
    else
      :error -> {:error, %{status: :bad_request, result: "Invalid id format!"}}
      nil -> {:error, %{status: :not_found, result: "Meal not found!"}}
    end
  end

  def by_id(id) do
    case UUID.cast(id) do
      :error -> {:error, %{status: :bad_request, result: "Invalid id format!"}}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, %{status: :not_found, result: "Meal not found!"}}
      meal -> {:ok, meal}
    end
  end
end
