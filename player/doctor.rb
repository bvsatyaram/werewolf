require_relative 'player'

class Doctor < Villager
  def initialize(game)
    super(game)
    @role = Player::Role::DOCTOR
  end

protected
  def name_prefix
    "Doctor_"
  end
end