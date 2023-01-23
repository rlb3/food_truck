# FoodTruck

This is an app to access an online food truck service and search it for truck names and the
type of food they serve.

This app has one simple schema called `FoodTruck.Trucks`. This all only has one live_view page located in `food_truck_web/live/search_live.ex`.

While the functionality of the site is limited, as the site and functionality grows
it will be helpful to move the template to it's own file and also move the `FoodTruck.Trucks.create_truck` and `FoodTruck.Trucks.seach` to their own context.

Also while the data is currently setup in our own database it might be helpful to pull new versions of the file and update periodically for new trucks and update the status of current
trucks. 