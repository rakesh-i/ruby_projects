#!/usr/bin/env ruby
# frozen_string_literal: true

class MegaMind
    def initialize
        @random_number = Array.new(4)
        puts "-------Rules------"
        puts "1. '*' represents red pegs and 'O' represents white pegs. Example hint: * * O O"
        puts "2. 12 chances to guess the correct code"
        puts "Press '1' to play as Breaker"
        puts "Press '2' to play as Maker"
        choice = 0
        until choice==1||choice==2
            choice = gets.to_i
        end
        if choice == 1
            @random_number[0] = rand(1..6)
            @random_number[1] = rand(1..6)
            @random_number[2] = rand(1..6)
            @random_number[3] = rand(1..6)
            puts "You have 12 turns to solve"
            humanplays()
        elsif choice == 2
            v = 0
            until v==1
                puts "Enter a 4 digit number"
                num = gets.to_i
                @random_number = num.to_s.split("").map(&:to_i)
                v = valid(@random_number)
                if v==0
                    puts "Invalid number Try again"
                end
            end
            computerPlays()
        end
        
        
    end

    def valid(numarr)
        if numarr.length>4
            puts numarr.length
            return 0
        end
        if numarr[0]>6||numarr[1]>6||numarr[2]>6||numarr[3]>6
            return 0
        end
        return 1
    end

    def humanplays
        a = 12
        solved = 0
        while a!=0
            num = gets.to_i
            gnum = num.to_s.split("").map(&:to_i)
            red, white = guess(gnum)
            if red==4
                puts "YOU WIN!!!"
                return
            end
            a-=1
        end
        puts "You Lose!!! Code is #{@random_number.join}"
    end

    def computerPlays
        turns = 12
        guess = Array.new(4,1)
        a = 0
        while true
            print guess
            red, white = guess(guess)
            if red==4 
                return 1
            end
            sum = red+white
            if sum==0
                guess[0]+=1
                guess[1]+=1
                guess[2]+=1
                guess[3]+=1
            end
            if sum==1
                guess[1]+=1
                guess[2]+=1
                guess[3]+=1
            end
            if sum==2
                guess[2]+=1
                guess[3]+=1
            end
            if sum==3
                guess[3]+=1
            end
            if sum==4
                permutate = guess.permutation.to_a
                for i in 1..24
                    if(a==turns)
                        break
                    end
                    print permutate[i]
                    r, w = guess(permutate[i])
                    if(r==4)
                        puts "Computer took #{a} turn to solve"
                        return 1
                    end
                    a+=1
                end
            end
            a+=1
        end
        return 0
    end

    def guess(gnum)
        return clue(gnum, @random_number)
    end
    
    private

    def clue(arr, random)
        digits = random.dup
        array = arr.dup
        red = 0
        white = 0
        for i in 0..3
            if array[i] == digits[i]
                red+=1
                digits[i] = 0
                array[i] = 9;
            end
        end
        for i in 0..3
            for j in 0..3
                if array[i] == digits[j]
                    white+=1
                    digits[j] = 0
                    break
                end
            end
        end
        for i in 1..red
            print "* "
        end
        for i in 1..white
            print "O "
        end
        puts "" 
        return red, white
    end 
end

game = MegaMind.new
