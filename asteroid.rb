class Asteroid
  attr_reader :id,
              :name,
              :diameter,
              :miss_distance
  def initialize(asteroid_attributes)
    @id = asteroid_attributes[:id]
    @diameter = asteroid_attributes[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    @name = asteroid_attributes[:name]
    @miss_distance = asteroid_attributes[:close_approach_data][0][:miss_distance][:miles].to_i
  end

  def formatted_asteroid_data
    {
      name: self.name,
      diameter: "#{self.diameter.to_i} ft",
      miss_distance: "#{self.miss_distance.to_i} miles"
    }
  end
end
