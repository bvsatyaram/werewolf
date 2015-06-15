require_relative "player"

class Cop < Villager

  def initialize(game)
    super(game)
    @role = Player::Role::COP
  end

  def live_players(arr)
    if arr.empty?
      return arr
    end
    players = arr.select do |player|
      player.alive?
    end
  end

  def identified_players
    @identified_players = @identified_players || []
  end

  def identified_wolves
    players = @identified_players.select do |player|
      player.wolf?
    end
  end

  def identified_villagers  
    players = @identified_players.select do |player|
      !player.wolf?
    end
  end

  def identify_player
    if self.alive?
      identified_player = live_players(@game.players).sample
      # identified_player = (@game.players-[self]).alive.sample
      if identified_player.wolf?
        $logger.log "Cop has identified a wolf #{identified_player}"
      else
        $logger.log "Cop has identified a villager #{identified_player}"
      end
      return self.identified_players.push(identified_player)

    else
      $logger.log "Cop is not alive"
    end
  end

  def pick_victim_by_voting
    if identified_players.last.wolf?
      voted_by_cop = @game.players.identified_players.last
    elsif !identified_wolves.empty?
      voted_by_cop = live_players(@game.players.identified_wolves).sample if !@game.players.identified_wolves.alive.empty?        
    else
      voted_by_cop = live_players(@game.players-identified_villagers-[self]).sample
    end
    $logger.log "Cop voted #{voted_by_cop}"
    return voted_by_cop
  end

  protected
  def name_prefix
    "Cop_"
  end

end