defmodule DailyMeals.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:description, :date, :calories]

  schema "meals" do
    field :description, :string
    field :date, :utc_datetime
    field :calories, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:description, min: 10)
    |> validate_format(:calories, ~r/cal/)
  end
end
