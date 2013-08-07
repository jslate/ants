class Food
  attr_accessor :x, :y, :image, :being_carried

  def initialize(x, y)
    @x = x
    @y = y
    @being_carried = false
  end

  def move_to(x, y)
    @x = x
    @y = y
  end

end