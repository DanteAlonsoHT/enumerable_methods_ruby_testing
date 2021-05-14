# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop: disable Lint/ToEnumArguments

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    to_a.length.times do |i|
      yield to_a[i]
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    to_a.length.times do |i|
      yield to_a[i], i
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_array = []
    to_a.my_each do |i|
      new_array.push(i) if yield i
    end
    new_array
  end

  def my_all?(param = nil)
    if !block_given? && param.nil?
      to_a.my_each { |i| return false if i == false || i.nil? }
    elsif !block_given? && param.is_a?(Class)
      to_a.my_each { |i| return false unless [i.class, i.class.superclass].include?(param) }
    elsif !block_given? && (param.is_a? Regexp)
      to_a.my_each { |i| return false unless i.match(param) }
    elsif !block_given? && !param.nil?
      to_a.my_each { |i| return false unless i == param }
    elsif block_given?
      to_a.my_each { |i| return false unless yield i }
    end
    true
  end

  def my_any?(param = nil)
    if !block_given? && param.nil?
      to_a.my_each { |i| return true if i }
      return false
    elsif param.is_a?(Class)
      to_a.my_each { |i| return true if [i.class, i.class.superclass].include?(param) }
    elsif param.is_a?(Regexp)
      to_a.my_each { |i| return true if i.match(param) }
    elsif !block_given? && !param.nil?
      to_a.my_each { |i| return true if i == param }
    else
      to_a.my_each { |i| return true if yield i }
    end
    false
  end

  def my_none?(param = nil)
    if !block_given? && param.nil?
      to_a.my_each do |i|
        return false if !(i.nil? || i == false) && (i == true || !i.nil?)
      end
      return true
    elsif !block_given? && param.is_a?(Class)
      to_a.my_each { |i| return false if i.instance_of?(param) }
      return true
    elsif !block_given? && param.instance_of?(Regexp)
      to_a.my_each { |i| return false if i.match(param) }
      return true
    elsif !block_given? && !param.nil?
      to_a.my_each { |i| return false if i == param }
    elsif block_given? && param.instance_of?(Range)
      to_a.my_each { |i| return false if yield i }
      return true
    else
      to_a.my_each { |i| return false if yield i }
    end
    true
  end

  def my_count(param = nil)
    counter = 0
    if block_given?
      to_a.my_each { |i| counter += 1 if yield i }
    elsif !block_given? && param.nil?
      counter = to_a.length
    else
      to_a.my_each { |i| counter += 1 if i == param }.length
    end
    counter
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?

    new_array = []
    if proc.nil?
      to_a.my_each { |i| new_array.push(yield(i)) }
    else
      to_a.my_each { |i| new_array.push(proc.call(i)) }
    end
    new_array
  end

  def my_inject(*param)
    collection = is_a?(Range) ? to_a : self

    reduce = param[0] if param[0].is_a?(Integer)
    operator = param[0].is_a?(Symbol) ? param[0] : param[1]

    if operator
      collection.my_each { |i| reduce = reduce ? reduce.send(operator, i) : i }
      return reduce
    end
    collection.my_each { |i| reduce = reduce ? yield(reduce, i) : i }
    reduce
  end
end

def multiply_els(array)
  result = proc { |product, num| product * num }
  array.my_inject(&result)
end

# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop: enable Lint/ToEnumArguments
