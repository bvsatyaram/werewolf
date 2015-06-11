class Voting
  def initialize(players)
    @players = players
    @votes = {}
  end

  def run
    polling
    pick_leader
  end

private

  def addVote(player)
    @votes[player] ||= 0
    @votes[player] += 1
  end

  def polling
    @players.villagers.each do |villager|
      votedFor = (@players - [villager]).sample
      addVote(votedFor)
    end

    @players.wolves.each do |wolf|
      votedFor = @players.villagers.sample
      addVote(votedFor)
    end
  end

  def pick_leader
    max_votes = @votes.values.max
    victims = []
    @votes.each do |player, no_of_votes|
      victims.push(player) if no_of_votes == max_votes
    end

    if victims.size == 1
      return victims.first
    else
      @votes = {}
      return run
    end
  end
end