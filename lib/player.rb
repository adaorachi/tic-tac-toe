# frozen_string_literal: true

class Player
  attr_accessor :marker, :score
  attr_reader :name
  def initialize(name)
    @name = name
    @marker = ''
    @score = 0
  end

  def random_player(*args)
    args.shuffle
  end
end
