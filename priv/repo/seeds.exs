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

headers =
  ~w[locationid Applicant FacilityType cnn LocationDescription Address blocklot block lot permit Status FoodItems X Y Latitude Longitude Schedule dayshours NOISent Approved Received PriorPermit ExpirationDate Location "Fire Prevention" Districts "Police Districts" "Supervisor Districts" "Zip Codes" "Neighborhoods (old)"
]
  |> Enum.map(fn header -> String.replace(header, "\"", "") end)

NimbleCSV.define(FoodTruckParser, separator: ",", escape: "\"")

data =
  Path.join([__DIR__, "Mobile_Food_Facility_Permit.csv"])
  |> File.stream!(read_ahead: 500)
  |> FoodTruckParser.parse_stream(skip_headers: true)
  |> Enum.into([])
  |> Enum.map(fn line -> Enum.zip(headers, line) end)
  |> Enum.map(fn line -> Enum.into(line, %{}) end)
