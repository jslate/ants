class PheromoneSpot
  attr_accessor :concentration, :row, :column

  def initialize(row, column)
    @row = row
    @column = column
    @concentration = 0
  end

  def increment
    @concentration += 1
  end

  def decrement
    @concentration -= 1 if @concentration > 0
  end

end