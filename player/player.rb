class Player
  module Role
    WOLF = 1
    DOCTOR = 2
    SIMPLE_VILLAGER = 3
    COP = 4
  end

  def initialize(game)
    @game = game
    @alive = true
    @name = name_prefix + random_name
  end

  def wolf?
    @role == Role::WOLF
  end

  def doctor?
    @role == Role::DOCTOR
  end

  def cop?
    @role == Role::COP
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

  def game
    @game
  end

  def save_for_night!
    @saved_for_night = true
  end

  def saved_for_night?
    @saved_for_night
  end

  def reset_saved_for_night!
    @saved_for_night = false
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