require File.expand_path("../../../app/model/food", __FILE__)

describe Food do

  it "should move" do
    food = Food.new(50, 50)
    food.move_to(100, 100)
    food.x.should eq(100)
    food.y.should eq(100)
  end

end

