require 'json'
require 'date'

json = File.read('data/input.json')
extract = JSON.parse(json)
@cars = extract['cars']
@rentals = extract['rentals']

def time_converter
  period = []
  @rentals.each do |rental|
    s_date = Date.parse rental['start_date']
    e_date = Date.parse rental['end_date']
    period << (e_date - s_date).to_i
  end
  @total_period = []
  @cars.zip(period).each do |car, days|
    @total_period << (car['price_per_day'] * days)
  end
  @total_period
end

def distance_converter
  distance = []
  @rentals.each do |rental|
    distance << rental['distance']
  end
  @total_distance = []
  @cars.zip(distance).each do |car, km|
    @total_distance << (car['price_per_km'] * km)
  end
  @total_distance
end

def total_rent
  @orders = []
  @total_distance.zip(@total_period).each do |km, days|
    @orders << (km + days)
  end
  @orders
end
