require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'
require_relative 'asteroid'

class AsteroidTest < Minitest::Test
  def test_it_exists
    result = NearEarthObjects.find_neos_by_date('2019-03-30')[0]
    asteroid = Asteroid.new(result)
    assert_instance_of Asteroid, asteroid
  end

  def test_it_has_attributes
    result = NearEarthObjects.find_neos_by_date('2019-03-30')[0]
    asteroid = Asteroid.new(result)
    assert_equal "3840858", asteroid.id
    assert_equal 61, asteroid.diameter
    assert_equal 911947, asteroid.miss_distance
  end

  def test_it_can_format_data
    result = NearEarthObjects.find_neos_by_date('2019-03-30')[0]
    asteroid = Asteroid.new(result)
    assert_equal ({name: asteroid.name, diameter: "#{asteroid.diameter} ft", miss_distance: "#{asteroid.miss_distance} miles"}), asteroid.formatted_asteroid_data
  end
end
