class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class BST
  def initialize
    @root = nil
  end

  def insert(data, node = @root)
    if node.nil?
      if @root.nil?
        @root = Node.new(data)
        return @root
      end
      node = Node.new(data)
      return node
    end
    if node.data>data
      node.left = insert(data, node.left)
    else
      node.right = insert(data, node.right)
    end
    node
  end

  def find(data)
    temp = @root
    prev = @root
    if data==@root.data
      return nil, temp
    end
    while temp!=nil
      if temp.data==data
        return prev, temp
      end
      if temp.data<data
        prev = temp
        temp = temp.right
      else
        prev = temp
        temp = temp.left
      end
    end
    return nil, nil
  end

  def del(node = @root, val)
    return node if node.nil?

    if val < node.data
      node.left = del(node.left, val)
    elsif val > node.data
      node.right = del(node.right, val)
    else
      if node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      end
      node.data = min(node.right).data
      node.right = del(node.right, node.data)
    end
    node
  end

  def min(root = @root)
    cur = root
    while cur.left
      cur = cur.left
    end
    return cur
  end

  def max(root = @root)
    cur = root
    while cur.right
      cur = cur.right
    end
    return cur
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def build_tree(array)
    @root = build(array)
  end

  def build(array, root = @root)
    return nil if array.empty?
    mid = (array.length/2).to_i
    root = Node.new(array[mid])
    root.left = build(array[0...(mid)])
    root.right = build(array[(mid+1)..-1])
    return root
  end

end

tree = BST.new
tree.insert(4)
tree.insert(6)
tree.insert(7)
tree.insert(5)
tree.insert(2)
tree.insert(3)
tree.insert(1)
# array = [5,3,6,2,4,7]
# array = array.sort.uniq
# tree.build_tree(array)

tree.pretty_print()
# tree.del(3)
# tree.pretty_print()
# prev, cur = tree.find(7)
# puts prev.data
# puts cur.data
