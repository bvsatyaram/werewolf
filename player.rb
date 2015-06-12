class Player
  def initialize(game, is_wolf = false)
    @game = game
    @is_wolf = is_wolf    
    @alive = true
  end

  def wolf?
    @is_wolf
  end

  def kill!
    @alive = false
    @game.announce_result_if_over
  end

  def alive?
    @alive
  end

  def role_name
    return (wolf? ? "Wolf" : "Villager")
  end

  def resurrect!
    @alive = true
  end
end