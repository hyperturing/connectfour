require './lib/board.rb'

RSpec.describe Board do
  it 'initializes board correctly' do
    expect(Board.new.board).to eql([[0, 0, 0, 0],
                                    [0, 0, 0, 0],
                                    [0, 0, 0, 0],
                                    [0, 0, 0, 0]])
  end

  describe '#place_piece' do
    it 'updates board with new piece' do
      board = Board.new
      board.place_piece(position: 1, symbol: 'X')

      expect(board.board).to eql([[0, 0, 0, 0],
                                  [1, 0, 0, 0],
                                  [0, 0, 0, 0],
                                  [0, 0, 0, 0]])
    end

    it 'piece falls to lowest valid space' do
      board = Board.new
      board.place_piece(position: 1, symbol: 'O')
      board.place_piece(position: 1, symbol: 'X')

      expect(board.board).to eql([[0, 0, 0, 0],
                                  [-1, 1, 0, 0],
                                  [0, 0, 0, 0],
                                  [0, 0, 0, 0]])
    end
  end

  describe '#valid_move?' do
    it 'returns false if the column has no room' do
      board = Board.new
      board.place_piece(position: 1, symbol: 'O')
      board.place_piece(position: 1, symbol: 'X')
      board.place_piece(position: 1, symbol: 'O')
      board.place_piece(position: 1, symbol: 'X')

      expect(board.valid_move?(1)).to eql(false)
    end

    it 'returns true if the column has room' do
      board = Board.new
      board.place_piece(position: 1, symbol: 'O')
      board.place_piece(position: 1, symbol: 'X')
      board.place_piece(position: 1, symbol: 'O')

      expect(board.valid_move?(1)).to eql(true)
    end

    it 'returns false if the column is larger then the range' do
      board = Board.new
      expect(board.valid_move?(5)).to eql(false)
    end

    it 'returns false if the column is smaller then the range' do
      board = Board.new
      expect(board.valid_move?(-1)).to eql(false)
    end

    it 'returns true if the column is in range' do
      board = Board.new
      expect(board.valid_move?(3)).to eql(true)
    end
  end

  describe '#connect_four?' do
    it 'returns true if four in a column' do
      board = Board.new
      board.place_piece(position: 1, symbol: 'X')
      board.place_piece(position: 1, symbol: 'X')
      board.place_piece(position: 1, symbol: 'X')
      board.place_piece(position: 1, symbol: 'X')

      expect(board.connect_four?).to eql(true)
    end

    it 'returns true if four in a row' do
      board = Board.new
      board.place_piece(position: 0, symbol: 'X')
      board.place_piece(position: 1, symbol: 'X')
      board.place_piece(position: 2, symbol: 'X')
      board.place_piece(position: 3, symbol: 'X')
 
      expect(board.connect_four?).to eql(true)
    end

    it 'returns true if four on a diagonal' do
      board = Board.new
      board.place_piece(position: 0, symbol: 'O')
      board.place_piece(position: 0, symbol: 'O')
      board.place_piece(position: 0, symbol: 'O')
      board.place_piece(position: 1, symbol: 'O')
      board.place_piece(position: 1, symbol: 'O')
      board.place_piece(position: 2, symbol: 'O')

      board.place_piece(position: 0, symbol: 'X')
      board.place_piece(position: 1, symbol: 'X')
      board.place_piece(position: 2, symbol: 'X')
      board.place_piece(position: 3, symbol: 'X')

      expect(board.connect_four?).to eql(true)
    end

    it 'returns false unless four are connected' do
      board = Board.new
      board.place_piece(position: 1, symbol: 'X')
      board.place_piece(position: 1, symbol: 'X')
      board.place_piece(position: 1, symbol: 'X')
      board.place_piece(position: 1, symbol: 'O')

      expect(board.connect_four?).to eql(false)
    end
  end

  describe '#turn_count' do
    it 'gets the current turn' do
      board = Board.new
      board.place_piece(position: 1, symbol: 'O')
      board.place_piece(position: 1, symbol: 'X')

      expect(board.turn_count).to eql(2)
    end
  end

  describe '#current_player' do
    it 'gets the current player as player1' do
      board = Board.new
      board.place_piece(position: 0, symbol: 'X')
      board.place_piece(position: 1, symbol: 'O')
      board.place_piece(position: 0, symbol: 'X')
      board.place_piece(position: 2, symbol: 'O')
      board.place_piece(position: 0, symbol: 'X')
      board.place_piece(position: 1, symbol: 'O')
      board.place_piece(position: 0, symbol: 'X')

      expect(board.current_player).to eql('O')
    end

    it 'gets the current player as player2' do
      board = Board.new
      board.place_piece(position: 1, symbol: 'X')
      board.place_piece(position: 1, symbol: 'O')
      board.place_piece(position: 1, symbol: 'X')
      board.place_piece(position: 1, symbol: 'O')

      expect(board.current_player).to eql('X')
    end
  end

  describe '#full?' do
    it 'returns true if the board has no room left' do
      board = Board.new
      4.times do |column|
        4.times do |row|
          board.place_piece(position: column, symbol: 'O')
        end
      end
      expect(board.full?).to eql(true)
    end

    it 'returns false if the board has room left' do
      board = Board.new
      board.place_piece(position: 1, symbol: 'O')
      expect(board.full?).to eql(false)
    end
  end
end
