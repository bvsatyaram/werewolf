require_relative 'player'

class Cop < Villager
	def initialize(game)
		super(game)
		@role = Player::Role::COP
	end

	def cop_selects
		if self.alive?
			cop_identified_players = []
			identified = (self.game.players.alive - [self]).sample

			$name = identified.name
			
			if identified.wolf? 
				puts "Cop selected #{$name}"
				cop_identified_players.push(identified)
				puts cop_identified_players

				alive_wolves = cop_identified_players.select do |player|
					player.alive?
				end

				return alive_wolves.sample
			else
				puts "Cop selected Villager"
				return (self.game.players.alive - [self]).sample
			end
		else

			puts "Cop is dead"
			return 0


		end



	end

protected
  def name_prefix
    "COP_"
  end
end


