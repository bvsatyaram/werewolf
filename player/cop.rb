require_relative 'player'

class Cop < Villager
  def initialize(game)
    super(game)
    @role = Player::Role::COP
  end

protected
  def name_prefix
    "Cop_"
  end
end