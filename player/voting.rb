require_relative 'cop'
require_relative 'player_collection'

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
    if @players.cop != nil
      addVote(@players.cop.cop_voting(@votes))
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