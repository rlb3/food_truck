defmodule FoodTruck.Trucks do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "trucks" do
    field :address, :string
    field :applicant, :string
    field :facility_type, :string
    field :food_items, :string
    field :location_description, :string
    field :schedule, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(trucks, attrs) do
    trucks
    |> cast(attrs, [:applicant, :facility_type, :location_description, :address, :status, :food_items, :schedule])
    |> validate_required([:applicant, :facility_type, :location_description, :address, :status, :food_items, :schedule])
  end
end
