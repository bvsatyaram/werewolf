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

  def pick_victim_by_voting
    if @identified_wolves.alive.any?
      victim =  @identified_wolves.alive.sample
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
end