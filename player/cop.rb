require_relative 'player'

class Cop < Villager
  def initialize(game)
    super(game)
    @role = Player::Role::COP
  end

  def identify_player

  end

  def cop_voting

  end

  # This being a class method we use the self 
protected
  def name_prefix
    "Cop_"
  end
end