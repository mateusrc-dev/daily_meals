defmodule DailyMeals.Repo.Migrations.CreateMealsTable do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :description, :string
      add :date, :utc_datetime
      add :calories, :string
      add :user_id, references(:users, type: :binary_id), on_delete: :delete_all

      timestamps()
    end
  end
end
