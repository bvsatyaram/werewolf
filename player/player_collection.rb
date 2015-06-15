require_relative 'wolf'
require_relative 'villager'
require_relative 'doctor'
require_relative 'cop'

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
    players_villagers = self.select do |player|
      !player.wolf?
    end

    return PlayerCollection.new(players_villagers)
  end

  def wolves
    players_wolves = self.select do |player|
      player.wolf?
    end

    return PlayerCollection.new(players_wolves)
  end

  def doctor
    players_doctor = self.select do |player|
      player.doctor?
    end

    return players_doctor.first
  end

  def cop
    players_cop = self.select do |player|
      player.cop?
    end

    return players_cop.first
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