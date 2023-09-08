dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def subs(string, dictionary)
    x = Hash.new(0)
    string.downcase!
    array = string.split(" ")
    array.each do |j|
        dictionary.each do|i|
            if j.include?(i)
                x[i] += 1
            end
        end
    end
    x
end

puts subs("Howdy partner, sit down! How's it going?", dictionary)
