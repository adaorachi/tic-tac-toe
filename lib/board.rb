# frozen_string_literal: true

class Board
  attr_accessor :cell_grid, :available
  def initialize
    reset
  end

  def winning_position(player)
    row = win_row(player)
    col = win_column(player)
    dia = win_diagonal(player)
    [row, col, dia].any?
  end

  def win_row(player)
    row1 = [@available[0], @available[1], @available[2]].all? { |x| x == player.marker }
    row2 = [@available[3], @available[4], @available[5]].all? { |x| x == player.marker }
    row3 = [@available[6], @available[7], @available[8]].all? { |x| x == player.marker }
    [row1, row2, row3].any?
  end

  def win_column(player)
    col1 = [@available[0], @available[3], @available[6]].all? { |x| x == player.marker }
    col2 = [@available[1], @available[4], @available[7]].all? { |x| x == player.marker }
    col3 = [@available[2], @available[5], @available[8]].all? { |x| x == player.marker }
    [col1, col2, col3].any?
  end

  def win_diagonal(player)
    dia1 = [@available[0], @available[4], @available[8]].all? { |x| x == player.marker }
    dia2 = [@available[2], @available[4], @available[6]].all? { |x| x == player.marker }
    [dia1, dia2].any?
  end

  def is_valid?(pos)
    return true if (1..9).include? pos
    return false
  end

  def set_marker(pos, marker)
    @available[pos - 1] = marker
    @cell_grid[pos - 1] = ' '
  end

  def get_marker(pos)
    return @available[pos-1]
  end

  def reset
    @available = []
    9.times { @available << ' ' }

    @cell_grid = []
    id = 1
    9.times do
      cell_grid.push(id.to_s)
      id += 1
    end
  end
end
