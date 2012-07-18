require File.dirname(__FILE__) + '/spec_helper.rb'

describe Rules do

  before do
    @chess = Chess.new
  end

  describe "in general" do
 
     it "can't move a piece that's not your own" do
      pos1 = "1,6"
      pos2 = "1,5"

      x1,y1,x2,y2 = @chess.get_coords(pos1, pos2)
      t, err = @chess.validate(x1,y1,x2,y2)

      t.should == false
      err.should == "That's not your piece! (1,6)"
    end

  end

  describe "pawn" do

    it "can't move into a non-diagonal occupied space" do
      pos1 = "1,1"
      pos2 = "1,6"

      x1,y1,x2,y2 = @chess.get_coords(pos1, pos2)
      t, err = @chess.validate(x1,y1,x2,y2)

      t.should == false
      err.should == "Not a vacant space."
    end

    it "can't move backwards" do
      pos1 = "1,1"
      pos2 = "1,0"

      x1,y1,x2,y2 = @chess.get_coords(pos1, pos2)
      t, err = @chess.validate(x1,y1,x2,y2)

      t.should == false
      err.should == "You can't move backwards."
    end

    it "can move one space up into a blank space" do
      pos1 = "1,1"
      pos2 = "1,2"

      old_piece = @chess.board.get(1,1)

      x1,y1,x2,y2 = @chess.get_coords(pos1, pos2)
      t, err = @chess.validate(x1,y1,x2,y2)
      @chess.move_piece(x1,y1,x2,y2)

      t.should == true
      old_piece.should == @chess.board.get(1,2)

    end

    it "can move two spaces up into a blank space if it is it's first move" do
      pos1 = "1,1"
      pos2 = "1,3"

      old_piece = @chess.board.get(1,1)

      x1,y1,x2,y2 = @chess.get_coords(pos1, pos2)
      t, err = @chess.validate(x1,y1,x2,y2)
      @chess.move_piece(x1,y1,x2,y2)

      t.should == true
      old_piece.should == @chess.board.get(1,3)
    end

    it "cannot move more than 1 space if it's not it's first move" do
      pos1 = "1,1"
      pos2 = "1,2"

      x1,y1,x2,y2 = @chess.get_coords(pos1, pos2)
      @chess.move_piece(x1,y1,x2,y2)

      pos1 = "2,1"
      pos2 = "1,4"

      x1,y1,x2,y2 = @chess.get_coords(pos1, pos2)
      t, err = @chess.validate(x1,y1,x2,y2)

      t.should == false
      err.should == "You can't move more than one space."
    end

    it "can capture a piece by one diagonal move up"

  end

end
