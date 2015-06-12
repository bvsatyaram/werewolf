require_relative 'game'
game = Game.new(ARGV[0].to_i, ARGV[1].to_i)
game.play
# game.simulate(100)