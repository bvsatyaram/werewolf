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

  def reset
    @winner = nil
    resurrect_players
  end

  def winner
    @winner
  end

private

  def play_night
    @mode = :night
    $logger.log "It's night time!"
    $logger.log "Everybody slept"
    $logger.log "Wolves wokeup"
    wolves_kill_villager
  end

  def play_day
    @mode = :day
    return unless running?

    $logger.log "It's day time!"
    $logger.log @players.stats
    kick_after_voting
    $logger.log @players.stats
  end

  def announce_result
    $logger.log "Game Over!"
    if @winner == 0
      $logger.log "It's draw!"
    elsif @winner == 1
      $logger.log "Villagers won!"
    else
      $logger.log "Wolves won!"
    end
  end

  def wolves_kill_villager
    victim = @players.villagers.alive.sample
    victim.kill!
    $logger.log "Wolves killed #{victim.name}"
  end

  def kick_after_voting
    victim = Voting.new(@players.alive).run
    victim.kill!
    $logger.log "Villagers kicked out #{victim.name}"
  end

  def running?
    return @winner.nil?
  end

  def resurrect_players
    @players.each do |player|
      player.resurrect!
    end
  end
end