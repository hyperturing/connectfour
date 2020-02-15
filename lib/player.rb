class Player
  attr_accessor :name, :symbol

  def initialize(name: 'Ashley', symbol: 'X')
    @name = name
    @symbol = symbol
  end

  def move
    move = -1
    until move >= 0 && move < 4
      puts 'Enter your move:'
      move = gets.chomp.to_i
    end
    [move, symbol]
  end
end
