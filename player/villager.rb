require_relative 'player'

class Villager < Player
  def initialize(game)
    super(game)
    @role = Player::Role::SIMPLE_VILLAGER
  end

  def pick_victim_by_voting
    return (@game.players.alive - [self]).sample
  end

protected
  def name_prefix
    "Villager_"
  end
end