require 'gosu'
require './app/model/angle_range'

class Ant
  attr_accessor :x, :y, :angle, :image

  def initialize(x, y)
    @x = x
    @y = y
    @angle = 90
    @pheromones_on = false
    @speed = 1
  end

  def start_releasing_pheromones
    @pheromones_on = true
  end

  def stop_releasing_pheromones
    @pheromones_on = false
  end

  def move_randomly(max_x, max_y)
    deal_with_edge(max_x, max_y)
    @angle += (rand*100).floor - 50 if rand(10) == 1
    @angle = AngleRange::normalize(@angle)
    @x += Gosu::offset_x(@angle, @speed)
    @y += Gosu::offset_y(@angle, @speed)
  end


  def deal_with_edge(max_x, max_y)
    if @x > max_x && AngleRange.new(0, 180).include?(@angle)
      @angle = 270 - (@angle - 90)
    end
    if @x < 0  && AngleRange.new(180, 0).include?(@angle)
      @angle = 90 - (@angle - 270)
    end
    if @y < 100 && AngleRange.new(270, 90).include?(@angle)
      @angle = 180 - (@angle - 360)
    end
    if @y > max_y && AngleRange.new(90, 270).include?(@angle)
      @angle = 360 - (@angle - 180)
    end
  end

end
