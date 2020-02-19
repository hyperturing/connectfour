require './lib/board.rb'
require './lib/player.rb'
require './lib/game.rb'

RSpec.describe Game do
  it 'creates a game board' do
    game = Game.new

    expect(game.board).to be_a Board
  end

  it 'creates a player1' do
    game = Game.new(player1: 'Ashley', player2: 'Ashley-2.0')

    expect(game.players['X']).to be_a Player
  end

  it 'creates a player2' do
    game = Game.new(player1: 'Ashley', player2: 'Ashley-2.0')

    expect(game.players['O']).to be_a Player
  end

  describe '#instructions' do
    it 'Displays a string of game instructions' do
      game = Game.new
      expect { game.instructions }.to output.to_stdout
    end
  end

  describe '#play' do
  end

  describe '#turn' do
  end

  describe '#over?' do
    it 'returns true if there is a connect-four' do
      game = Game.new
      game.board.place_piece(position: 1, symbol: 'X')
      game.board.place_piece(position: 1, symbol: 'X')
      game.board.place_piece(position: 1, symbol: 'X')
      game.board.place_piece(position: 1, symbol: 'X')

      expect(game.over?).to eql(true)
    end

    it 'returns true if the board is full' do
      game_array = [[-1, 1, -1, 1], [1, 1, -1, -1], [-1, 1, -1, 1], [1, -1, 1, -1]]
      game = Game.new(player1: 'Ashley', player2: 'Ashley-2.0', board: Board.new(game_array))

      expect(game.over?).to eql(true)
    end

    it 'returns false otherwise:' do
      game = Game.new
      game.board.place_piece(position: 1, symbol: 'X')

      expect(game.over?).to eql(false)
    end
  end

  describe '#winner' do
    it 'returns the winner of the game' do
      game = Game.new
      IoTestHelpers.simulate_stdin('1') { game.turn }
      IoTestHelpers.simulate_stdin('2') { game.turn }
      IoTestHelpers.simulate_stdin('1') { game.turn }
      IoTestHelpers.simulate_stdin('3') { game.turn }
      IoTestHelpers.simulate_stdin('1') { game.turn }
      IoTestHelpers.simulate_stdin('2') { game.turn }
      IoTestHelpers.simulate_stdin('1') { game.turn }

      expect(game.winner).to eql('X')
    end
  end

  describe '#won?' do
    it 'returns true if there is a winner' do
      game = Game.new
      game.board.place_piece(position: 0, symbol: 'O')
      game.board.place_piece(position: 1, symbol: 'O')
      game.board.place_piece(position: 2, symbol: 'O')
      game.board.place_piece(position: 3, symbol: 'O')

      expect(game.won?).to eql(true)
    end

    it 'returns false if there is not a winner yet' do
      game = Game.new
      game.board.place_piece(position: 1, symbol: 'O')
      game.board.place_piece(position: 2, symbol: 'O')

      expect(game.won?).to eql(false)
    end

    it 'returns false if there will not be a winner' do
      game_array = [[-1, 1, -1, 1], [1, 1, -1, -1], [-1, 1, -1, 1], [1, -1, 1, -1]]
      game = Game.new(player1: 'Ashley', player2: 'Ashley-2.0', board: Board.new(game_array))

      expect(game.won?).to eql(false)
    end
  end

  describe '#draw?' do
    it 'returns true if the game will end in a draw' do
      game_array = [[-1, 1, -1, 1], [1, 1, -1, -1], [-1, 1, -1, 1], [1, -1, 1, -1]]
      game = Game.new(player1: 'Ashley', player2: 'Ashley-2.0', board: Board.new(game_array))

      expect(game.draw?).to eql(true)
    end
    it 'returns false if the game will not end in a draw' do
      game = Game.new
      game.board.place_piece(position: 0, symbol: 'O')
      game.board.place_piece(position: 1, symbol: 'O')
      game.board.place_piece(position: 2, symbol: 'O')
      game.board.place_piece(position: 3, symbol: 'O')

      expect(game.draw?).to eql(false)
    end
  end

  describe '#turn' do
    it 'gets valid move from player and places piece on board' do
      game = Game.new
      IoTestHelpers.simulate_stdin('2') { game.turn }
      expect(game.board.board).to eql([[0, 0, 0, 0],
                                       [1, 0, 0, 0],
                                       [0, 0, 0, 0],
                                       [0, 0, 0, 0]])
    end
  end
end
