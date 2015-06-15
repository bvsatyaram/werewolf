require_relative 'player/player_collection'
require_relative 'player/wolf'
require_relative 'player/villager'
require_relative 'player/cop'
require_relative 'player/voting'


class Game
  module ResultCode
    VILLAGERS = 1
    WOLVES    = -1
    DRAW      = 0
  end

  def initialize(no_of_wolves, no_of_villagers)
    @players = PlayerCollection.new
    @players.add_players(self, no_of_wolves, no_of_villagers)
  end

  def play
    while running?
      play_night
      play_day
    end
  end

  def announce_result_if_over
    if @players.villagers.alive.count == 0
      @winner = ResultCode::WOLVES
    elsif @players.wolves.alive.count == 0
      @winner = ResultCode::VILLAGERS
    elsif @mode == :night && (@players.villagers.alive.count == 1 && @players.wolves.alive.count == 1)
      @winner = ResultCode::DRAW
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

  def players
    @players
  end

private

  def play_night
    @mode = :night
    @players.reset_saved_for_night!
    $logger.log "It's night time!"
    $logger.log "Everybody slept"
    @players.doctor.save_player
    @players.cop.cop_selects
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
    if @winner == ResultCode::DRAW
      $logger.log "It's draw!"
    elsif @winner == ResultCode::VILLAGERS
      $logger.log "Villagers won!"
    else
      $logger.log "Wolves won!"
    end
  end

  def wolves_kill_villager
    victim = @players.villagers.alive.sample
    if victim.saved_for_night?
      $logger.log "Wolves chose to kill #{victim.name}, but saved by the doctor"
      announce_result_if_over
    else
      victim.kill!
      $logger.log "Wolves killed #{victim.name}"
    end
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