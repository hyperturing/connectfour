class Board
  require 'matrix'

  attr_reader :board
  WIDTH = 4
  HEIGHT = 4

  def initialize(board = Array.new(Board::HEIGHT) { Array.new(Board::WIDTH) { 0 } })
    @board = board
  end

  def place_piece(position:, symbol:)
    if (row = board[position].find_index(&:zero?))
      board[position][row] = symbol == 'X' ? 1 : -1
      true
    else
      false
    end
  end

  def connect_four?
    @matrix = Matrix.rows(@board)
    @rotated = Matrix.rows(@board.reverse)

    WIDTH.times { |column| return true if @matrix.column(column).sum.abs == 4 }
    HEIGHT.times { |row| return true if @matrix.row(row).sum.abs == 4 }
    @matrix.trace.abs == 4 || @rotated.trace.abs == 4 ? true : false
  end
end
