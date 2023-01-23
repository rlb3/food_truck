# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FoodTruck.Repo.insert!(%FoodTruck.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

require Logger

headers =
  ~w[locationid Applicant FacilityType cnn LocationDescription Address blocklot block lot permit Status FoodItems X Y Latitude Longitude Schedule dayshours NOISent Approved Received PriorPermit ExpirationDate Location "Fire Prevention" Districts "Police Districts" "Supervisor Districts" "Zip Codes" "Neighborhoods (old)"
]
  |> Enum.map(fn header -> String.replace(header, "\"", "") end)

NimbleCSV.define(FoodTruckParser, separator: ",", escape: "\"")

trucks =
  Path.join([__DIR__, "Mobile_Food_Facility_Permit.csv"])
  |> File.stream!(read_ahead: 500)
  |> FoodTruckParser.parse_stream(skip_headers: true)
  |> Enum.into([])
  |> Enum.map(fn line -> Enum.zip(headers, line) end)
  |> Enum.map(fn line -> Enum.into(line, %{}) end)


@doc """
  Seeds the database with data from the CSV file.
  There is more data in the CSV file, for a proof
  of concept we are only using a subset of the data.
  """
for truck <- trucks do
  FoodTruck.Repo.insert!(%FoodTruck.Trucks{
    applicant: truck["Applicant"],
    facility_type: truck["FacilityType"],
    location_description: truck["LocationDescription"],
    address: truck["Address"],
    status: truck["Status"],
    food_items: truck["FoodItems"],
    schedule: truck["Schedule"]
  })
end

Logger.info("Database seeded!")
