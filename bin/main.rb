#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative('../lib/player.rb')
require_relative('../lib/board.rb')

class Game 
  attr_accessor :board
  def initialize
    @game_on = true
    @player1 = nil
    @player2 = nil
  end

  def draw_board(cell_grid, available)
    row = cell_grid
    puts "Available      TIC-TAC_TOE\nmoves\n\n"
    puts "#{row[0]} | #{row[1]} | #{row[2]}       #{available[0]} | #{available[1]} | #{available[2]}"
    puts "---------       ---------"
    puts "#{row[3]} | #{row[4]} | #{row[5]}       #{available[3]} | #{available[4]} | #{available[5]}"
    puts "---------       ---------"
    puts "#{row[6]} | #{row[7]} | #{row[8]}       #{available[6]} | #{available[7]} | #{available[8]}"
  end

  def game_over(player)
    if @board.winning_position(player)
      puts "Congratulations #{player.name.capitalize} wins!"
      player.add_score
      sleep_mode
      puts 'Scores'
      point1 = @board.player1.score > 1 ? 'points' : 'point'
      point2 = @board.player2.score > 1 ? 'points' : 'point'

      puts "#{@board.player1.name.capitalize} has #{@board.player1.score} #{point1}"
      puts "#{@board.player2.name.capitalize} has #{@board.player2.score} #{point2}"

      @game_on = false
      game_replay(@board.player1, @board.player2)
    end

    game_tied = true
    if @board.available.any? { |x| x == ' ' }
      game_tied = false
    end

    if game_tied
      puts 'The game is a tie!.'
      sleep_mode
      puts 'Scores'
      point1 = @board.player1.score > 1 ? 'points' : 'point'
      point2 = @board.player2.score > 1 ? 'points' : 'point'

      puts "#{@board.player1.name.capitalize} has #{@board.player1.score} #{point1}"
      puts "#{@board.player2.name.capitalize} has #{@board.player2.score} #{point2}"

      @game_on = false
      game_replay(@board.player1, @board.player2)
    end
  end

  def game_replay(player1, player2)
    sleep_mode
    puts 'Do you want to play again (y/n)'
    replay = gets.chomp.downcase
    until %w[y n].include? replay
      sleep_mode
      puts 'Invalid Entry!'
      puts 'Do you want to play again (y/n)'
      replay = gets.chomp.downcase
    end
    if replay == 'n'
      sleep_mode
      puts "Alright then! Bye #{player1.name.capitalize} and #{player2.name.capitalize} :)"
      @game_on = false
      sleep_mode
    elsif replay == 'y'
      sleep_mode
      puts "Alright then, replaying game for #{player1.name.capitalize} and #{player2.name.capitalize}!"
      sleep(1)
      puts '...'
      sleep(1)
      puts '...'
      sleep(1)
      puts '...'
      sleep(1)

      system('clear')
      puts 'Displaying Board...'
      sleep_mode

      @board.reset
      draw_board(@board.cell_grid, @board.available)
      @game_on = true
      game_flip(@board.player1.name)
    end
  end

  def player_name(player)
    puts "#{player}, Enter your name: "
    name = gets.chomp

    until name.is_a?(String) && name.length > 1
      sleep_mode
      puts "Invalid Entry, name must be more than one character!\n#{player}, please re-enter your name: "
      name = gets.chomp
    end
    name
  end

  def player_marker(player)
    puts "#{player.capitalize} choose your marker (X or O): "
    marker = gets.chomp.upcase.to_sym
    until [:X, :O].include? marker
      sleep_mode
      puts "Invalid Entry #{player.capitalize}, please re-enter your marker: "
      marker = gets.chomp.upcase.to_sym
    end
    marker
  end

  def choose_cell(player)
    puts "#{player.name.capitalize} (#{player.marker}), choose your position, (1 - 9): "
    position = gets.chomp.to_i
    until @board.valid?(position)
      sleep_mode
      puts "Invalid Entry #{player.name.capitalize}, re-enter your position: "
      position = gets.chomp.to_i
    end

    find_cell = @board.get_marker(position)

    if [:X, :O].none? { |x| x == find_cell }
      @board.set_marker(position, player.marker)
    else
      sleep_mode
      puts "Cell already taken #{player.name.capitalize}, please choose another position"
      choose_cell(player)
    end
  end

  def sleep_mode
    sleep(0.5)
    puts "\n\n"
  end

  def welcome_message
    sleep_mode
    puts '======================'
    puts 'WELCOME TO TIC TAC TOE'
    puts '======================'
    sleep_mode
    puts 'Press any key to continue:'
    gets.chomp
    sleep_mode
  end

  def instruction
    buttons = "Press a to start the game: \nPress b to see how to play: "
    puts buttons
    instruct = gets.chomp.downcase
    until %w[a b].include? instruct
      sleep_mode
      puts 'Invalid Input!'
      sleep_mode
      puts buttons
      instruct = gets.chomp.downcase
    end
    if instruct == 'b'
      sleep_mode
      puts '================================='
      puts 'You have chosen to see game rules'
      puts '================================='

      sleep_mode
      puts 'Game Rules'

      sleep_mode
      puts '1. The game is played on a grid that\'s 3 squares by 3 squares.'
      sleep(2)
      puts '2. It is played by two persons and in which one of you will be chosen at random to select a marker (X or O) and also start the game.'
      sleep(2)
      puts '3. If you select X, the next player is O or vice-versa. Players take turns putting their marks in empty squares.'
      sleep(2)
      puts '4. The first player to get 3 of his/her marks in a row (up, down, across, or diagonally) is the winner.'
      sleep(2)
      puts '5. When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.'

      sleep_mode
      instruction
    elsif instruct == 'a'
      sleep_mode
      puts '============================='
      puts 'You have chosen to start game'
      puts '============================='
    end
  end

  def game_intro
    welcome_message
    instruction

    player1 = player_name('Player 1')
    @player1 = player1

    sleep_mode
    player2 = player_name('Player 2')
    @player2 = player2

    sleep_mode
    puts "Hello #{player1.capitalize} and #{player2.capitalize} :)"
  end

  def game_flip (start_player)
    sleep_mode
    puts "#{start_player.capitalize} goes first!"
    sleep_mode

    sleep_mode
    puts 'Displaying board...'
      
    sleep_mode
    draw_board(@board.cell_grid, @board.available)
    sleep_mode

    player = start_player == @board.player1.name ? @board.player1 : @board.player2
    while @game_on
      choose_cell(player)
      sleep_mode
      system('clear')

      draw_board(@board.cell_grid, @board.available)
      puts "\n\n"
      game_over(player)
      player = player.name == @board.player1.name ? @board.player2 : @board.player1
    end 
  end

  def play
    game_intro
  
    random = Player.random_player(@player1, @player2)
    player_first = random[0]
    player_second = random[1]
  
    marker1 = player_marker(player_first)
    marker2 = marker1 == :X ? :O : :X
  
    @board = Board.new(player_first, player_second, marker1, marker2)
    sleep_mode
    player = player_first == @board.player1.name ? @board.player1 : @board.player2

    puts "#{player_first.capitalize}, your marker is #{player.marker}"
    sleep(2)
    puts "#{player_second.capitalize}, your marker is #{player.marker == :X ? :O : :X }"
    game_flip(player_first)
  end
end

play = Game.new
play.play
