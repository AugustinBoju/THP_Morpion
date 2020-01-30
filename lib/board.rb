class Board
  #TO DO : la classe a 1 attr_accessor : un array/hash qui contient les BoardCases.
  #Optionnellement on peut aussi lui rajouter un autre sous le nom @count_turn pour compter le nombre de coups joué
  attr_accessor :board
  #initialisation du tableau
  def initialize
    @board = []
    9.times{ @board.push(BoardCase.new())}
  end
  #affichage du tableau V1
  def to_s
    list = []
    @board.each{ |caseboard|  list.push(caseboard.case_value)}
    "   1 2 3\n   - - -\nA |%s|%s|%s|\nB |%s|%s|%s|\nC |%s|%s|%s|\n   - - -\n" % list
  end

  #remplissage du tableau par nouvella association de caractere
  def put_on_board(symbol, place)
    place.split('')
    index = 0
    add = 0
    if place[0] == 'B'
      add = 3
    elsif place[0] == 'C'
      add = 6
    else
      add = 0
    end
    index = place[1].to_i-1+ add
    @board[index].case_value = symbol
  end
end
