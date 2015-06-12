require_relative 'player_collection'
require_relative 'player'
require_relative 'voting'

class Game
  def initialize(no_of_wolves, no_of_villagers)
    @players = PlayerCollection.new
    no_of_wolves.times do
      @players.push(Player.new(self, true))
    end
    no_of_villagers.times do
      @players.push(Player.new(self))
    end
  end

  def simulate(iterations)
    @hide_output = true
    villagers = 0
    wolves = 0
    draws = 0
    iterations.times do
      reset_game
      play
      case @winner
      when 0
        draws += 1
      when 1
        villagers += 1
      when -1
        wolves += 1
      end
    end

    @hide_output = false
    announce "Villagers won #{villagers} times"
    announce "Wolves won #{wolves} times"
    announce "There were #{draws} draws"
  end

  def play
    while running?
      play_night
      play_day
    end
  end

  def announce_result_if_over
    if @players.villagers.alive.count == 0
      @winner = -1
    elsif @players.wolves.alive.count == 0
      @winner = 1
    elsif @mode == :night && (@players.villagers.alive.count == 1 && @players.wolves.alive.count == 1)
      @winner = 0
    end

    announce_result unless @winner.nil?
  end

private

  def play_night
    @mode = :night
    announce "It's night time!"
    announce "Everybody slept"
    announce "Wolves wokeup"
    wolves_kill_villager
  end

  def play_day
    @mode = :day
    return unless running?

    announce "It's day time!"
    announce @players.stats
    kick_after_voting
    announce @players.stats
  end

  def announce_result
    announce "Game Over!"
    if @winner == 0
      announce "It's draw!"
    elsif @winner == 1
      announce "Villagers won!"
    else
      announce "Wolves won!"
    end
  end

  def announce(str)
    return if @hide_output
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
    return @winner.nil?
  end

  def reset_game
    @winner = nil
    resurrect_players
  end

  def resurrect_players
    @players.each do |player|
      player.resurrect!
    end
  end
end