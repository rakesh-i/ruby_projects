#!/usr/bin/env ruby
# frozen_string_literal: true

def merge(array, start, mid, last)
  x = mid - start + 1
  y = last - mid
  one = []
  (start..mid).each do |i|
    one << array[i]
  end
  two = []
  (mid + 1..last).each do |i|
    two << array[i]
  end
  i = 0
  j = 0
  k = start
  while i < x && j < y
    if one[i] <= two[j]
      array[k] = one[i]
      k += 1
      i += 1
    else
      array[k] = two[j]
      k += 1
      j += 1
    end
  end
  while i < x
    array[k] = one[i]
    k += 1
    i += 1
  end
  while j < y
    array[k] = two[j]
    k += 1
    j += 1
  end
end

def devide(array, start, last)
  return if start >= last

  mid = (start + last) / 2
  devide(array, start, mid)
  devide(array, mid + 1, last)
  merge(array, start, mid, last)
end

myarray = [8, 3, 1, 7, 4, 5, 2, 6]

devide(myarray, 0, 7)
p myarray
