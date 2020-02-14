require './board.rb'
require './player.rb'
require './game.rb'

RSpec.describe Game do
  it 'creates a game board' do
    game = Game.new

    expect(game.board).to_be_a Board
  end

  it 'creates a player1' do
    game = Game.new(player1: 'Ashley', player2: 'Ashley-2.0')

    expect(game.player1).to_be_a Player
  end

  it 'creates a player2' do
    game = Game.new(player1: 'Ashley', player2: 'Ashley-2.0')

    expect(game.player2).to_be_a Player
  end

  describe '#game_instructions' do
    it 'Displays a string of game instructions' do
      output = StringIO.new
      game = Game.new(output: output)
      game.game_instructions

      expect(output.string).not_to_be_empty
    end
  end

  describe '#game_over?' do
    it 'Ends the game when a player connects four' do
      game = Game.new
      game.board.place_piece(pos: 0, symbol: 'X')
      game.board.place_piece(pos: 1, symbol: 'X')
      game.board.place_piece(pos: 2, symbol: 'X')
      game.board.place_piece(pos: 3, symbol: 'X')

      expect(game.game_over?).to eql(true)
    end

    it 'Does not end the game unless a player connects four' do
      game = Game.new
      game.board.place_piece(pos: 0, symbol: 'X')
      game.board.place_piece(pos: 1, symbol: 'X')

      expect(game.game_over?).to eql(false)
    end
  end
end
