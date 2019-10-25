#!/usr/bin/env ruby

# Welcome Message
puts "Welcome to Tic-Tac_toe!"

game_on = true

while game_on
    # Ask for player name & marker
    puts "Enter your name: "
    name = get.chomp

    puts "Enter your marker (X or O)"
    marker = get.chomp

    # This displays a grid of 9 empty cells
    puts "Display board"

    if win_game
        # Checks if a player has won
        break
        puts "Congrats! You have won!"
    elsif game_tie
        # Check if the game is tie
        puts "Game Over. It is a tie!"
    else
        puts "Flip marker"
        # current_player, other_player = other_player, current_player
    end


end


