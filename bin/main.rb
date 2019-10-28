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

  def winning_position(player)
    row = win_row(player)
    col = win_column(player)
    dia = win_diagonal(player)
    [row, col, dia].any?
  end

  def win_row(player)
      row1 = [@cell_grid[0][0], @cell_grid[0][1], @cell_grid[0][2]].all? {|x| x.marker == player.marker}
      row2 = [@cell_grid[1][0], @cell_grid[1][1], @cell_grid[1][2]].all? {|x| x.marker == player.marker}
      row3 = [@cell_grid[2][0], @cell_grid[2][1], @cell_grid[2][2]].all? {|x| x.marker == player.marker}
      [row1, row2, row3].any?
  end

  def win_column(player)
    col1 = [@cell_grid[0][0], @cell_grid[1][0], @cell_grid[2][0]].all? {|x| x.marker == player.marker}
    col2 = [@cell_grid[0][1], @cell_grid[1][1], @cell_grid[2][1]].all? {|x| x.marker == player.marker}
    col3 = [@cell_grid[0][2], @cell_grid[1][2], @cell_grid[2][2]].all? {|x| x.marker == player.marker}
    [col1, col2, col3].any?
  end

  def win_diagonal(player)
    dia1 = [@cell_grid[0][0], @cell_grid[1][1], @cell_grid[2][2]].all? {|x| x.marker == player.marker}
    dia2 = [@cell_grid[0][2], @cell_grid[1][1], @cell_grid[2][0]].all? {|x| x.marker == player.marker}
    [dia1, dia2].any?
  end

  def choose_cell(player)
    puts "#{player.name.capitalize} choose your position, (1 - 9): "
    position = gets.chomp.to_i
    until (1..9).include? position
      puts "Invalid Entry #{player.name.capitalize}, re-enter your position: "
      position = gets.chomp
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
      find_cell.marker = player.marker
    else
      puts "Cell already taken, please choose another position"
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
    puts "Welcome to Tic Tac Toe \n\n"
    puts "Press Enter to continue:"
    gets.chomp

  end

  def game_over(player)
   if @board.winning_position(player)
    puts "Congratulations #{player.name.capitalize} wins!"
    @game_on = false
   end
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

    player = player_first
    
    while @game_on
      @board.choose_cell(player)
      player = player == player_first ? player_second : player_first
      @board.draw
      game_over(player)
      
    end
  end
end

play = Game.new
play.play