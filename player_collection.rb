class PlayerCollection < Array
  def villagers
    players = self.select do |player|
      !player.wolf?
    end

    return PlayerCollection.new(players)
  end

  def wolves
    players = self.select do |player|
      player.wolf?
    end

    return PlayerCollection.new(players)
  end

  def alive
    players = self.select do |player|
      player.alive?
    end

    return PlayerCollection.new(players)
  end

  def stats
    "There are #{villagers.alive.count} villagers and #{wolves.alive.count} wolves"
  end
end