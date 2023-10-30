class Connect4
  def initialize
    @circle_empty = '○'
    @player1 = '●'
    @player2 = '◼'
    @grid = Array.new(6){Array.new(7, @circle_empty)}
    @col_fill = Array.new(7, 0)
  end

  def show_grid
    puts
    for i in 0..5
      for j in 0..6
        print "#{@grid[i][j]} "
      end
      puts
    end
    nil
  end

  def drop(player, col)
    if col>6 || col<=0 || @col_fill[col-1]>=6
      return "Invalid"
    else
      row = 5-@col_fill[col-1]
      @grid[row][col-1] = player
      @col_fill[col-1]+=1
    end
    nil
  end

  def check(cur)
    dia1 = dia_left_to_right(cur)
    dia2 = dia_right_to_left(cur)
    ver = vertical(cur)
    hor = horizontal(cur)
    if dia1||dia2||ver||hor
      return true
    end
    return false
  end

  def dia_left_to_right(cur)
    row = cur[0]
    col = cur[1]
    player = @grid[row][col]
    count = 0
    while row<6&&col<7

      if @grid[row][col]==player
        count+=1
        row+=1
        col+=1
        if count==4
          return true
        end
      else
        break
      end
    end
    count-=1
    row = cur[0]
    col = cur[1]
    while row>=0&&col>=0
      if @grid[row][col]==player
        count+=1
        row-=1
        col-=1
        if count==4
          return true
        end
      else
        return false
      end
    end
    return false
  end

  def dia_right_to_left(cur)
    row = cur[0]
    col = cur[1]
    player = @grid[row][col]
    count = 0
    while row<6&&col<7
      if @grid[row][col]==player
        count+=1
        row-=1
        col+=1
        if count==4
          return true
        end
      else
        break
      end
    end
    count-=1
    row = cur[0]
    col = cur[1]
    while row>=0&&col>=0
      if @grid[row][col]==player
        count+=1
        row+=1
        col-=1
        if count==4
          return true
        end
      else
        return false
      end
    end
    return false
  end

  def vertical(cur)
    row = cur[0]
    col = cur[1]
    player = @grid[row][col]
    count = 0
    while row<6
      if @grid[row][col]==player
        count+=1
        row+=1
        if count==4
          return true
        end
      else
        break
      end
    end
    count-=1
    row = cur[0]
    while row>=0
      if @grid[row][col]==player
        count+=1
        row-=1
        if count==4
          return true
        end
      else
        return false
      end
    end
    return false
  end

  def horizontal(cur)
    row = cur[0]
    col = cur[1]
    player = @grid[row][col]
    p player
    count = 0
    while col<7
      if @grid[row][col]==player
        count+=1
        col+=1
        if count==4
          return true
        end
      else
        break
      end
    end
    count-=1
    col = cur[1]
    while col>=0
      if @grid[row][col]==player
        count+=1
        col-=1
        if count==4
          return true
        end
      else
        return false
      end
    end
    return false
  end

end
