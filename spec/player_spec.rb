require './lib/player.rb'
require './lib/IoTestHelpers.rb'

RSpec.describe Player do
  it 'Player1 initializes with a name' do
    player1 = Player.new(name: 'Ashley', symbol: 'X')

    expect(player1.name).to eql('Ashley')
  end

  it 'Player1 initializes with a piece symbol' do
    player1 = Player.new(name: 'Ashley', symbol: 'X')

    expect(player1.symbol).to eql('X')
  end

  it 'Player2 initializes with a name' do
    player2 = Player.new(name: 'Ashely-2.0', symbol: 'O')

    expect(player2.name).to eql('Ashely-2.0')
  end

  it 'Player2 initializes with a piece symbol' do
    player2 = Player.new(name: 'Ashely-2.0', symbol: 'O')

    expect(player2.symbol).to eql('O')
  end

  describe '#move' do
    it 'gets the move position and piece symbol from the player' do
      player1 = Player.new(name: 'Ashley', symbol: 'X')
      expect(IoTestHelpers.simulate_stdin('2') { player1.move }).to eql([1, 'X'])
    end
  end
end
