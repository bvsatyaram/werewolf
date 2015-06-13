require_relative 'game_simulator'

class RoleSuggestor
  def initialize(players_count)
    @players_count = players_count
    @least_absolute_villagers_win_percentage_from_50 = 100
    @earlier_percentage = 100
  end

  def suggest(simulations_count = 100)
    $logger.master_disable_logging
    (1...@players_count).each do |wolves_count|
      percentage_of_villagers_wins = GameSimulator.new(wolves_count, @players_count - wolves_count).simulate(simulations_count)
      announce "The percentage of villagers winning with #{wolves_count} wolves and #{@players_count - wolves_count} villagers is #{percentage_of_villagers_wins}%"
      absolute_difference = (50 - percentage_of_villagers_wins).abs
      if absolute_difference < @least_absolute_villagers_win_percentage_from_50
        @least_absolute_villagers_win_percentage_from_50 = absolute_difference
      else
        if absolute_difference > @least_absolute_villagers_win_percentage_from_50
          # The best case is **wolves_count - 1** wolves
          announce "The game will be most interesting with #{wolves_count - 1} wolves and #{@players_count - wolves_count + 1} villagers."
        else
          # There are 2 best cases: **wolves_count - 1** wolves and **wolves_count** wolves
          announce "There are 2 cases when the game would be most interesting, choose one:"
          announce "#{wolves_count} wolves and #{@players_count - wolves_count} villagers"
          announce "#{wolves_count - 1} wolves and #{@players_count - wolves_count + 1} villagers"
        end
        announce "The chance of villagers winning is #{@earlier_percentage}%"
        break
      end
      @earlier_percentage = percentage_of_villagers_wins
    end
    $logger.master_enable_logging
  end

private
  def announce(str)
    $logger.log str, true
  end
end