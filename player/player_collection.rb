require_relative 'wolf'
require_relative 'villager'
require_relative 'doctor'
# require_relative 'cop'


class PlayerCollection < Array
  def add_players(game, no_of_wolves, no_of_villagers)
    no_of_wolves.times do
      self.push(Wolf.new(game))
    end

    self.push(Doctor.new(game))

    self.push(Cop.new(game))

    (no_of_villagers - 2).times do
      self.push(Villager.new(game))
    end

  end

  def villagers
    players = self.select do |player|
      !player.wolf?
    end

    return PlayerCollection.new(players)
  end

  def wolves
    players = self.select do |player|
      player.wolf?
    end

    return PlayerCollection.new(players)
  end

  def doctor
    players = self.select do |player|
      player.doctor?
    end

    return players.first
  end

  def cop
    players = self.select do |player|
      player.cop?
    end

    return players.first
  end

  def alive
    players = self.select do |player|
      player.alive?
    end

    return PlayerCollection.new(players)
  end

  def stats
    "There are #{villagers.alive.count} villagers and #{wolves.alive.count} wolves"
  end

  def reset_saved_for_night!
    self.each do |player|
      player.reset_saved_for_night!
    end
  end
end