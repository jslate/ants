require 'gosu'
require './app/model/ant'

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
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @ants.each do |ant|
      ant.image.draw_rot(ant.x, ant.y, ZOrder::Ant, ant.angle)
    end
  end

  def update
    @ants.each do |ant|
      ant.move_randomly(WIDTH, HEIGHT)
    end
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
end
