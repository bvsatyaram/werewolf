require_relative 'player'

class Doctor < Villager
  def initialize(game)
    super(game)
    @role = Player::Role::DOCTOR
  end

  def save_player
    if self.alive?
      # TODO: Use AI in making this choice
      if rand(10) < 5
        # Save self
        patient = self
      else
        #Save a random player
        patient = (self.game.players.alive - [self]).sample
      end

      patient.save_for_night!
      $logger.log "Doctor chose to save #{patient.name}"
    else
      $logger.log "Doctor is dead to save people"
    end
  end

protected
  def name_prefix
    "Doctor_"
  end
end