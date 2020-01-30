class Game

  attr_accessor :player_1, :player_2, :board, :playable_cases

  def initialize()
    @board = Board.new()
    @playable_cases = ["A1","A2","A3","B1","B2","B3","C1","C2","C3"]
  end

  #Lancement du jeu
  def go
    turn_number = 1
    who_plays = 0
    winner = false

    symbols = ["X", "O"]

    #Menu
    puts "========= THE Morpion ========="
    puts "          With a big M"
    puts ""
    puts "Name of player 1"

    name_1 = gets.chomp

    puts "Name of player 2"

    name_2 = gets.chomp

    puts "#{name_1}, choose ur symbol (O ou X)"

    #chois du symbol pour le joueur 1, par defaut pour le joueur 2
    symbol_1 = gets.chomp.capitalize
    symbols.delete(symbol_1)
    symbol_2 = symbols[0]

    puts "=" * 20
    puts "#{name_2}, ur symbol is #{symbol_2}"
    puts "======= Let's start ======="

    @player_1 = Player.new(name_1, symbol_1)
    @player_2 = Player.new(name_2, symbol_2)

    puts @board
    while not (winner || @playable_cases.size == 0)
      winner = turn(who_plays)
      turn_number += 1
      who_plays = (1 - who_plays)
    end

    if winner
      puts "=" * 40
      puts " Congratulations #{winner.name}, u WIN ! "
      puts "=" * 40
    else
      puts "=" * 40
      puts " Game over, there is no winner ..."
      puts "=" * 40
    end
  end

  #chaques tours des joueurs, ils vont choisir une case qui
  #sera verifiée valide ou non en fonction des choix deja faits
  def turn(number)
    player = [@player_1, @player_2][number]

    puts "==> #{player.name} ur turn! "

    player_choice = gets.chomp.upcase
    puts "-" * 10
    #si la case n'est pas valide le joueur doit changer
    #cf: ligne 81
    while not @playable_cases.include?(player_choice)
      puts "!!! #{player.name} choose a valid case !!!"
      puts @playable_cases
      player_choice = gets.chomp.upcase
    end
    #remplissage du tableau par le choix du joueur
    @board.put_on_board(player.symbol,player_choice)
    #choix rayé du tableau
    @playable_cases.delete(player_choice)

    puts @board
    puts "-" * 10

    return game_over(player)
  end

  #fin du jeu si une combinaison est gagnante
  def game_over(player)
    #combinaisons gagnantes
    vic_combi = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    #verifie si les cases occupées le sont par le meme joueur
    vic_combi.each do |victorious_case|
      if @board.board[victorious_case[0]].case_value + @board.board[victorious_case[1]].case_value+ @board.board[victorious_case[2]].case_value == player.symbol * 3
        return player
      end
    end
    return false
  end
end
