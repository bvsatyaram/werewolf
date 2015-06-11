require_relative 'player'

class Game
  def initialize(no_of_wolves, no_of_villagers)
    @players = []
    no_of_wolves.times do
      @players.push(Player.new(true))
    end
    no_of_villagers.times do
      @players.push(Player.new)
    end
  end

  def play
    play_night
  end

private

  def play_night
    announce "It' night time!"
    announce "Everybody slept"
    announce "Wolves wokeup"
    wolves_kill_villager
  end

  def announce(str)
    puts ">> " + str
    # gets
  end

  def wolves_kill_villager
    victim = villagers.sample
    victim.kill!
    announce "Wolves killed #{victim.inspect}"
  end

  def villagers
    return @players.select do |player|
      !player.wolf?
    end
  end
end