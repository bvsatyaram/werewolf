require_relative 'player_collection'
require_relative 'player'
require_relative 'voting'

class Game
  def initialize(no_of_wolves, no_of_villagers)
    @players = PlayerCollection.new
    no_of_wolves.times do
      @players.push(Player.new(true))
    end
    no_of_villagers.times do
      @players.push(Player.new)
    end
  end

  def play
    play_night
    play_day
  end

private

  def play_night
    announce "It's night time!"
    announce "Everybody slept"
    announce "Wolves wokeup"
    wolves_kill_villager
  end

  def play_day
    announce "It's day time!"
    announce @players.stats
    kick_after_voting
    announce @players.stats
  end

  def announce(str)
    puts ">> " + str
    # gets
  end

  def wolves_kill_villager
    victim = @players.villagers.alive.sample
    if victim.nil?
      announce "All villagers are dead!"
    else
      victim.kill!
      announce "Wolves killed #{victim.inspect}"
    end
  end

  def kick_after_voting
    victim = Voting.new(@players.alive).run
    victim.kill!
    announce "The kicked person is: #{victim.role_name}"
  end
end