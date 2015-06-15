require_relative 'player'

class Cop < Villager
  def initialize(game)
    super(game)
    @role = Player::Role::COP
    @identified_wolves = PlayerCollection.new
    @identified_villagers = PlayerCollection.new
  end

  def identify_player
    if self.alive?
      accused = (self.game.players.alive - [self] - @identified_wolves - @identified_villagers).sample
      if accused.nil?
        $logger.log "Cop has identified everyone. None left to be identified"
      else
        if accused.wolf?
          @identified_wolves.push(accused)
        else
          @identified_villagers.push(accused)
        end
        $logger.log "Cop has identified #{accused.name}"
      end
    else
      $logger.log "Cop is dead to identify people"
    end
  end

  def pick_victim_by_voting(votes)
    wolves = @identified_wolves.alive
    if wolves.any?
      victim = pick_wolf_to_kick(wolves, votes)
    else
      victim = (@game.players.alive - [self] - @identified_villagers).sample
    end
    $logger.log "Cop voted for #{victim.name}"
    return victim
  end

protected
  def name_prefix
    "Cop_"
  end

private

  def pick_wolf_to_kick(wolves, votes)
    if wolves.count > 1
      highest_votes = -1
      leading_wolves = []
      wolves.each do |wolf|
        if votes[wolf] == highest_votes
          leading_wolves.push(wolf)
        else
          leading_wolves = [wolf]
        end
      end
      victim = leading_wolves.sample
    else
      victim = wolves.first
    end

    return victim
  end
end