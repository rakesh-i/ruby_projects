def bubblesort(array)
    array.length.downto(1) do |i|
        for j in 1..i-1
            if array[j]<array[j-1]
                temp = array[j]
                array[j] = array[j-1]
                array[j-1] = temp
            end
        end
    end
    array
end

print bubblesort([4,3,78,2,0,2])
