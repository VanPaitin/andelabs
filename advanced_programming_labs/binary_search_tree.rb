class Node
  attr_accessor :left, :right, :parent, :value

  def initialize(data)
    @value = data
  end

  def insert(data)
    if data < @value
      if self.left == nil
        self.left = Node.new(data)
        self.left.parent = self
      else
        self.left.insert(data)
      end
    elsif data > @value
      if self.right == nil
        self.right = Node.new(data)
        self.right.parent = self
      else
        self.right.insert(data)
      end
    end
  end

  def to_s
    left_node_value = self.left.nil? ? "" : self.left.value
    right_node_value = self.right.nil? ? "" : self.right.value
    parent_value = self.parent.nil? ? "" : self.parent.value
    "(#{left_node_value} <= (#{self.value}) => #{right_node_value}) => #{parent_value}"
  end
end


class Tree
  attr_accessor :value

  def initialize(array)
    @data = array
    my_tree
  end

  def my_tree
    mid_index = (@data.length - 1)/2
    @root_node = Node.new(@data[mid_index])
    @data.each { |x| @root_node.insert(x)}
  end

  def breadth_first_search(item)
    staging_array = []
    staging_array << @root_node
    while staging_array.length >= 1
      node = staging_array.shift
      if node.value == item
        return node
      else
        staging_array << node.left unless node.left.nil?
        staging_array << node.right unless node.right.nil?
      end
    end
    nil
  end

  def depth_first_search(item)
    staging_array = []
    staging_array << @root_node
    while staging_array.length >= 1
      node = staging_array.pop
      if node.value == item
        return node
      else
        staging_array << node.right unless node.right.nil?
        staging_array << node.left unless node.left.nil?
      end
    end
    nil
  end

  def dfs_rec(item,node = @root_node)
    holder = node
    if holder.value == item
      return holder
    else
      dfs_rec(item,holder.left) unless holder.left.nil?
      dfs_rec(item,holder.right) unless holder.right.nil?
    end
  end
end
