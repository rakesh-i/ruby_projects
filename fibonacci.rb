#!/usr/bin/env ruby
# frozen_string_literal: true


def fib(n)
  array = Array.new
  array<<0
  array<<1
  for i in 1..n-2
    array<< array[i-1]+array[i]
  end
  array
end

@my_array = Array.new
@my_array<<0
@my_array<<1

def fib_rec(n)
  if n<0
    return 0
  end
  if n==1
    return 1
  end
  @my_array[n]=(fib_rec(n-1)+fib_rec(n-2))
end

fib_rec(8)
print @my_array
