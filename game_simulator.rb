require_relative 'game'

class GameSimulator
  def initialize(no_of_wolves, no_of_villagers)
    @game = Game.new(no_of_wolves, no_of_villagers)
    @villagers_wins = 0
    @wolves_wins = 0
    @draws_wins = 0
  end

  def simulate(iterations)
    $logger.disable_logging
    
    iterations.times do
      @game.reset
      @game.play
      case @game.winner
      when Game::ResultCode::DRAW
        @draws_wins += 1
      when Game::ResultCode::VILLAGERS
        @villagers_wins += 1
      when Game::ResultCode::WOLVES
        @wolves_wins += 1
      end
    end

    $logger.enable_logging
    $logger.log "Villagers won #{@villagers_wins} times"
    $logger.log "Wolves won #{@wolves_wins} times"
    $logger.log "There were #{@draws_wins} draws"

    return percentage_villagers_win = (@villagers_wins + 0.5*@draws_wins)*100/iterations
  end
end