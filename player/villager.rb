require_relative 'player'

class Villager < Player
  def initialize(game)
    super(game)
    @is_wolf = false
  end

  def pick_victim_by_voting
    return (@game.players.alive - [self]).sample
  end

protected
  def name_prefix
    "villager_"
  end
end