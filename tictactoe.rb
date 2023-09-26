#!/usr/bin/env ruby
# frozen_string_literal: true

class Ticktactoe
    def initialize
        @array = Array.new(3){Array.new(3,"x")};
        show()
        @ply= 0
        for i in 1..9
            if @ply==0
                valid=0
                puts "PLAYER 1 TURN"
                while valid==0
                    print "Enter the row : "
                    r=gets.to_i
                    print "Enter the col : "
                    c=gets.to_i
                    valid = insert1(r-1,c-1)
                end
                if valid==-1
                    break
                end
                @ply=1
            else
                valid=0
                puts "PLAYER 2 TURN"
                while valid==0
                    print "Enter the row : "
                    r=gets.to_i
                    print "Enter the col : "
                    c=gets.to_i
                    valid = insert2(r-1,c-1)
                end
                if valid==-1
                    break
                end
                @ply=0
            end
        end
        puts "Its a draw"
    end

    private

    def show
        # for i in 0..2
        #     for j in 0..2
        #         print "#{@array[i][j]} "
        #     end
        #     puts ""
        # end
        # puts ""
        puts "#{@array[0][0]} | #{@array[0][1]} | #{@array[0][2]}"
        puts "--+---+--"
        puts "#{@array[1][0]} | #{@array[1][1]} | #{@array[1][2]}"
        puts "--+---+--"
        puts "#{@array[2][0]} | #{@array[2][1]} | #{@array[2][2]}"
    end
    def insert1(row, col)
        if row<0||col<0||row>2||col>2||@array[row][col]!="x"
            puts "Illegal move try again"
            return 0
        end
        @array[row][col]=1
        show()
        if test(1)==1
            puts "Player 1 wins"
            return -1
        end
        return 1
    end
    def insert2(row, col)
        if row<0||col<0||row>2||col>2||@array[row][col]!="x"
            puts "Illegal move try again"
            return 0
        end
        @array[row][col]=0
        show()
        if test(0)==1
            puts "Player 2 wins"
            return -1
        end
        return 1
    end
    
    def test(player)
        if @array[0][0]==player&&@array[0][1]==player&&@array[0][2]==player
            return 1
        end
        if @array[1][0]==player&&@array[1][1]==player&&@array[1][2]==player
            return 1
        end
        if @array[2][0]==player&&@array[2][1]==player&&@array[2][2]==player
            return 1
        end
        if @array[0][0]==player&&@array[1][0]==player&&@array[2][0]==player
            return 1
        end
        if @array[0][1]==player&&@array[1][1]==player&&@array[2][1]==player
            return 1
        end
        if @array[0][2]==player&&@array[1][2]==player&&@array[2][2]==player
            return 1
        end
        if @array[0][0]==player&&@array[1][1]==player&&@array[2][2]==player
            return 1
        end
        if @array[0][2]==player&&@array[1][1]==player&&@array[2][0]==player
            return 1
        end

        return 0
    end

end

game1 = Ticktactoe.new
