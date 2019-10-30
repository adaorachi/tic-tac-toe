# frozen_string_literal: true

class Cell
  attr_accessor :position
  attr_reader :id
  attr_accessor :marker

  def initialize(id=nil, position=nil)
    @id = id
    @marker = nil
    @position = position
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
    @available = []
    (0..9).each { @available << ' ' }
    reset
  end

  def draw
    row = cell_grid[0]
    puts "#{row[0].content} | #{row[1].content} | #{row[2].content}       #{@available[0]} | #{@available[1]} | #{@available[2]}"
    puts "---------       ---------"
    row = cell_grid[1]
    puts "#{row[0].content} | #{row[1].content} | #{row[2].content}       #{@available[3]} | #{@available[4]} | #{@available[5]}"
    puts "---------       ---------"
    row = cell_grid[2]
    puts "#{row[0].content} | #{row[1].content} | #{row[2].content}       #{@available[6]} | #{@available[7]} | #{@available[8]}"
  end

  def display_board

  end

  def winning_position(player)
    row = win_row(player)
    col = win_column(player)
    dia = win_diagonal(player)
    [row, col, dia].any?
  end

  def win_row(player)
      row1 = [@available[0], @available[1], @available[2]].all? {|x| x == player.marker}
      row2 = [@available[3], @available[4], @available[5]].all? {|x| x == player.marker}
      row3 = [@available[6], @available[7], @available[8]].all? {|x| x == player.marker}
      [row1, row2, row3].any?
  end

  def win_column(player)
    col1 = [@available[0], @available[3], @available[6]].all? {|x| x == player.marker}
    col2 = [@available[1], @available[4], @available[7]].all? {|x| x == player.marker}
    col3 = [@available[2], @available[5], @available[8]].all? {|x| x == player.marker}
    [col1, col2, col3].any?
  end

  def win_diagonal(player)
    dia1 = [@available[0], @available[4], @available[8]].all? {|x| x == player.marker}
    dia2 = [@available[2], @available[4], @available[6]].all? {|x| x == player.marker}
    [dia1, dia2].any?
  end

  def choose_cell(player)
    puts "#{player.name.capitalize} choose your position, (1 - 9): "
    position = gets.chomp.to_i
    until (1..9).include? position
      puts "Invalid Entry #{player.name.capitalize}, re-enter your position: "
      position = gets.chomp.to_i
    end
    find_cell = nil
    @cell_grid.each do |row|
      find_cell = row.select do |x|
        x.id == position
      end
      find_cell = find_cell.first

      break unless find_cell == nil
    end

    if find_cell.marker == nil
      find_cell.marker = " "
      @available[position-1] = player.marker
    else
      puts "Cell already taken #{player.name.capitalize}, please choose another position"
      choose_cell(player)
    end
    
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
      sleep(2)
      puts "\n\n"
      puts "================================="
      puts "You have chosen to see game rules"
      puts "================================="
      sleep(2)
      puts "\n\n"
      puts "Game Rules"
      sleep(2)
      puts "\n"
      puts "1. The game is played on a grid that's 3 squares by 3 squares."
      sleep(2)
      puts "2. It is played by two persons and in which one of you will chosen at random to select a marker (X or O) and also start the game."
      sleep(2)
      puts "3. If you select X, the next player is O or vice-versa. Players take turns putting their marks in empty squares."
      sleep(2)
      puts "4. The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner."
      sleep(2)
      puts "5. When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie."
      
      sleep(2)
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

  def play
    welcome_message
    instruction

    player1 = Player.new('Player 1')
    sleep(2)
    puts "\n\n"
    player1.player_name

    player2 = Player.new('Player 2')
    sleep(2)
    puts "\n\n"
    player2.player_name

    sleep(2)
    puts "\n\nHello #{player1.name.capitalize} and #{player2.name.capitalize}"

    player_first = Player.new()
    random = player_first.random_player(player1, player2)

    player_first = random[0]
    player_second = random[1]

    sleep(2)
    puts "\n\n#{player_first.name.capitalize} goes first!"
  
    sleep(2)
    puts "\n\n"
    player_first.player_marker

    player_second.marker = player_first.marker == 'X' ? 'O' : 'X'
    sleep(2)
    puts "\n\n"
    puts "#{player_first.name.capitalize}, your marker is #{player_first.marker}"
    sleep(2)
    puts "#{player_second.name.capitalize}, your marker is #{player_second.marker}"
    sleep(2)

    puts "\n\n"
    puts 'Displaying board...'
    sleep(2)
    puts "\n\n"
    @board.draw

    player = player_first
    while @game_on
      puts "\n\n"
      @board.choose_cell(player)
      system('clear')
      puts "\n\n"
      @board.draw
      
      puts "\n\n"
      game_over(player)
      player = player == player_first ? player_second : player_first
    end
  end
end

play = Game.new
play.play