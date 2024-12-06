# frozen_string_literal: true

# This class creates a node for a binary search tree
# It also contains a method to insert a new node into the tree
# and methods to display the tree in a readable format
class Node
  attr_accessor :left, :right, :parent, :value

  def initialize(data)
    @value = data
  end

  def insert(data)
    if data < @value
      if left.nil?
        self.left = Node.new(data)
        left.parent = self
      else
        left.insert(data)
      end
    elsif data > @value
      if right.nil?
        self.right = Node.new(data)
        right.parent = self
      else
        right.insert(data)
      end
    end
  end

  def to_s
    left_node_value = left.nil? ? '' : left.value
    right_node_value = right.nil? ? '' : right.value
    parent_value = parent.nil? ? '' : parent.value
    "(#{left_node_value} <= (#{value}) => #{right_node_value}) => #{parent_value}"
  end
end

# This class creates a binary search tree from an array
# It also contains methods to search for an item in the tree
# using breadth first search, depth first search and dfs_rec
class Tree
  attr_accessor :value

  def initialize(array)
    @data = array
    my_tree
  end

  def my_tree
    mid_index = (@data.length - 1) / 2
    @root_node = Node.new(@data[mid_index])
    @data.each { |x| @root_node.insert(x) }
  end

  def breadth_first_search(item)
    staging_array = []
    staging_array << @root_node
    while staging_array.length >= 1
      node = staging_array.shift
      return node if node.value == item

      staging_array << node.left unless node.left.nil?
      staging_array << node.right unless node.right.nil?

    end
    nil
  end

  def depth_first_search(item)
    staging_array = []
    staging_array << @root_node
    while staging_array.length >= 1
      node = staging_array.pop
      return node if node.value == item

      staging_array << node.right unless node.right.nil?
      staging_array << node.left unless node.left.nil?

    end
    nil
  end

  def dfs_rec(item, node = @root_node)
    holder = node
    return holder if holder.value == item

    dfs_rec(item, holder.left) unless holder.left.nil?
    dfs_rec(item, holder.right) unless holder.right.nil?
  end
end
