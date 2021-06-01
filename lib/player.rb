class Player
  def initialize(name, counter)
    @name = name
    @counter = counter
  end
  attr_reader :name, :counter
end