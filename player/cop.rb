require_relative "player"

class Cop < Villager

  def initialize(game)
    super(game)
    @role = Player::Role::COP
  end

  def identify_player
    if self.alive?
      identified_player = @game.players.alive.sample
      if identified_player.wolf?
        $logger.log "Cop has identified a wolf #{identified_player}"
      else
        $logger.log "Cop has identified a villager #{identified_player}"
      end
      return @game.players.identified_players.push(identified_player)

    else
      $logger.log "Cop is dead"
    end
  end

  protected
  def name_prefix
    "Cop_"
  end

end