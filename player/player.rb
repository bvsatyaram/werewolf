class Player
  module Role
    WOLF = 1
    DOCTOR = 2
    SIMPLE_VILLAGER = 3
  end

  def initialize(game)
    @game = game
    @alive = true
    @name = name_prefix + random_name
  end

  def wolf?
    @role == Role::WOLF
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

protected

  def random_name
    str = ""
    5.times do
      str += rand(10).to_s
    end

    return str
  end
end