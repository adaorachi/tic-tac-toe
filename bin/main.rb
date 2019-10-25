#!/usr/bin/env ruby

# Welcome Message
puts "Welcome to Tic-Tac_toe!"

game_on = true

# Ask for player 1 name & marker
puts "Enter your name: "
name1 = gets.chomp

# Ask for player 2 name & marker
puts "Enter your name: "
name2 = gets.chomp

# Ask for user input any command for the game if exit then exit the program


while true
    current_player = name1
    puts "Please #{current_player} pick a cell or type \"exit\" if you want exit the game"
    command = gets.chomp
    win_game, game_tie = false
    break if command == "exit"
    int_command = command.to_i
    case int_command
    when 1..9
        puts "#{current_player} picked the #{command} cell"
    else
        puts "You typed a wrong command, please enter your command again"
    end

    # This displays a grid of 9 empty cells
    puts "Display board"

    #checks columns rows and diagonals if someone won the game or game is tied then set win_game or game_tie variable

    if win_game
        # Checks if a player has won
        puts "Congrats! You have won!"
        puts "Do you wanna to play again? (y/n)"
        command = gets.chomp
        if command == "n"
            break
        end

        #reset_board
    elsif game_tie
        # Check if the game is tie
        puts "Game Over. It is a tie!"
        puts "Do you wanna to play again? (y/n)"
        command = gets.chomp
        if command == "n"
            break
        end

        #reset_board
    else
        puts "Flip marker"
        # current_player, other_player = other_player, current_player
    end
end


