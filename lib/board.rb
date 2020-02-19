class Board
  require 'matrix'

  attr_reader :board
  WIDTH = 4
  HEIGHT = 4

  def initialize(board = Array.new(Board::HEIGHT) { Array.new(Board::WIDTH) { 0 } })
    @board = board
  end

  def place_piece(position:, symbol:)
    row = board[position].find_index(&:zero?)
    board[position][row] = symbol == 'X' ? 1 : -1
  end

  def valid_move?(column)
    column.negative? || column > WIDTH ? false : board[column].any?(&:zero?)
  end

  def full?
    @board.flatten.all? { |space| [-1, 1].include?(space) }
  end

  def connect_four?
    @matrix = Matrix.rows(@board)
    @rotated = Matrix.rows(@board.reverse)

    WIDTH.times { |column| return true if @matrix.column(column).sum.abs == 4 }
    HEIGHT.times { |row| return true if @matrix.row(row).sum.abs == 4 }
    @matrix.trace.abs == 4 || @rotated.trace.abs == 4 ? true : false
  end

  def turn_count
    @board.flatten.count { |space| [-1, 1].include?(space) }
  end

  def current_player
    (turn_count % 2).zero? ? 'X' : 'O'
  end

  def winner
    current_player if connect_four?
  end

  def display_board
    puts "\n=======The Board========="
    rotated = @board.transpose.map(&:reverse).transpose.map(&:reverse).transpose.map(&:reverse)
    output = rotated.map { |row| row.map { |element| icon(element) } }
    output.map { |element| puts element.join(' ') }
  end

  private

  def icon(value)
    case value
    when 1
      ' X '
    when -1
      ' O '
    when 0
      '   '
    end
  end
end
