require 'gosu'
require './app/model/ant'
require './app/model/food'
require './app/model/pheromone_map'
require './app/model/pheromone_spot'

class GameWindow < Gosu::Window

  HEIGHT = 675
  WIDTH = 900
  LEVEL_TIME = 60

  def initialize
    super(WIDTH, HEIGHT, false)
    self.caption = "Ants"
    @background_image = Gosu::Image.new(self, "media/background.png", true)

    @ants = []
    100.times do
      ant = Ant.new(WIDTH/2, HEIGHT/2)
      ant.image = Gosu::Image.new(self, File.expand_path("../../media/ant.png", __FILE__), true)
      @ants << ant
    end

    @foods = []
    3.times do
      center_x = (rand*WIDTH).floor
      center_y = (rand*HEIGHT).floor
      30.times do
        food = Food.new(center_x + (rand*30).floor,  center_y + (rand*30).floor)
        food.image = Gosu::Image.new(self, File.expand_path("../../media/food.png", __FILE__), true)
        @foods << food
      end
    end
    @moves = 0
    @pheromone_map = PheromoneMap.new(WIDTH, HEIGHT, 50)
    # WIDTH.times do |i|
    #   @pheromone_map.increment(i, HEIGHT/2)
    # end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @ants.each do |ant|
      ant.image.draw_rot(ant.x, ant.y, ZOrder::Ant, ant.angle)
      unless ant.carrying?
        @foods.each do |food|
          ant.pickup(food) if Gosu::distance(ant.x, ant.y, food.x, food.y) < 5 && !ant.at_nest?(WIDTH, HEIGHT)
        end
      end
    end
    @foods.each do |food|
      food.image.draw(food.x, food.y, ZOrder::Food)
    end
  end

  def update
    @ants.each do |ant|
      ant.move(WIDTH, HEIGHT, @pheromone_map)
      ant.food.move_to(ant.x, ant.y) if ant.carrying?
    end
    @moves += 1
    #@pheromone_map.decrement_one
    #puts @pheromone_map if @moves % 100 == 0
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

end

module ZOrder
  Background = 0
  Ant = 1
  Food = 2
end
