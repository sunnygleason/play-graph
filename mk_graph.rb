
require 'rubygems'
require 'json'

# size of graph is either the specified argument or 1000
N = (ARGV.shift || "1000").to_i


N.times do |i|
  v_friends = []

  # pick 3-5 random friends, do not allow self-friending
  (3 + rand(5)).times do
    new_friend = rand(1000)
    v_friends << new_friend unless new_friend == i
  end

  # create values that look something like lat/lon
  v_lat = (30 + rand(10)) + (rand(100).to_f / 100)
  v_lon = (70 + rand(10)) + (rand(100).to_f / 100)

  v = {
    "id" => i,
    "name" => "person #{i}",
    "birth_year" => rand(20) + 1960,
    "birth_month" => rand(12) + 1,
    "lat" => v_lat,
    "lon" => v_lon,
    "friends" => v_friends
  }

  puts JSON(v)
end
