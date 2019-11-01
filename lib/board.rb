# frozen_string_literal: true

require_relative('player.rb')

class Board
  attr_reader :cell_grid, :available, :player1, :player2
  def initialize(player1, player2, marker1, marker2)
    reset
    @player1 = Player.new(player1, marker1)
    @player2 = Player.new(player2, marker2)
  end

  def winning_position(player)
    row = win_row(player)
    col = win_column(player)
    dia = win_diagonal(player)
    [row, col, dia].any?
  end

  def all_equals?(cells, marker)
    [cells[0], cells[1], cells[2]].all? { |x| x == marker }
  end

  def win_row(player)
    row1 = all_equals?([@available[0], @available[1], @available[2]], player.marker)
    row2 = all_equals?([@available[3], @available[4], @available[5]], player.marker)
    row3 = all_equals?([@available[6], @available[7], @available[8]], player.marker)
    [row1, row2, row3].any?
  end

  def win_column(player)
    col1 = all_equals?([@available[0], @available[3], @available[6]], player.marker)
    col2 = all_equals?([@available[1], @available[4], @available[7]], player.marker)
    col3 = all_equals?([@available[2], @available[5], @available[8]], player.marker)
    [col1, col2, col3].any?
  end

  def win_diagonal(player)
    dia1 = all_equals?([@available[0], @available[4], @available[8]], player.marker)
    dia2 = all_equals?([@available[2], @available[4], @available[6]], player.marker)
    [dia1, dia2].any?
  end

  def valid?(pos)
    (1..9).include? pos
  end

  def set_marker(pos, marker)
    @available[pos - 1] = marker
    @cell_grid[pos - 1] = ' '
  end

  def get_marker(pos)
    @available[pos - 1]
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
