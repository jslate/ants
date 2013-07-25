require File.expand_path("../../../app/model/ant", __FILE__)

describe Ant do
  it "should move randomly" do
    ant = Ant.new(50, 50)
    ant.move_randomly(100, 100)
    ant.x.should_not eq(50)
    ant.y.should_not eq(50)
  end

end

