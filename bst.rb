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


  def build_tree(array, root = @root)
    return nil if array.empty?
    mid = (array.length/2).to_i
    if @root.nil?
      @root = Node.new(array[mid])
      root = @root
    else
      root = Node.new(array[mid])
    end
    root.left = build_tree(array[0...(mid)])
    root.right = build_tree(array[(mid+1)..-1])
    return root
  end

  def inorder(root = @root)
    if root.nil?
      return
    end
    inorder(root.left)
    puts root.data
    inorder(root.right)
  end

  def sorted(root = @root, array)
    if root.nil?
      return
    end
    sorted(root.left, array)
    array.push(root.data)
    sorted(root.right, array)
  end

  def preorder(root = @root)
    if root.nil?
      return
    end
    puts root.data
    preorder(root.left)
    preorder(root.right)
  end

  def postorder(root = @root)
    if root.nil?
      return
    end
    postorder(root.left)
    postorder(root.right)
    puts root.data
  end

  def levelorder(root=@root)
    return if root.nil?
    queue = []
    queue.push(root)
    while !queue.empty?
      cur = queue.shift
      puts cur.data
      if cur.left
        queue.push(cur.left)
      end
      if cur.right
        queue.push(cur.right)
      end
    end
  end

  def rebalance(root=@root)
    array = []
    sorted(root, array)
    p array
    @root = nil
    build_tree(array)
  end

  def balanced?(root = @root)
    if root.nil?
      return true
    end
    left_height = height(root.left)
    right_height = height(root.right)

    if (left_height-right_height).abs<=1 && balanced?(root.left) && balanced?(root.right)
      return true
    end
    return false
  end

  def height(root=@root)
    if root.nil?
      return 0
    end
    left = height(root.left)
    right = height(root.right)

    return [left, right].max+1
  end

end

tree = BST.new
array = Array.new(15){rand(1..100)}.sort.uniq
tree.build_tree(array)

tree.insert(123)
tree.insert(144)
tree.insert(355)
tree.insert(524)
tree.pretty_print
puts tree.balanced?
tree.rebalance
tree.pretty_print
puts tree.balanced?
puts "Preorder"
tree.preorder
puts "Inorder"
tree.inorder
puts "Postorder"
tree.postorder
