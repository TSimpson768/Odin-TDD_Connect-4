# frozen_string_literal: true

# Represents a player, containing their counter and name
class Player
  def initialize(name, counter)
    @name = name
    @counter = counter
  end
  attr_reader :name, :counter
end
