class Board
  
    attr_accessor :cell_grid, :available
    def initialize
      @available = []
      (0..9).each { @available << ' ' }
      reset
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