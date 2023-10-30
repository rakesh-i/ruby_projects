# frozen_string_literal: true

class Connect4
  def initialize
    @circle_empty = '○'
    @player1 = '●'
    @player2 = '◼'
    @grid = Array.new(6) { Array.new(7, @circle_empty) }
    @col_fill = Array.new(7, 0)
    system('clear')
    show_grid
  end

  def play
    count = 0
    p1 = '◼'
    p2 = '●'
    flag = 0
    while count < 42
      puts
      if flag.zero?
        print 'Player 1 turn '
        col = gets.chomp.to_i
        system('clear')
        x = drop(p1, col)
        show_grid
        flag = 1
        if x == true
          puts "#{p1} has won"
          break
        elsif x == 'Invalid'
          puts 'Invalid input try again'
          flag = 0
        end

      else
        print 'Player 2 turn '
        col = gets.chomp.to_i
        system('clear')
        x = drop(p2, col)
        show_grid
        flag = 0
        if x == true
          puts "#{p2} has won"
          break
        elsif x == 'Invalid'
          puts 'Invalid input try again'
          flag = 1
        end

      end
    end
  end

  def show_grid
    puts
    7.times do |i|
      print "#{i + 1}  "
    end
    puts
    6.times do |i|
      7.times do |j|
        print "#{@grid[i][j]}  "
      end
      puts
    end
    nil
  end

  def drop(player, col)
    return 'Invalid' if col > 7 || col <= 0 || @col_fill[col - 1] >= 6

    row = 5 - @col_fill[col - 1]
    @grid[row][col - 1] = player
    @col_fill[col - 1] += 1
    x = check([6 - @col_fill[col - 1], col - 1])
    return true if x == true

    nil
  end

  def check(cur)
    dia1 = dia_left_to_right(cur)
    dia2 = dia_right_to_left(cur)
    ver = vertical(cur)
    hor = horizontal(cur)
    return true if dia1 || dia2 || ver || hor

    false
  end

  def dia_left_to_right(cur)
    row = cur[0]
    col = cur[1]
    player = @grid[row][col]
    count = 0
    while row < 6 && col < 7

      break unless @grid[row][col] == player

      count += 1
      row += 1
      col += 1
      return true if count == 4

    end
    count -= 1
    row = cur[0]
    col = cur[1]
    while row >= 0 && col >= 0
      return false unless @grid[row][col] == player

      count += 1
      row -= 1
      col -= 1
      return true if count == 4

    end
    false
  end

  def dia_right_to_left(cur)
    row = cur[0]
    col = cur[1]
    player = @grid[row][col]
    count = 0
    while row >= 0 && col < 7
      break unless @grid[row][col] == player

      count += 1
      row -= 1
      col += 1
      return true if count == 4

    end
    count -= 1
    row = cur[0]
    col = cur[1]

    while row < 6 && col >= 0
      return false unless @grid[row][col] == player

      count += 1
      row += 1
      col -= 1
      return true if count == 4

    end
    false
  end

  def vertical(cur)
    row = cur[0]
    col = cur[1]
    player = @grid[row][col]
    count = 0
    while row < 6
      break unless @grid[row][col] == player

      count += 1
      row += 1
      return true if count == 4

    end
    count -= 1
    row = cur[0]
    while row >= 0
      return false unless @grid[row][col] == player

      count += 1
      row -= 1
      return true if count == 4

    end
    false
  end

  def horizontal(cur)
    row = cur[0]
    col = cur[1]
    player = @grid[row][col]
    count = 0
    while col < 7
      break unless @grid[row][col] == player

      count += 1
      col += 1
      return true if count == 4

    end
    count -= 1
    col = cur[1]
    while col >= 0
      return false unless @grid[row][col] == player

      count += 1
      col -= 1
      return true if count == 4

    end
    false
  end
end

game = Connect4.new

game.play
