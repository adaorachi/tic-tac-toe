# frozen_string_literal: true

class Cell

  def initialize(id)
    @id = id
    @marker = nil
  end

  def content
    @marker != nil ? @marker : @id
  end
end

class Player 
  attr_accessor :name, :marker
  def initialize(player = nil)
    @name = nil
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
  
  attr_accessor :cell_grid
  def initialize
    reset
  end

  def draw
    row = cell_grid[0]
    puts "#{row[0].content} | #{row[1].content} | #{row[2].content}"
    puts "---------"
    row = cell_grid[1]
    puts "#{row[0].content} | #{row[1].content} | #{row[2].content}"
    puts "---------"
    row = cell_grid[2]
    puts "#{row[0].content} | #{row[1].content} | #{row[2].content}"
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

  def reset
    @cell_grid = []
    id = 1
    (0..2).each do |row|
      current_row = []
      (0..2).each do |column|
        current_row.push(Cell.new(id))
        id += 1
      end
      cell_grid.push(current_row)
    end
  end
end

class Game  
  attr_accessor :board

  def initialize
    @board = Board.new
  end
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