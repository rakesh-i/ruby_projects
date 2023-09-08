def max_profit(prices)
    min = prices[0];
    mini = 0;
    a = [0,0]
    profit = 0;
    for i in 1..prices.length-1
        if(prices[i]<min)
            min = prices[i]
            mini = i;
        else
            profit = [profit, prices[i]-min].max
            if profit==prices[i]-min
                a[0]= mini
                a[1] = i;
            end
        end
    end
    a
end

print max_profit([17,3,6,9,15,8,6,1,10])