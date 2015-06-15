require_relative 'player'

class Cop < Villager 
  def initialize(game)
    super(game)
    @role = Player::Role::COP
    @identified = []

  end

  def identifies_player
    if self.alive?
      player_identified = (self.game.players.alive - [self] - @identified).sample 
      @player_identified = player_identified
      $logger.log "Cop woke up"
      $logger.log "Cop chose to identify #{player_identified.name}"
      @identified.push(@player_identified)
     
    else
        $logger.log "Cop is dead to identify people."
    end
  end

 def pick_victim_by_voting
    $logger.log "-------COP'S VOTING TIME--------"

    if @player_identified.wolf?
      $logger.log "Cop voted for a wolf."
      return @player_identified
             
    else
      $logger.log "Cop voted for a player he didn't identify."
      return (@game.players.alive - [self] - @identified).sample
      
    end
  end 


protected
  def name_prefix
    "Cop_"
  end
end