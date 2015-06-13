class Player
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

protected

  def random_name
    str = ""
    5.times do
      str += rand(10).to_s
    end

    return str
  end
end