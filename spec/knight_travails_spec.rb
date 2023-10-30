require '../knight_travails'

describe Knight do
  kinght = Knight.new
  describe "#helper" do
    it "returns the number of steps" do
      expect(kinght.helper([3,3], [0,0])).to eql(2)
      expect(kinght.helper([3,3], [4,3])).to eql(3)
    end
  end
  describe "#trace" do
    it "returns true if path exists" do
      array = []
      expect(kinght.trace([0,0], array)).to eql(true)
    end
  end
end
