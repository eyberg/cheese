require 'colorize'
require 'debugger'

require File.dirname(__FILE__) + '/pieces.rb'
require File.dirname(__FILE__) + '/rules.rb'
require File.dirname(__FILE__) + '/board.rb'

class Chess
  include Pieces

  attr_accessor :board

  def initialize
    self.board = Board.new(8,8)
    init_board
  end

  def play
    puts "Wouldn't you prefer a nice game of chess?"
    puts "(you are red, pieces are ordered erroneously left->right; top->down 0,0 based)"
    redraw_board
    ask_move
  end

  def init_board
    8.times do |i|
      board.set(0, i, 'o'.blue.on_white)
      board.set(2, i, 'o'.blue.on_white)
      board.set(3, i, 'o'.blue.on_white)
      board.set(4, i, 'o'.blue.on_white)
      board.set(5, i, 'o'.blue.on_white)
      board.set(7, i, 'o'.blue.on_white)
    end

    # only draw pawns for now
    8.times do |i|
      board.set(1, i,'p'.red.on_white)
      board.set(6, i,'p'.black.on_white)
    end
  end

  def ask_move

    print "\nWhat piece do you want to move? >"
    pos1 = gets
    print "\nWhere do you want to move it? >"
    pos2 = gets

    x1,y1,x2,y2 = get_coords(pos1, pos2)

    t, err = validate(x1,y1,x2,y2)

    if t then
      move_piece(x1,y1,x2,y2)

      redraw_board
      ask_move

    else
      puts err
      ask_move
    end

  end

  def get_coords(pos1, pos2)
    x1,y1 = pos1.strip.split(',')
    x2,y2 = pos2.strip.split(',')

    return x1,y1,x2,y2
  end

  def red_piece?(x1, y1)
    piece = board.get(y1,x1)

    piece.include?("31")
  end

  def black_piece?(x1, y1)
    piece = board.get(x1,y1)

    piece.include?("30")
  end

  def moving_backwards?(y1, y2)
    y1 > y2
  end

  def validate(x1,y1,x2,y2)

    unless x1 && x2 && y1 && y2
      return false, "Please re-enter."
    end

    if !red_piece?(x1, y1) then
      return false, "That's not your piece! (#{x1},#{y1})"
    end

    # pawn only - reafctor to pawn's rules
    if moving_backwards?(y1, y2) then
      return false, "You can't move backwards."
    end

    # only for pawns for now
    if !vacant?(x2,y2) then
      return false, "Not a vacant space."
    end

    return true
  end

  def vacant?(x1, y1)
    if board.get(x1, y1).eql? 'o'.blue.on_white then
      return true
    else
      return false
    end
  end

  def move_piece(x1,y1,x2,y2)
    board.set(x1,y1, 'o'.blue.on_white)
    board.set(x2,y2, 'p'.red.on_white)
  end

  def redraw_board
    crow = 0
    board.rows.each do |x|
      board.row(x).size.times.each do |y|
        print board.get(x,y)
      end
      print "\n"
    end
  end

end

chess = Chess.new
