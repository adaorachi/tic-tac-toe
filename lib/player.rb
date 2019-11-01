# frozen_string_literal: true

class Player
  # attr_accessor :score
  attr_reader :name, :score
  def initialize(name, marker)
    @name = name
    @marker = marker
    @score = 0
  end

  def self.random_player(*args)
    args.shuffle
  end
end
