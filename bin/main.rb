# frozen_string_literal: true

require_relative('../lib/player.rb')
require_relative('../lib/cell.rb')
require_relative('../lib/board.rb')

class Game 
  attr_accessor :board
  def initialize
    @board = Board.new
    @game_on = true
    @player1 = nil
    @player2 = nil
  end

  def draw_board(cell_grid, available)
    row = cell_grid[0]
    puts "Available      TIC-TAC_TOE\nmoves\n\n"
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
    @board.cell_grid.each do |row|
      if row.any? { |x| x.marker == nil }
        game_tied = false
        break
      end
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
    puts "#{player.name.capitalize} choose your marker (X or O): "
    marker = gets.chomp.upcase
    until %w[X O].include? marker
      sleep_mode(1)
      puts "Invalid Entry #{player.name.capitalize}, please re-enter your marker: "
      marker = gets.chomp.upcase
    end
    marker
  end

  def choose_cell(player)
    puts "#{player.name.capitalize} (#{player.marker}), choose your position, (1 - 9): "
    position = gets.chomp.to_i
    until (1..9).include? position
      sleep_mode(1)
      puts "Invalid Entry #{player.name.capitalize}, re-enter your position: "
      position = gets.chomp.to_i
    end
    find_cell = nil
    @board.cell_grid.each do |row|
      find_cell = row.select do |x|
        x.id == position
      end
      find_cell = find_cell.first

      break unless find_cell.nil?
    end

    if find_cell.marker.nil?
      find_cell.marker = ' '
      @board.available[position - 1] = player.marker
    else
      sleep_mode(1)
      puts "Cell already taken #{player.name.capitalize}, please choose another position"
      choose_cell(player)
    end
  end

  def sleep_mode(sec)
    sleep(sec)
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

    sleep_mode(2)
    player1 = Player.new(player_name('Player 1'))
    @player1 = player1

    sleep_mode(2)
    player2 = Player.new(player_name('Player 2'))
    @player2 = player2

    sleep_mode(2)
    puts "Hello #{player1.name.capitalize} and #{player2.name.capitalize} :)"
  end

  def game_flip
    player_first = Player.new('')
    random = player_first.random_player(@player1, @player2)

    player_first = random[0]
    player_second = random[1]

    sleep_mode(2)
    puts "#{player_first.name.capitalize} goes first!"

    sleep_mode(2)
    player_first.marker = player_marker(player_first)

    player_second.marker = player_first.marker == 'X' ? 'O' : 'X'

    sleep_mode(2)
    puts "#{player_first.name.capitalize}, your marker is #{player_first.marker}"
    sleep(2)
    puts "#{player_second.name.capitalize}, your marker is #{player_second.marker}"

    sleep_mode(2)
    puts 'Displaying board...'

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
