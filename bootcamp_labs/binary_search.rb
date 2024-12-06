# frozen_string_literal: true

# add methods to the Array class
class Array
  def to_twenty
    (1..20).to_a
  end

  def to_forty
    to_twenty.map { |i| 2 * i }
  end

  def to_one_thousand
    (1..100).to_a.map { |j| 10 * j }
  end

  def search(num) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    result = {}
    result[:length] = length
    count = 0
    first_index = 0
    last_index = length - 1
    while first_index < last_index
      mid_index = (first_index + last_index) / 2

      if num == self[first_index]
        result[:count] = count
        result[:index] = first_index
        return result
      elsif num == self[mid_index]
        result[:count] = count
        result[:index] = mid_index
        return result
      elsif num == self[last_index]
        result[:count] = count
        result[:index] = last_index
        return result
      else
        count += 1
        if num < self[mid_index]
          first_index += 1
          last_index = mid_index - 1
        else
          last_index -= 1
          first_index = mid_index + 1
        end
      end
    end
    result[:count] = count
    result[:index] = -1
    result
  end
end
