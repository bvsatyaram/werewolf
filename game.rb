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
    while running?
      play_night
      play_day
    end

    announce "Game Over!"
    if draw?
      announce "It's draw!"
    else
      announce "#{winning_team} won!"
    end
  end

private

  def play_night
    announce "It's night time!"
    announce "Everybody slept"
    announce "Wolves wokeup"
    wolves_kill_villager
  end

  def play_day
    return unless running?

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
    victim.kill!
    announce "Wolves killed #{victim.inspect}"
  end

  def kick_after_voting
    victim = Voting.new(@players.alive).run
    victim.kill!
    announce "The kicked person is: #{victim.role_name}"
  end

  def running?
    return !draw? && !(@players.villagers.alive.count == 0 || @players.wolves.alive.count == 0)
  end

  def draw?
    return @players.villagers.alive.count == 1 && @players.wolves.alive.count == 1
  end

  def winning_team
    if @players.villagers.alive.count == 0
      return "Wolves"
    else
      return "Villagers"
    end
  end
end