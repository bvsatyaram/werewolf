require_relative 'player'

class Villager < Player
  def initialize(game)
    @game = game
    @is_wolf = false
    @name = "villager_#{random_name}"
    @alive = true
  end
end