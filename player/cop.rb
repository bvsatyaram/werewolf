require_relative "player"

class Cop < Villager

  def intialize(game)
    super(game)
    @role = Player::Role::COP
  end

  def indentify_player
    if self.alive?
      identified_player = @players.alive.sample
      if identified_player.wolf?
        $logger.log "Cop has identified a wolf #{identified_player}"
      else
        $logger.log "Cop has identified a villager #{identified_player}"
      end
      return @identified_players.push(identified_player)

    else
      $logger.log "Cop is dead"
    end
  end

end