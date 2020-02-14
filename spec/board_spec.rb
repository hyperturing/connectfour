require './board.rb'

RSpec.describe Board do
  it 'initializes board correctly' do
    expect(Board.new.board).to eql([[' ', ' ', ' ', ' '],
                                    [' ', ' ', ' ', ' '],
                                    [' ', ' ', ' ', ' '],
                                    [' ', ' ', ' ', ' ']])
  end

  describe '#place_piece' do
    it 'updates board with new piece' do
      board = Board.new
      board.place_piece(pos: 1, symbol: 'X')

      expect(Board.new.board).to eql([[' ', ' ', ' ', ' '],
                                      [' ', ' ', ' ', ' '],
                                      [' ', ' ', ' ', ' '],
                                      [' ', 'X', ' ', ' ']])
    end

    it 'piece falls to lowest valid space' do
      board = Board.new
      board.place_piece(pos: 1, symbol: 'O')
      board.place_piece(pos: 1, symbol: 'X')

      expect(Board.new.board).to eql([[' ', ' ', ' ', ' '],
                                      [' ', ' ', ' ', ' '],
                                      [' ', 'O', ' ', ' '],
                                      [' ', 'X', ' ', ' ']])
    end

    it 'Cannot place place if column is full' do
      board = Board.new
      board.place_piece(pos: 1, symbol: 'X')
      board.place_piece(pos: 1, symbol: 'X')
      board.place_piece(pos: 1, symbol: 'X')
      board.place_piece(pos: 1, symbol: 'O')

      expect(board.place_piece(pos: 1, symbol: 'X')).to eql(false)
    end
  end

  describe '#connect_four?' do
    it 'returns true if four in a column' do
      board = Board.new
      board.place_piece(pos: 1, symbol: 'X')
      board.place_piece(pos: 1, symbol: 'X')
      board.place_piece(pos: 1, symbol: 'X')
      board.place_piece(pos: 1, symbol: 'X')

      expect(board.connect_four?).to eql(true)
    end

    it 'returns true if four in a row' do
      board = Board.new
      board.place_piece(pos: 0, symbol: 'X')
      board.place_piece(pos: 1, symbol: 'X')
      board.place_piece(pos: 2, symbol: 'X')
      board.place_piece(pos: 3, symbol: 'X')
 
      expect(board.connect_four?).to eql(true)
    end

    it 'returns true if four on a diagonal' do
      board = Board.new
      board.place_piece(pos: 0, symbol: 'O')
      board.place_piece(pos: 0, symbol: 'O')
      board.place_piece(pos: 0, symbol: 'O')
      board.place_piece(pos: 1, symbol: 'O')
      board.place_piece(pos: 1, symbol: 'O')
      board.place_piece(pos: 2, symbol: 'O')

      board.place_piece(pos: 0, symbol: 'X')
      board.place_piece(pos: 1, symbol: 'X')
      board.place_piece(pos: 2, symbol: 'X')
      board.place_piece(pos: 3, symbol: 'X')

      expect(board.connect_four?).to eql(true)
    end

    it 'returns false unless four are connected' do
      board = Board.new
      board.place_piece(pos: 1, symbol: 'X')
      board.place_piece(pos: 1, symbol: 'X')
      board.place_piece(pos: 1, symbol: 'X')
      board.place_piece(pos: 1, symbol: 'O')

      expect(board.connect_four?).to eql(false)
    end
  end
end
