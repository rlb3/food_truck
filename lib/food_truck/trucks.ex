defmodule FoodTruck.Trucks do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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

  @doc """
  Basic search for food trucks. Something more complex with
  pagination could be created if needed. The search is a
  simple case-insensitive match on the food type and truck name.
  """
  def search(params) do
    search = Enum.reduce(params, dynamic(true), fn
      {_, ""}, dynamic ->
        dynamic

      {"food_type", food_type}, dynamic ->
        food_type_match = "%#{food_type}%"
        dynamic([t], ilike(t.food_items, ^food_type_match))

      {"truck_name", truck_name}, dynamic ->
        truck_name_match = "%#{truck_name}%"
        dynamic([t], ilike(t.applicant, ^truck_name_match))

      {_, _}, dynamic ->
        dynamic
    end)

    query = from t in __MODULE__,
      where: t.status == "APPROVED",
      where: t.facility_type == "Truck",
      where: ^search
    FoodTruck.Repo.all(query)
  end
end
