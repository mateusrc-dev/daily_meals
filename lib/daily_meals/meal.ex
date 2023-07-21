defmodule DailyMeals.Meal do
  use Ecto.Schema
  alias DailyMeals.User
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:description, :date, :calories, :user_id]

  @derive {Jason.Encoder, only: [:id, :description, :date, :calories, :user_id]}

  schema "meals" do
    field :description, :string
    field :date, :utc_datetime
    field :calories, :string

    belongs_to :user, User

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:description, min: 10)
    |> validate_format(:calories, ~r/cal/)
  end
end
