# frozen_string_literal: true

class Cell
  def choose_position
  end
end

class Player 
  attr_accessor :name, :marker
  def initialize(player = nil, name = nil)
    @name = name
    @player = player
    @marker = marker
  end

  def player_name
    puts "#{@player} Enter your name: "
    name = gets.chomp

    until name.is_a?(String) && name.length > 1
      puts "Invalid Entry, name must be more than one character! Please re-enter your name: "
      name = gets.chomp
    end
    @name = name

  end

  def random_player(*args)
    args.shuffle
  end

  def player_marker
    puts "#{@name.capitalize} choose your marker (X or O): "
    marker = gets.chomp.upcase
    until %w[X O].include? marker
      puts "Invalid Entry #{@name.capitalize}, please re-enter your maker: "
      marker = gets.chomp.upcase
    end
    @marker = marker
  end
end
  
class Board
  def draw_board
  end

  def display_board
  end

  def winning_position
  end

  def win_row
  end

  def win_column
  end

  def win_diagonal
  end

  def draw
  end
end

class Game  
  def welcome_message
    puts "Welcome to Tic Tac Toe \n\n"
    puts "Press Enter to continue:"
    gets.chomp

  end

  def game_over
  end

  def game_replay
  end

  def play
    welcome_message

    player1 = Player.new('Player 1')
    player1.player_name

    player2 = Player.new('Player 2')
    player2.player_name

    puts "\n\nHello #{player1.name.capitalize} and #{player2.name.capitalize}"

    player_first = Player.new()
    random = player_first.random_player(player1, player2)

    player_first = random[0]
    player_second = random[1]

    puts "\n\n#{player_first.name.capitalize} goes first!"

    player_first.player_marker

    player_second.marker = player_first.marker == 'X' ? 'O' : 'X'

    puts "\n\n"
    puts "#{player_first.name.capitalize}, your marker is #{player_first.marker}"
    puts "#{player_second.name.capitalize}, your marker is #{player_second.marker}"


  end
end

play = Game.new
play.play