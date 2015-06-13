require_relative 'player'

class Wolf < Player
  def initialize(game)
    @game = game
    @is_wolf = true
    @name = "wolf_#{random_name}"
    @alive = true
  end
end