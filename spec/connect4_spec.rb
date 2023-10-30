require '../connect4'

describe Connect4 do
  game = Connect4.new
  describe '#show_grid' do
    it "shows the current grid" do
      expect(game.show_grid()).to eql(nil)
    end
  end
  describe "#drop" do
    it "dropping disks1" do
      expect(game.drop("●", 0)).to eql('Invalid')
    end
  end

  describe "#drop" do
    it "dropping disks2" do
      expect(game.drop("●", 1)).to eql(nil)
    end
  end
  describe "#drop" do
    it "dropping disks2" do
      expect(game.drop("●", 2)).to eql(nil)
    end
  end

  describe "#drop" do
    it "dropping disks3" do
      expect(game.drop("●", 2)).to eql(nil)
    end
  end

  describe "#drop" do
    it "dropping disks4" do
      expect(game.drop("●", 3)).to eql(nil)
    end
  end
  describe "#drop" do
    it "dropping disks4" do
      expect(game.drop("●", 3)).to eql(nil)
    end
  end
  describe "#drop" do
    it "dropping disks4" do
      expect(game.drop("●", 3)).to eql(nil)
    end
  end

  describe "#drop" do
    it "dropping disks5" do
      expect(game.drop("●", 4)).to eql(nil)
    end
  end
  describe "#drop" do
    it "dropping disks5" do
      expect(game.drop("●", 4)).to eql(nil)
    end
  end
  describe "#drop" do
    it "dropping disks5" do
      expect(game.drop("●", 4)).to eql(nil)
    end
  end

  describe "#drop" do
    it "dropping disks6" do
      expect(game.drop("◼", 5)).to eql(nil)
    end
  end

  describe "#dia_left_to_right" do
    xit "checks for dia connects" do
      expect(game.dia_left_to_right([2,3])).to eql(false)
    end
  end

  describe "#dia_right_to_left" do
    xit "checks for dia connects" do
      expect(game.dia_right_to_left([5,0])).to eql(true)
    end
  end

  describe "#horizontal" do
    xit "checks for horizontal connects" do
      expect(game.horizontal([5,4])).to eql(false)
    end
  end

  describe "#vertical" do
    xit "checks for vertical connects" do
      expect(game.vertical([0,3])).to eql(true)
    end
  end

  describe "#check" do
    it "checks for vertical connects" do
      expect(game.check([5,0])).to eql(true)
    end
  end


  describe '#show_grid' do
    it "shows the current grid" do
      expect(game.show_grid()).to eql(nil)
    end
  end

end
