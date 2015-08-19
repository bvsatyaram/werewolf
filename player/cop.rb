require_relative 'villager'
require_relative 'player_collection'

class Cop < Villager
  def initialize(game)
    super(game)
    @role = Player::Role::COP
    @identified_villagers = PlayerCollection.new
    @identified_wolves = PlayerCollection.new
  end

  def identify_player
    if self.alive?
      player_to_identify = (
        self.game.players.alive - [self] -  
          @identified_villagers.alive - @identified_wolves.alive
        ).sample
      if (player_to_identify != nil)
        if ( player_to_identify.wolf? )
          @identified_wolves.push(player_to_identify)
        else
          @identified_villagers.push(player_to_identify)
        end
      end
    end

    $logger.log "Cop chose to identify #{player_to_identify}"
  end

  def cop_voting(votes)
    if self.alive?
      sorted_votes = votes.sort_by {|player , vote_count| vote_count}.reverse
      sorted_votes.each do |player|
        if ( @identified_wolves.alive.length == 0)
          return (@game.players.alive - [self] - @identified_villagers).sample
        elsif ( @identified_wolves.alive.include? player )
          return player
        end
      end

    end
  end

  # This being a class method we use the self 
protected
  def name_prefix
    "Cop_"
  end
end