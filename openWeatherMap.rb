#!/usr/bin/env ruby

# OpenWeatherMap service provides open weather data for more than 200,000
# cities and any geo location that is available on our website and through API.

require 'net/http'
require 'json'

$base_url = 'http://api.openweathermap.org/data/2.5/weather'
$api_key = ''  # << Get your API key (APPID) here: http://openweathermap.org/appid
cities = ['Esztergom', 'London, UK']

def get_temperature(city)
  begin
    uri = URI("#{$base_url}?q=#{city}&units=metric&APPID=#{$api_key}")
    response = Net::HTTP.get_response(uri)
  rescue
    puts "Connection error. Exiting..."
    exit 1
  end
  # puts "[" + response.code + "] " + response.uri.to_s
  if response.is_a?(Net::HTTPSuccess)
    weather_data = JSON.parse response.body
    # puts JSON.pretty_generate(weather_data)
    puts weather_data["name"] + " " + format("%.1f", weather_data["main"]["temp"]).to_s + " C"
  else
    puts "N/A [" + response.code + "]"
  end
end

cities.each do |city|
  get_temperature(city)
end
