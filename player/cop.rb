require_relative 'player'

class Cop < Villager
  def initialize(game)
    super(game)
    @role = Player::Role::COP
    @identified_wolves = []
    @identified_villagers = []
  end

  def identify_player
    if self.alive?
      accused = (self.game.players.alive - @identified_wolves - @identified_villagers).sample
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

protected
  def name_prefix
    "Cop_"
  end
end