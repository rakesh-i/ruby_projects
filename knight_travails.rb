class Node
  attr_accessor :data, :ch1, :ch2, :ch3, :ch4, :ch5, :ch6, :ch7, :ch8
  def initialize(data)
    @data = [data[0], data[1]]
    @ch1=nil
    @ch2=nil
    @ch3=nil
    @ch4=nil
    @ch5=nil
    @ch6=nil
    @ch7=nil
    @ch8=nil

  end
end

class Knight
  def initialize
    @root
  end

  def knight_moves(queue, e)
    k = []
    flag = 0
    while !queue.empty?
      node = queue.shift
      cur = node.data
      # print "#{cur} "
      if e==cur
        flag = 1
        break
      end
      if cur[0]+2<8&&cur[1]+1<8
        #k.push([cur[0]+2, cur[1]+1])
        node.ch1 = Node.new([cur[0]+2, cur[1]+1])
        k.push(node.ch1)
      end
      if cur[0]+2<8&&cur[1]-1>=0
        #k.push([cur[0]+2, cur[1]-1])
        node.ch2 = Node.new([cur[0]+2, cur[1]-1])
        k.push(node.ch2)
      end
      if cur[0]+1<8&&cur[1]+2<8
        #k.push([cur[0]+1, cur[1]+2])
        node.ch3 = Node.new([cur[0]+1, cur[1]+2])
        k.push(node.ch3)
      end
      if cur[0]-1>=0&&cur[1]+2<8
        #k.push([cur[0]-1, cur[1]+2])
        node.ch4 = Node.new([cur[0]-1, cur[1]+2])
        k.push(node.ch4)
      end
      if cur[0]-2>=0&&cur[1]+1<8
        #k.push([cur[0]-2, cur[1]+1])
        node.ch5 = Node.new([cur[0]-2, cur[1]+1])
        k.push(node.ch5)
      end
      if cur[0]-2>=0&&cur[1]-1>=0
        #k.push([cur[0]-2, cur[1]-1])
        node.ch6 = Node.new([cur[0]-2, cur[1]-1])
        k.push(node.ch6)
      end
      if cur[0]-1>=0&&cur[1]-2>=0
        #k.push([cur[0]-1, cur[1]-2])
        node.ch7 = Node.new([cur[0]-1, cur[1]-2])
        k.push(node.ch7)
      end
      if cur[0]+1<8&&cur[1]-2>=0
        node.ch8 = Node.new([cur[0]+1, cur[1]-2])
        k.push(node.ch8)
      end
    end
    return k,flag
  end

  def helper(s,e)
    queue = []
    @root = Node.new(s)
    queue.push(@root)
    count = 0
    while !queue.empty?

      queue, flag = knight_moves(queue, e, )
      if flag==1
        break
      end
      count+=1
    end
    count
  end

  def trace(target, array, root=@root)
    if root.nil?
      return false
    end
    array.push(root.data)
    if(root.data==target)
      return true
    end
    return true if trace(target, array, root.ch1)
    return true if trace(target, array, root.ch2)
    return true if trace(target, array, root.ch3)
    return true if trace(target, array, root.ch4)
    return true if trace(target, array, root.ch5)
    return true if trace(target, array, root.ch6)
    return true if trace(target, array, root.ch7)
    return true if trace(target, array, root.ch8)
    array.pop
    return false
  end

end


# k = Knight.new

# k.helper([3,3],[0,0])

# array = []
# k.trace([0,0], array)
# p array
