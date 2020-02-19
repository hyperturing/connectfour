require './lib/board.rb'
require './lib/player.rb'
class Game
  attr_reader :board, :players, :winner

  def initialize(player1: 'Ashley', player2: 'Ashley-2.0', board: Board.new)
    instructions
    @board = board
    @players = { 'X' => Player.new(name: player1, symbol: 'X'),
                 'O' => Player.new(name: player2, symbol: 'O') }
  end

  def instructions
    puts 'Welcome to Connect-Four!!'
    puts 'Instructions:'
    puts '========================'
    puts 'To make a move when prompted:'
    puts 'Enter the column number of your move(1 - 4)'
    puts
    puts '=======The Board========='
    puts
  end

  def play
    turn until over?

    if won?
      winner == 'X' || winner == 'O'
      puts "Congratulations #{@players[winner].name}!"
    elsif draw?
      puts 'Cats Game!'
    end
  end

  def turn
    @current_player = @board.current_player
    user_input = @players[@board.current_player].move
    until @board.valid_move?(user_input[0])
      user_input = @players[@board.current_player].move
    end
    @board.place_piece(position: user_input[0], symbol: user_input[1])
    @winner = @current_player if won?
    board.display_board
  end

  def over?
    board.full? || board.connect_four?
  end

  def won?
    board.connect_four?
  end

  def draw?
    board.full? || !board.connect_four?
  end
end
