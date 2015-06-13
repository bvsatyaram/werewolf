require_relative 'player'

class Wolf < Player
  def initialize(game)
    super(game)
    @role = Player::Role::WOLF
  end

  def pick_victim_by_voting
    return @game.players.villagers.alive.sample
  end

protected
  def name_prefix
    "Wolf_"
  end
end