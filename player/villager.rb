require_relative 'player'

class Villager < Player
  def initialize(game)
    super(game)
    @is_wolf = false
  end

protected
  def name_prefix
    "villager_"
  end
end