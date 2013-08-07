require File.expand_path("../../../app/model/ant", __FILE__)
require File.expand_path("../../../app/model/food", __FILE__)
require File.expand_path("../../../app/model/pheromone_map", __FILE__)

describe Ant do


    it "should get the correct left concentration" do
      map = PheromoneMap.new(100, 100, 10)
      5.times { map.increment(40, 40) }
      6.times { map.increment(40, 50) }
      7.times { map.increment(40, 60) }

      9.times { map.increment(30, 30) }
      9.times { map.increment(30, 40) }
      10.times { map.increment(30, 50) }
      11.times { map.increment(30, 60) }
      12.times { map.increment(30, 70) }

      ant = Ant.new(50, 50)
      ant.get_left_concentration(map).to_f.should eq(1)
    end

    it "should get the correct right concentration" do
      map = PheromoneMap.new(100, 100, 10)

      12.times { map.increment(60, 50) }

      ant = Ant.new(50, 50)
      ant.get_right_concentration(map).to_f.should eq(1)
    end

#   it "should move" do
#     ant = Ant.new(50, 50)
#     ant.move(100, 100, PheromoneMap.new(100, 100, 10))
#     ant.x.should_not eq(50)
#     ant.y.should_not eq(50)
#   end

#   it "should pick up food" do
#     ant = Ant.new(50, 50)
#     food = Food.new(50, 50)
#     ant.pickup(food)
#     food.being_carried.should == true
#   end

#   it "should head towards nest if carrying" do
#     ant = Ant.new(20, 50)
#     food = Food.new(50, 50)
#     ant.pickup(food)
#     ant.move(100, 100, PheromoneMap.new(100, 100, 10))
#     ant.angle.should eq(90)
#   end

#   it "should drop off food at nest" do
#     ant = Ant.new(20, 20)
#     food = Food.new(20, 20)
#     ant.pickup(food)
#     map = PheromoneMap.new(100, 100, 10)
#     50.times { ant.move(100, 100, map) }
#     food.being_carried.should == false
#   end

#   it "should get surrounding spots" do
#     map = PheromoneMap.new(100, 100, 10)
#     2.times { map.increment(40, 40) }
#     3.times { map.increment(50, 40) }
#     4.times { map.increment(60, 40) }
#     5.times { map.increment(40, 50) }
#     6.times { map.increment(60, 50) }
#     7.times { map.increment(40, 60) }
#     8.times { map.increment(50, 60) }
#     9.times { map.increment(60, 60) }
#     ant = Ant.new(50, 50)
#     ant.get_surrounding_spots(map).length.should eq(8)
#     ant.get_surrounding_spots(map)[0].concentration.should eq(2)
#     ant.get_surrounding_spots(map)[1].concentration.should eq(3)
#     ant.get_surrounding_spots(map)[2].concentration.should eq(4)
#     ant.get_surrounding_spots(map)[3].concentration.should eq(5)
#     ant.get_surrounding_spots(map)[4].concentration.should eq(6)
#     ant.get_surrounding_spots(map)[5].concentration.should eq(7)
#     ant.get_surrounding_spots(map)[6].concentration.should eq(8)
#     ant.get_surrounding_spots(map)[7].concentration.should eq(9)
#   end

#   it "should turn towards highest concentration" do
#     map = PheromoneMap.new(100, 100, 10)
#     10.times { map.increment(60, 60) }
#     ant = Ant.new(50, 50)
#     ant.angle = 90
#     ant.move(100, 100, map)
#     ant.angle.should be_within(1).of(135)
#   end

  # it "should turn closest angle if concentrations are the same" do
  #   map = PheromoneMap.new(100, 100, 10)
  #   10.times { map.increment(60, 40) }
  #   10.times { map.increment(60, 50) }
  #   10.times { map.increment(60, 60) }
  #   ant = Ant.new(50, 50)
  #   ant.angle = 80
  #   ant.move(100, 100, map)
  #   ant.angle.should be_within(1).of(90)
  # end

end

