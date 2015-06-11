class Game
  def initialize(no_of_wolves, no_of_villagers)
    @players = []
    no_of_wolves.times do
      @players.push(Wolf.new)
    end
    no_of_villagers.times do
      @players.push(Villager.new)
    end
  end
end