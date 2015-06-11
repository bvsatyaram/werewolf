class Player
  def initialize(is_wolf = false)
    @is_wolf = is_wolf    
    @alive = true
  end

  def wolf?
    @is_wolf
  end

  def kill!
    @alive = false
  end

  def alive?
    @alive
  end

  def role_name
    return (wolf? ? "Wolf" : "Villager")
  end
end