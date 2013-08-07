require 'gosu'
require './app/model/angle_range'

class Ant
  attr_accessor :x, :y, :angle, :image, :food

  def initialize(x, y)
    @x = x
    @y = y
    @angle = (rand*360).floor
    @speed = 1
    @food = nil
  end

  def move(max_x, max_y, pheromone_map)
    if carrying?
      if at_droppoff?(max_x, max_y)
        dropoff
      else
        turn_towards([max_x/2, max_y/2])
        move_forward_at_current_angle
        pheromone_map.increment(@x.floor, @y.floor)
      end
    else
      deal_with_edge(max_x, max_y)
      calculate_and_change_angle(max_x, max_y, pheromone_map)
      #follow_trail(pheromone_map)
      move_forward_at_current_angle
    end
  end


  def get_surrounding_spots(pheromone_map)
    pheromone_map.get_surrounding_spots(@x, @y)
  end

  def get_closest_to_current_angle(pheromone_map)
    closest_to_current_angle = get_surrounding_spots(pheromone_map).sort{ |a,b|
      a_pos = pheromone_map.get_position(a)
      b_pos = pheromone_map.get_position(b)
      a_angle = Gosu::angle(@x, @y, a_pos[0], a_pos[1])
      b_angle = Gosu::angle(@x, @y, b_pos[0], b_pos[1])
      a_angle_diff = Gosu::angle_diff(@angle, a_angle)
      b_angle_diff = Gosu::angle_diff(@angle, b_angle)
      a_angle_diff <=> b_angle_diff
    }.first
  end

  def get_highest_concentration(pheromone_map)
    sorted = get_surrounding_spots(pheromone_map).sort { |a, b|
      a.concentration <=> b.concentration
    }
    sorted.select { |spot| spot.concentration == sorted.last.concentration }.shuffle.last
  end

  def calculate_and_change_angle(max_x, max_y, pheromone_map)
    closest = get_closest_to_current_angle(pheromone_map)
    highest = get_highest_concentration(pheromone_map)
    #puts "closest: #{closest.column}, #{closest.row} (#{closest.concentration})"
    target = highest.concentration == closest.concentration ? closest : highest
    #puts get_surrounding_spots(pheromone_map).map{|spot| spot.concentration}.join(',') + ' target: ' + target.concentration.to_s

    if target.concentration > 0
      turn_towards(pheromone_map.get_position(target))
    else
      @angle += (rand*100).floor - 50 if rand(10) == 1
    end
  end

  def turn_towards(point)
    @angle = Gosu::angle(@x, @y, point[0], point[1])
  end

  def move_forward_at_current_angle
    @angle = AngleRange::normalize(@angle)
    @x += Gosu::offset_x(@angle, @speed)
    @y += Gosu::offset_y(@angle, @speed)
  end

  def at_nest?(max_x, max_y)
    distance_from(max_x / 2, max_y / 2) < 30
  end

  def at_droppoff?(max_x, max_y)
    distance_from(max_x / 2, max_y / 2) < 10
  end

  def distance_from(x_pos, y_pos)
    Gosu::distance(@x, @y, x_pos, y_pos)
  end

  def pickup(food)
    unless food.being_carried
      @food = food
      @food.being_carried = true
    end
  end

  def dropoff
    @food.being_carried = false
    @food = nil
  end

  def carrying?
    @food
  end

  def deal_with_edge(max_x, max_y)
    if @x > max_x && AngleRange.new(0, 180).include?(@angle)
      @angle = 270 - (@angle - 90)
    end
    if @x < 0  && AngleRange.new(180, 0).include?(@angle)
      @angle = 90 - (@angle - 270)
    end
    if @y < 0 && AngleRange.new(270, 90).include?(@angle)
      @angle = 180 - (@angle - 360)
    end
    if @y > max_y && AngleRange.new(90, 270).include?(@angle)
      @angle = 360 - (@angle - 180)
    end
  end


  def follow_trail(pheromone_map)
  end

  def get_left_concentration(pheromone_map)
    (-3..-1).inject(0) do |sum, i|
      c = (i..i*-1).inject(0) { |sub_sum, j|
        sub_sum + pheromone_map.get_spot_relative_to(@x, @y, i, j).concentration
      }
      sum + (c > 0 ? c**i : 0)
    end
  end

  def get_right_concentration(pheromone_map)
    (1..3).inject(0) do |sum, i|
      c = (i*-1..i).inject(0) { |sub_sum, j|
        sub_c = pheromone_map.get_spot_relative_to(@x, @y, i, j).concentration
        puts "i: #{i}, j: #{j}, sub_c: #{sub_c}"
        sub_sum + sub_c
      }
      sum + (c > 0 ? c**(i*-1) : 0)
    end
  end

end
