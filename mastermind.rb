#!/usr/bin/env ruby
# frozen_string_literal: true

class MegaMind
    def initialize
        @random_number = Array.new(4)
        @random_number[0] = rand(1..6)
        @random_number[1] = rand(1..6)
        @random_number[2] = rand(1..6)
        @random_number[3] = rand(1..6)
        puts @random_number
    end

    def guess(gnum)
        return clue(gnum, @random_number)
    end

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
        if red==4
            puts "You win"
            return 1
        else
            puts "#{red}, #{white}"
            return 0
        end
    end 
end

game = MegaMind.new
a = 0
while a!=1
    num = gets
    gnum = num.to_s.split("").map(&:to_i)
    a = game.guess(gnum)
end
