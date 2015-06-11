require_relative 'player'

class Game
  def initialize(no_of_wolves, no_of_villagers)
    @players = []
    no_of_wolves.times do
      @players.push(Player.new(true))
    end
    no_of_villagers.times do
      @players.push(Player.new)
    end
  end

  def players
    return @players
  end
end