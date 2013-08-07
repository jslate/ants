require File.expand_path("../../../app/model/pheromone_map", __FILE__)

describe PheromoneMap do
  it "should get the right spot" do
    map = PheromoneMap.new(100, 100, 10)
    map.get_spot(50, 60).row.should eq(6)
    map.get_spot(50, 60).column.should eq(5)
  end

  it "should return 0 for any uset point" do
    map = PheromoneMap.new(100, 100, 10)
    map.get_spot(50, 50).concentration.should eq(0)
  end

  it "should increment" do
    map = PheromoneMap.new(100, 100, 10)
    10.times { map.increment(50, 50) }
    map.get_spot(50, 50).concentration.should eq(10)
  end

  it "should decrement" do
    map = PheromoneMap.new(100, 100, 10)
    10.times { map.increment(50, 50) }
    5.times { map.decrement(50, 50) }
    map.get_spot(50, 50).concentration.should eq(5)
  end

  it "shouldn't decrement past 0" do
    map = PheromoneMap.new(100, 100, 10)
    10.times { map.increment(50, 50) }
    15.times { map.decrement(50, 50) }
    map.get_spot(50, 50).concentration.should eq(0)
  end

end

