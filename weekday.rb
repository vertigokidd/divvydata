require 'csv'

class Divvy

  attr_accessor :stations

  def initialize
    @stations = {}
  end

  def add_station(station_id, station_name, rental_date)
    s = Station.new(station_name)
    @stations[station_id] = s
  end

  def station_exists?(station_id)
    @stations[station_id] != nil
  end

  def increment(station_id, station_name, rental_date)
    unless station_exists?(station_id)
      add_station(station_id, station_name, rental_date)
    end
    @stations[station_id].add_rental(rental_date)
  end

end


class Station

  attr_accessor :station_name, :rentals

  def initialize(station_name)
  	@station_name = station_name
  	@rentals = Hash.new(0)
  end

  def add_rental(rental_date)
    @rentals[rental_date] += 1
  end

end


# d = Divvy.new
# d.increment(1, "543 Michigan Ave", "25th of July")
# d.increment(1, "543 Michigan Ave", "25th of July")
# d.increment(1, "543 Michigan Ave", "26th of July")
# d.increment(1, "543 Michigan Ave", "26th of July")
# d.increment(1, "543 Michigan Ave", "26th of July")
# d.increment(2, "543 Michigan Ave", "25th of July")
# p d.stations


d = Divvy.new


CSV.foreach("DivvyDenormedSample.csv", :headers => true) do |row|
  d.increment(row["to_station_id"], row["to_station_name"], row["start_time"])
end

p d.stations