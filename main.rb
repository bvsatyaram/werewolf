require_relative 'logger'
$logger = Logger.new

require_relative 'game'
require_relative 'game_simulator'


# game = Game.new(ARGV[0].to_i, ARGV[1].to_i)
# game.play
# GameSimulator.new(3, 6).simulate(100)
GameSimulator.new(ARGV[0].to_i, ARGV[1].to_i).simulate(ARGV[2].to_i)
# RoleSuggestor.new(14).suggest