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
      player.score += 1
      sleep_mode(1)
      puts 'Scores'
      point1 = @player1.score > 1 ? 'points' : 'point'
      point2 = @player2.score > 1 ? 'points' : 'point'

      puts "#{@player1.name.capitalize} has #{@player1.score} #{point1}"
      puts "#{@player2.name.capitalize} has #{@player2.score} #{point2}"

      @game_on = false
      game_replay(@player1, @player2)
    end

    game_tied = true
    if @board.available.any? { |x| x == ' ' }
      game_tied = false
    end

    if game_tied
      puts 'The game is a tie!.'
      sleep_mode(1)
      puts 'Scores'
      point1 = @player1.score > 1 ? 'points' : 'point'
      point2 = @player2.score > 1 ? 'points' : 'point'

      puts "#{@player1.name.capitalize} has #{@player1.score} #{point1}"
      puts "#{@player2.name.capitalize} has #{@player2.score} #{point2}"

      @game_on = false
      game_replay(@player1, @player2)
    end
  end

  def game_replay(player1, player2)
    sleep_mode(2)
    puts 'Do you want to play again (y/n)'
    replay = gets.chomp.downcase
    until %w[y n].include? replay
      sleep_mode(1)
      puts 'Invalid Entry!'
      puts 'Do you want to play again (y/n)'
      replay = gets.chomp.downcase
    end
    if replay == 'n'
      sleep_mode(2)
      puts "Alright then! Bye #{player1.name.capitalize} and #{player2.name.capitalize} :)"
      @game_on = false
      sleep_mode(2)
    elsif replay == 'y'
      sleep_mode(3)
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
      sleep_mode(2)

      @board.reset
      draw_board(@board.cell_grid, @board.available)
      @game_on = true
      game_flip
    end
  end

  def player_name(player)
    puts "#{player}, Enter your name: "
    name = gets.chomp

    until name.is_a?(String) && name.length > 1
      sleep_mode(1)
      puts "Invalid Entry, name must be more than one character!\n#{player}, please re-enter your name: "
      name = gets.chomp
    end
    name
  end

  def player_marker(player)
    puts "#{player.capitalize} choose your marker (X or O): "
    marker = gets.chomp.upcase.to_sym
    until [:X, :O].include? marker
      sleep_mode(1)
      puts "Invalid Entry #{player.capitalize}, please re-enter your marker: "
      marker = gets.chomp.upcase.to_sym
    end
    marker
  end

  def choose_cell(player)
    puts "#{player.capitalize} (), choose your position, (1 - 9): "
    position = gets.chomp.to_i
    until @board.valid?(position)
      sleep_mode(1)
      puts "Invalid Entry #{player.capitalize}, re-enter your position: "
      position = gets.chomp.to_i
    end

    find_cell = @board.get_marker(position)

    if [:X, :O].none? { |x| x == find_cell }
      @board.set_marker(position, player.marker)
    else
      sleep_mode(1)
      puts "Cell already taken #{player.capitalize}, please choose another position"
      choose_cell(player)
    end
  end

  def sleep_mode(sec)
    sleep(sec/10)
    puts "\n\n"
  end

  def welcome_message
    sleep_mode(2)
    puts '======================'
    puts 'WELCOME TO TIC TAC TOE'
    puts '======================'
    sleep_mode(2)
    puts 'Press any key to continue:'
    gets.chomp
    sleep_mode(2)
  end

  def instruction
    buttons = "Press a to start the game: \nPress b to see how to play: "
    puts buttons
    instruct = gets.chomp.downcase
    until %w[a b].include? instruct
      sleep_mode(1)
      puts 'Invalid Input!'
      sleep_mode(1)
      puts buttons
      instruct = gets.chomp.downcase
    end
    if instruct == 'b'
      sleep_mode(2)
      puts '================================='
      puts 'You have chosen to see game rules'
      puts '================================='

      sleep_mode(2)
      puts 'Game Rules'

      sleep_mode(2)
      puts '1. The game is played on a grid that\'s 3 squares by 3 squares.'
      sleep(2)
      puts '2. It is played by two persons and in which one of you will be chosen at random to select a marker (X or O) and also start the game.'
      sleep(2)
      puts '3. If you select X, the next player is O or vice-versa. Players take turns putting their marks in empty squares.'
      sleep(2)
      puts '4. The first player to get 3 of his/her marks in a row (up, down, across, or diagonally) is the winner.'
      sleep(2)
      puts '5. When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.'

      sleep_mode(2)
      instruction
    elsif instruct == 'a'
      sleep_mode(2)
      puts '============================='
      puts 'You have chosen to start game'
      puts '============================='
    end
  end

  def game_intro
    welcome_message
    instruction

    # sleep_mode(2)
    # puts 'Player 1, Enter your name: '
    # name1 = gets.chomp

    # sleep_mode(2)
    # puts 'Player 2, Enter your name: '
    # name2 = gets.chomp

    player1 = player_name('Player 1')
    @player1 = player1

    sleep_mode(2)
    player2 = player_name('Player 2')
    @player2 = player2

    sleep_mode(2)
    puts "Hello #{player1.capitalize} and #{player2.capitalize} :)"
  end

  def game_flip
    random = Player.random_player(@player1, @player2)

    player_first = random[0]
    player_second = random[1]

    sleep_mode(2)
    puts "#{player_first.capitalize} goes first!"

    # marker1 = random[0] == name1 ? :X : :O 
    # marker2 = random[0] == name2 ? :O : :X 

    sleep_mode(2)
    # player_first.marker = player_marker(player_first)

    # player_second.marker = player_first.marker == :X ? :O : :X

    marker1 = player_marker(player_first)
    marker2 = marker1 == :X ? :O : :X

    sleep_mode(2)
    puts "#{player_first.capitalize}, your marker is #{marker1}"
    sleep(2)
    puts "#{player_second.capitalize}, your marker is #{marker2}"

    sleep_mode(2)
    puts 'Displaying board...'
    
    @board = Board.new(@player1, @player2, marker1, marker2)
    sleep_mode(2)
    draw_board(@board.cell_grid, @board.available)
    sleep_mode(1)

    player = player_first
    while @game_on
      choose_cell(player)
      sleep_mode(1)
      system('clear')

      draw_board(@board.cell_grid, @board.available)
      puts "\n\n"
      game_over(player)
      player = player == player_first ? player_second : player_first
    end 
  end

  def play
    game_intro
    game_flip
  end
end

play = Game.new
play.play
