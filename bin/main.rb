# frozen_string_literal: true
require_relative('../lib/player.rb')
require_relative('../lib/cell.rb')
require_relative('../lib/board.rb')

class Game  
  attr_accessor :board

  def initialize
    @board = Board.new
    @game_on = true
  end
  def welcome_message
    sleep(1)
    puts "\n\n"
    puts "======================"
    puts "WELCOME TO TIC TAC TOE"
    puts "======================"
    sleep(2)
    puts "\n\nPress any key to continue:"
    gets.chomp
    sleep(2)
  end

  def instruction
    puts "\n"
    puts "Press a to start the game: "
    puts "Press b to see how to play: "
    instruction = gets.chomp.downcase
    while instruction == 'b'
      #sleep(2)
      puts "\n\n"
      puts "================================="
      puts "You have chosen to see game rules"
      puts "================================="
      #sleep(2)
      puts "\n\n"
      puts "Game Rules"
      #sleep(2)
      puts "\n"
      puts "1. The game is played on a grid that's 3 squares by 3 squares."
      #sleep(2)
      puts "2. It is played by two persons and in which one of you will chosen at random to select a marker (X or O) and also start the game."
      #sleep(2)
      puts "3. If you select X, the next player is O or vice-versa. Players take turns putting their marks in empty squares."
      #sleep(2)
      puts "4. The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner."
      #sleep(2)
      puts "5. When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie."
      
      #sleep(2)
      puts "\n\n"
      puts "Press a to start the game: "
      puts "Press b to see how to play: "
      instruction = gets.chomp.downcase
    end
    if instruction == 'a'
      sleep(2)
      puts "\n\n"
      puts "============================="
      puts "You have chosen to start game"
      puts "============================="
    end
  end

  def draw_board(cell_grid, available)
    row = cell_grid[0]
    puts "#{row[0].content} | #{row[1].content} | #{row[2].content}       #{available[0]} | #{available[1]} | #{available[2]}"
    puts "---------       ---------"
    row = cell_grid[1]
    puts "#{row[0].content} | #{row[1].content} | #{row[2].content}       #{available[3]} | #{available[4]} | #{available[5]}"
    puts "---------       ---------"
    row = cell_grid[2]
    puts "#{row[0].content} | #{row[1].content} | #{row[2].content}       #{available[6]} | #{available[7]} | #{available[8]}"
  end

  def game_over(player)
    if @board.winning_position(player)
      puts "Congratulations #{player.name.capitalize} wins!"
      @game_on = false
    end
    game_tied = true
    @board.cell_grid.each do |row|
      if row.any? { |x| x.marker == nil }
        game_tied = false
        break
      end
    end

    if game_tied
      puts "The game is tied."
      @game_on = false
    end
  end

  def game_replay
  end

  def player_name
    puts "#{@player} Enter your name: "
    name = gets.chomp

    until name.is_a?(String) && name.length > 1
      puts "Invalid Entry, name must be more than one character! Please re-enter your name: "
      name = gets.chomp
    end
    name
  end

  def player_marker(player)
    puts "#{player.name.capitalize} choose your marker (X or O): "
    marker = gets.chomp.upcase
    until %w[X O].include? marker
      puts "Invalid Entry #{player.name.capitalize}, please re-enter your maker: "
      marker = gets.chomp.upcase
    end
    marker
  end

  def play
    welcome_message
    instruction


    #sleep(2)
    puts "\n\n"
    player1 = Player.new(player_name)

    #sleep(2)
    puts "\n\n"
    player2 = Player.new(player_name)

    #sleep(2)
    puts "\n\nHello #{player1.name.capitalize} and #{player2.name.capitalize}"

    player_first = Player.new('')
    random = player_first.random_player(player1, player2)

    player_first = random[0]
    player_second = random[1]

    #sleep(2)
    puts "\n\n#{player_first.name.capitalize} goes first!"
  
    #sleep(2)
    puts "\n\n"
    player_first.marker = player_marker(player_first)

    player_second.marker = player_first.marker == 'X' ? 'O' : 'X'
    #sleep(2)
    puts "\n\n"
    puts "#{player_first.name.capitalize}, your marker is #{player_first.marker}"
    #sleep(2)
    puts "#{player_second.name.capitalize}, your marker is #{player_second.marker}"
    #sleep(2)

    puts "\n\n"
    puts 'Displaying board...'
    #sleep(2)
    puts "\n\n"
    draw_board(@board.cell_grid, @board.available)

    player = player_first
    while @game_on
      puts "\n\n"
      @board.choose_cell(player)
      system('clear')
      puts "\n\n"
      draw_board(@board.cell_grid, @board.available)
      
      puts "\n\n"
      game_over(player)
      player = player == player_first ? player_second : player_first
    end
  end
end

play = Game.new
play.play