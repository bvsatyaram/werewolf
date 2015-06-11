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

  def pickVictimByVote
    votes = {}
    self.villagers.each do |villager|
      votedFor = (self - [villager]).sample
      votes[votedFor] ||= 0
      votes[votedFor] += 1
    end

    self.wolves.each do |wolf|
      votedFor = villagers.sample
      votes[votedFor] ||= 0
      votes[votedFor] += 1
    end

    max_votes = votes.values.max
    victims = []
    votes.each do |player, no_of_votes|
      victims.push(player) if no_of_votes == max_votes
    end

    if victims.size == 1
      return victims.first
    else
      return pickVictimByVote
    end
  end

  def stats
    "There are #{villagers.alive.count} villagers and #{wolves.alive.count} wolves"
  end
end