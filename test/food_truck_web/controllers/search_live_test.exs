defmodule FoodTruckWeb.SearchLiveTest do
  use FoodTruckWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "FoodTruck"
  end
end
