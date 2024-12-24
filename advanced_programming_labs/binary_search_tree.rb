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

  def delete(data) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength
    if value == data
      # If there are no children, simply delete
      if left.nil? && right.nil?
        if parent.left == self
          parent.left = nil
        else
          parent.right = nil
        end
      elsif left.nil? # If there is only the right child, replace self with it
        if parent.left == self
          parent.left = right
        else
          parent.right = right
        end
        right.parent = parent
      elsif right.nil? # If there is only the left child, replace self with it
        if parent.left == self
          parent.left = left
        else
          parent.right = left
        end
        left.parent = parent
      else # If there are two children
        node = yank_successor_node
        if parent.left == self
          parent.left = node
        else
          parent.right = node
        end
        node.left = left
        left.parent = node
        if right != node
          node.right = right
          right.parent = node
        end
      end
    elsif value < data
      left&.delete(data)
    else
      right&.delete(data)
    end
  end

  def to_s
    left_node_value = left.nil? ? '' : left.value
    right_node_value = right.nil? ? '' : right.value
    parent_value = parent.nil? ? '' : parent.value
    "(#{left_node_value} <= (#{value}) => #{right_node_value}) => #{parent_value}"
  end

  def yank_successor_node
    raise ArgumentError, 'No right child' if right.nil?

    current_node = right

    # Find the leftmost node in the right subtree
    current_node = current_node.left while current_node.left

    # Remove the successor node from the tree
    if current_node.parent.left == current_node
      # Successor node is the left child of its parent
      current_node.parent.left = current_node.right
    else
      # Successor node is the immediate right child of the node to be deleted
      current_node.parent.right = current_node.right
    end
    # Update the parent reference of the right child, if it exists
    current_node.right.parent = current_node.parent if current_node.right

    current_node
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

  def delete(data) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    root = @root_node
    if root.value == data
      if root.left.nil? && root.right.nil?
        # Case: Root node has no children
        @root_node = nil
      elsif root.left.nil?
        # Case: Root node has only a right child
        @root_node = @root_node.right
        @root_node.parent = nil
      elsif root.right.nil?
        # Case: Root node has only a left child
        @root_node = @root_node.left
        @root_node.parent = nil
      else
        # Case: Root node has two children
        node = @root_node.yank_successor_node

        # Update left child
        node.left = @root_node.left
        @root_node.left.parent = node

        # Update right child if the successor is not the immediate right child
        if @root_node.right != node
          node.right = @root_node.right
          node.right.parent = node
        end
        # Update root node
        @root_node = node
        @root_node.parent = nil
      end
    elsif data < root.value
      root.left&.delete(data)
    else
      root.right&.delete(data)
    end
  end
end
