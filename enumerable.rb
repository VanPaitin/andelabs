# All methods in this Enumerable module  can take a block except #my_map_with_proc
# => Methods like #my_count and #my_map_with_proc_block may or may not take a block
module Enumerable
  # => This is the normal Ruby 'each' enumerable method
  def my_each
    i = 0
    while i < length
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < length
      yield self[i], i
      i += 1
    end
  end

  def my_select
    new_arr = []	# => methods that return an array naturally start by opening a new array

    my_each { |el| new_arr << el if yield el }

    new_arr
  end

  def my_all?(&block)
    self == my_select(&block)
  end

  def my_none?(&block)
    myselect(&block).empty?
  end

  # => This method is rather involved
  def my_count(item = nil, &block)
    return length if item.nil? && !block_given?

    return my_select(&block).length if block_given?

    my_select { |el| el == item }.length
  end

  def my_map
    new_arr = []

    my_each { |el| new_arr << (yield el) }

    new_arr
  end

  def my_inject(memo = 0)
    my_each do |el|
      memo = yield memo, el
    end

    memo
  end

  # => just like #my_map, just that it uses a proc instead of a block
  def my_map_with_proc(procedure)
    new_arr = []

    my_each { |el| new_arr << procedure.call(el) }

    new_arr
  end

  def my_map_with_proc_block(procedure)
    new_arr = []

    my_each { |el| new_arr << procedure.call(el) }

    return new_arr unless block_given?

    latest_arr = []	# => It passes a block to the result of passing a proc to a method. It uses the #my_map algorithm

    new_arr.my_each { |el| latest_arr << (yield el) }

    latest_arr
  end
end

class Array
  include Enumerable
end

class Hash
  include Enumerable
end
