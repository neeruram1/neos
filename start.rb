require_relative 'near_earth_objects'

def welcome_message
  puts "________________________________________________________________________________________________________________________________"
  puts "Welcome to NEO. Here you will find information about how many meteors, asteroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
  puts "Please enter a date in the following format YYYY-MM-DD."
  print ">>"
  user_input = gets.chomp
  @date = user_input
end

def find_neos
  NearEarthObjects.find_neos_by_date(@date)
end

def column_data
  labels = { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
  labels.each_with_object({}) do |(col, label), hash|
    hash[col] = {
      label: label,
      width: [NearEarthObjects.formatted_asteroid_data.map { |asteroid| asteroid[col].size }.max, label.size].max}
  end
end

def header
  puts "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
end

def divider
  puts "+-#{column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"
end

def format_row_data(row_data, column_info)
  row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
  puts "| #{row} |"
end

def create_rows(asteroid_data, column_info)
  asteroid_data.each { |asteroid| format_row_data(asteroid, column_info) }
end

def create_table
  formatted_date = DateTime.parse(@date).strftime("%A %b %d, %Y")
  puts "______________________________________________________________________________"
  puts "On #{formatted_date}, there were #{NearEarthObjects.total_number_of_asteroids} objects that almost collided with the earth."
  puts "The largest of these was #{NearEarthObjects.largest_asteroid_diameter} ft. in diameter."
  puts "\nHere is a list of objects with details:"
end

def run_program
  welcome_message
  find_neos
  create_table
  divider
  header
  create_rows(NearEarthObjects.formatted_asteroid_data, column_data)
  divider
end
