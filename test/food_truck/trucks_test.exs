defmodule FoodTruck.TrucksTest do
  use FoodTruck.DataCase, async: true

  alias FoodTruck.Trucks

  setup do
    {:ok, truck} = Trucks.create_truck(%{applicant: "Test Truck", food_items: "Pizza, Tacos and Ice Cream", facility_type: "Truck", location_description: "Corner of 16th and Mission", address: "16th and Mission", status: "APPROVED", schedule: "Monday - Friday 11am - 2pm"})
    {:ok, truck: truck}
  end

  describe "create_truck/1" do
    test "creates a truck", %{truck: truck} do
      assert %Trucks{} = truck
    end
  end

  describe "searches" do
    test "searches by food type", %{truck: truck} do
      assert Trucks.search(%{"food_type" => "Pizza"}) == [truck]
      assert truck.food_items =~ "Pizza"
    end

    test "seaches by truck name", %{truck: truck} do
      assert Trucks.search(%{"applicant" => "Test"}) == [truck]
      assert truck.applicant =~ "Test"
    end
  end
end
