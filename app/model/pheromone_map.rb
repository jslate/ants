require './app/model/pheromone_spot'

class PheromoneMap

  attr_accessor :resolution

  def initialize(width, height, resolution)
    @width = width
    @height = height
    @resolution = resolution


    rows = @height / @resolution + 1
    columns = @width / @resolution + 1

    # puts rows
    # puts columns

    @spot_arr = []
    rows.times do |row|
      @spot_arr[row] ||= []
      columns.times do |column|
        @spot_arr[row][column] = PheromoneSpot.new(row, column)
      end
    end

    @grid_arr = []

    @width.times do |x|
      @grid_arr[x] ||= []
      @height.times do |y|
        @grid_arr[x][y] = get_spot(x, y)
      end
    end
  end

  def get_spot(x, y)
    row = (y.floor / @resolution)
    column = (x.floor / @resolution)
    #puts "get_spot #{x}, #{y}  / #{column}, #{row}"
    @spot_arr[row][column]
  end

  def get_spot_relative_to(x, y, x_diff, y_diff)
    row = (y.floor / @resolution)
    column = (x.floor / @resolution)
    #puts "get_spot #{x}, #{y}  / #{column}, #{row}"
    @spot_arr[row + y_diff][column + x_diff]
  end

  def get_surrounding_spots(x, y)
    row = (y.floor / @resolution)
    column = (x.floor / @resolution)
    arr = []
    ((row-1)..(row+1)).each do |x|
      ((column-1)..(column+1)).each do |y|
        arr << @spot_arr[x][y] unless @spot_arr[x].nil? || @spot_arr[x][y].nil? || x < 0 || y < 0 || (x == row && y == column)
      end
    end
    arr
  end

  def get_position(spot)
    [spot.row*resolution, spot.column*resolution]
  end

  def increment(x, y)
    get_spot(x, y).increment
  end

  def decrement(x, y)
    get_spot(x, y).decrement
  end

  def decrement_all

  end

  def to_s
    str = ''
    @spot_arr.each do |a|
      a.each do |spot|
        str << spot.concentration.to_s rescue 'x'
      end
      str << " (#{a.length})"
      str << "\n"
    end
    str << '='*@spot_arr.length
    str
  end

end