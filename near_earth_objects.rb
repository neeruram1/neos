require 'faraday'
require 'figaro'
require 'pry'
require_relative 'asteroid'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  def self.connection(date)
    conn = Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: date, api_key: ENV['nasa_api_key']}
    )
    conn.get('/neo/rest/v1/feed')
  end

  def self.find_neos_by_date(date)
    @data = JSON.parse(connection(date).body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
    create_asteroids
  end

  def self.create_asteroids
    @asteroids = @data.map {|asteroid_attributes| Asteroid.new(asteroid_attributes)}
  end

  def self.largest_asteroid_diameter
    @asteroids.max_by {|asteroid| asteroid.diameter}.diameter
  end

  def self.total_number_of_asteroids
    @asteroids.count
  end

  def self.formatted_asteroid_data
    @asteroids.map {|asteroid| asteroid.formatted_asteroid_data}
  end
end
