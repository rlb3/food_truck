defmodule FoodTruckWeb.SearchLive do
  use FoodTruckWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :trucks, [])}
  end

  @doc """
  This is the template for the live view. If the page gets more complex, we should
  consider moving this to a separate template. Also, we should consider using pagination.
  """
  def render(assigns) do
    ~H"""
    <p>Food Truck Search</p>
    <.form :let={f} for={:search_form} phx-submit="search">
      <.input field={{f, :truck_name}} placeholder="Food Truck Name" />
      <.input field={{f, :food_type}} placeholder="Food Types" />
      <.button>Search</.button>
    </.form>

    <hr />

    <%= for truck <- @trucks do %>
      <div class="py-6">
        <h3><%= truck.applicant %></h3>
        <p><%= truck.food_items %></p>
        <p><%= truck.location_description %></p>
        <u>
          <.link href={truck.schedule}>Schedule</.link>
        </u>
      </div>
    <% end %>
    """
  end

  def handle_event("search", %{"search_form" => params}, socket) do
    trucks = FoodTruck.Trucks.search(params)
    {:noreply, assign(socket, :trucks, trucks)}
  end
end
