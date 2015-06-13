require_relative 'player'

class Wolf < Player
  def initialize(game)
    super(game)
    @is_wolf = true
  end

protected
  def name_prefix
    "wolf_"
  end
end