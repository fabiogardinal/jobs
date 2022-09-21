require 'json'
require 'date'

def calc_time(rentals, cars)
  period = rentals.map do |rental|
    s_date = Date.parse(rental['start_date'])
    e_date = Date.parse(rental['end_date'])
    (e_date - s_date).to_i
  end
  cars.zip(period).map { |car, days| car['price_per_day'] * days }
end

def calc_distance(rentals, cars)
  distance = rentals.map { |rental| rental['distance'] }
  cars.zip(distance).map { |car, km| car['price_per_km'] * km }
end

def json_converter(orders)
  data = { rentals: [] }
  orders.each_with_index { |order, i| data[:rentals] << { id: i + 1, price: order } }
  data.to_json
end

def total_rent(rentals, cars)
  total_distance = calc_distance(rentals, cars)
  total_period = calc_time(rentals, cars)
  orders = total_distance.zip(total_period).map { |km, days| km + days }
  json_converter(orders)
end

json = File.read('data/input.json')
data = JSON.parse(json)

total_rent(data['rentals'], data['cars'])
