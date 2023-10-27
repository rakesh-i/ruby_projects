# frozen_string_literal: true

class Node
  attr_accessor :data, :next

  def initialize(data)
    @data = data
    @next = nil
  end
end

class LinkedList
  def initialize
    @head = nil
    @count = -1
    @tail = nil
  end

  def append(data)
    new_node = Node.new(data)
    @count += 1
    if @head.nil?
      @head = new_node
    else
      @tail.next = new_node
    end
    @tail = new_node
  end

  def prepend(data)
    new_node = Node.new(data)
    @count += 1
    new_node.next = @head
    @head = new_node
  end

  def insert_at(data, idx)
    if idx.zero?
      prepend(data)
      return
    end
    if idx > @count
      append(data)
      return
    end
    new_node = Node.new(data)
    temp = @head
    cur = 0
    while cur != idx - 1
      temp = temp.next
      cur += 1
    end
    temp1 = temp.next
    temp.next = new_node
    new_node.next = temp1
    @count += 1
    nil
  end

  def contains?(data)
    temp = @head
    while temp
      return true if temp.data == data

      temp = temp.next
    end
    false
  end

  def at(idx)
    temp = @head
    return 'Out of range' if idx < 1 || idx > @count

    i = 0
    while i != idx
      temp = temp.next
      i += 1
    end
    temp.data
  end

  def find(data)
    temp = @head
    itr = 0
    while temp
      return itr if temp.data == data

      itr += 1
      temp = temp.next
    end
    'Out of range'
  end

  def remove_at(n)
    if n > @count || n.negative?
      puts 'Out of range'
    else
      temp = @head
      if n.zero?
        @head = temp.next
        @tail = nil
        @count -= 1
        puts @count
        return
      end
      cur = 0
      while cur != n - 1
        temp = temp.next
        cur += 1
      end
      @tail = temp if n == @count
      temp1 = temp.next.next
      temp.next = temp1
      @count -= 1
    end
    nil
  end

  def pop
    return unless @count >= 0

    remove_at(@count)
  end

  def tail
    return unless @tail

    @tail.data
  end

  def head
    return unless @head

    @head.data
  end

  def to_s
    temp = @head
    string = ''
    while temp
      string += "#{temp.data}->"
      temp = temp.next
    end
    string += 'nil'
    string
  end
end

list = LinkedList.new

list.append(1)
list.append(2)
list.append(3)
list.append(5)
list.prepend(0)
list.append(6)
list.append(7)
list.insert_at(-1, 0)
list.insert_at(4, 5)
list.insert_at(8, 34)
list.pop

puts list
