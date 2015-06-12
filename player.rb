class Player
  def initialize(game, is_wolf = false)
    @game = game
    @is_wolf = is_wolf
    @name = wolf? ? "wolf_#{random_name}" : "villager_#{random_name}"   
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

  def resurrect!
    @alive = true
  end

  def name
    @name
  end

private

  def random_name
    name = ""
    5.times do
      name += rand(10).to_s
    end

    return name
  end
end