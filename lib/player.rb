class Player
  attr_accessor :name, :symbol

  def initialize(name: 'Ashley', symbol: 'X')
    @name = name
    @symbol = symbol
  end

  def move
    move = -1
    until move.positive? && move <= 4
      puts "\n\n#{name}, please enter your move:"
      move = gets.chomp.to_i
    end
    [move - 1, symbol]
  end
end
