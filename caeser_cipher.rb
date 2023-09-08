#!/usr/bin/env ruby
require 'pry-byebug'
def caeser_cipher(string, shift)
    a = string.split(" ")
    for i in 0..a.length-1
        for j in 0..a[i].length-1
            x = a[i][j].ord
            x = x-97
            y = (x+shift)%26
            y = y+97
            a[i][j] = y.chr
        end
    end
    s = a.join(" ")
    s
end
