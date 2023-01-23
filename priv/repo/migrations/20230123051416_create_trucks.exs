defmodule FoodTruck.Repo.Migrations.CreateTrucks do
  use Ecto.Migration

  def change do
    create table(:trucks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :applicant, :text
      add :facility_type, :string
      add :location_description, :text
      add :address, :text
      add :status, :string
      add :food_items, :text
      add :schedule, :text

      timestamps()
    end
  end
end
