class Voting
  def initialize(players)
    @players = players
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
    @votes = {}
    (@players.alive - [@players.cop]).each do |player|
      votedFor = player.pick_victim_by_voting
      addVote(votedFor)
    end
    #Cop votes now, based on others votes
    cop = @players.cop
    if cop && cop.alive?
      votedFor = cop.pick_victim_by_voting(@votes)
      addVote(votedFor)
    else
      $logger.log "Cop is dead to vote"
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
      return run
    end
  end
end