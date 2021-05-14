require_relative '../enumerable_methods_ruby'

array_test = [2,0,2,1]
hash_test = { 'key1' => 1, 'key2' => 2 }
range_test = (1..5)
symbol_test = [:sym1, :sym2]
path_test = ["document", "memes", "doge"]

describe Enumerable do
    describe '#my_each' do
        it "returns the same class when no block was given" do
            expect(array_test.my_each.class).to eql array_test.each.class  
        end
        it "returns when array was given" do
            expect(array_test.my_each do |i| end).to eql (array_test.each do |i| end)
        end
        it "returns when hash was given" do
            expect(hash_test.my_each do |key, value| end).to eql (hash_test.each do |key, value| end) 
        end
    end

    describe '#my_each_with_index' do
        it "returns the same class when no block was given" do
            expect(array_test.my_each_with_index.class).to eql array_test.each_with_index.class  
        end
        it "returns when array was given" do
            expect(array_test.my_each_with_index do |i| end).to eql (array_test.each_with_index do |i| end)
        end
        it "returns when hash was given" do
          expect(hash_test.my_each_with_index do |key, value| end).to eql (hash_test.each_with_index do |key, value| end) 
        end
    end

    describe '#my_select' do
        it "returns the same class when no block was given" do
            expect(array_test.my_select.class).to eql array_test.select.class  
        end
        it "returns only selected values when array was given" do
            expect(array_test.my_select(&:odd?)).to eql (array_test.select(&:odd?))
        end
        it "returns only selected value when range was given" do
          expect(range_test.my_select(&:even?)).to eql (range_test.select(&:even?)) 
        end
        it "returns only selected value when symbol was given" do
            expect(symbol_test.my_select { |i| i == :sym1 }).to eql (symbol_test.select { |i| i == :sym1 }) 
        end
    end

    describe '#my_all' do
        it "returns the same class when no block was given" do
            expect(array_test.my_all?.class).to eql (array_test.all?.class)
        end
        it "returns true when array was given and the condition was accomplished" do
            expect(array_test.my_all? { |i| i > 0 }).to eql (array_test.all? { |i| i > 0 })
        end
        it "returns false when nil was given" do
            expect(array_test.push(nil).my_all?).to eql (array_test.push(nil).all?)
        end
        it "returns true when all data types was the same" do
            expect(array_test.my_all?(Numeric)).to eql (array_test.all?(Numeric))
        end
        it "returns true when all words accomplished the regular expression" do
            expect(path_test.my_all?(/something/)).to eql (path_test.all?(/something/))
        end
    end

    describe '#my_any' do
        it "returns the same class when no block was given" do
            expect(array_test.my_any?.class).to eql (array_test.any?.class)
        end
        it "returns true when array at least one condition was accomplished" do
            expect(array_test.my_any? { |i| i > 0 }).to eql (array_test.any? { |i| i > 0 })
        end
        it "returns false when nil was given" do
            expect(array_test.push(nil).my_any?).to eql (array_test.push(nil).any?)
        end
        it "returns true when at least one was accomplished using the regular expression" do
            expect(path_test.my_any?(/something/)).to eql (path_test.any?(/something/))
        end
    end

    describe '#my_none' do
        it "returns the same class when no block was given" do
            expect(array_test.my_none?.class).to eql (array_test.none?.class)
        end
        it "returns true when array if block doesn't return true for each one element" do
            expect(array_test.my_none? { |i| i > 0 }).to eql (array_test.none? { |i| i > 0 })
        end
        it "returns true when none was accomplished using the regular expression" do
            expect(path_test.my_none?(/something/)).to eql (path_test.none?(/something/))
        end
        it "returns true when block doesn't return true for each one" do
            expect(path_test.my_none? { |name| name.length > 0 }).to eql (path_test.none? { |name| name.length > 0 })
        end
    end

    describe '#my_map' do
        it "returns the same class when no block was given" do
            expect(array_test.my_map.class).to eql (array_test.map.class)
        end
        it "returns transformed array when array was given" do
            expect(array_test.compact.my_map { |i| i**2 }).to eql (array_test.compact.map { |i| i**2 })
        end
        it "returns transformed range when range was given" do
          expect(range_test.my_map { |i| i * 2 }).to eql (range_test.map { |i| i * 2 }) 
        end
    end

    describe '#my_count' do
        it "returns the same class when no block was given" do
            expect(array_test.my_count.class).to eql (array_test.count.class)
        end
        it "returns new array with different values when array was given" do
            expect(array_test.compact.my_count { |i| i**2 }).to eql (array_test.compact.count { |i| i**2 })
        end
        it "returns new array with different when range was given" do
          expect(range_test.my_count { |i| i * 2 }).to eql (range_test.count { |i| i * 2 }) 
        end
        it "returns new array when hash was given" do
            expect(hash_test.my_count do |key, value| end).to eql (hash_test.count do |key, value| end) 
        end
    end

    describe '#my_inject' do
        it "returns a value when range was given" do
          expect(range_test.my_inject { |i| i * 2 }).to eql (range_test.inject { |i| i * 2 }) 
        end
    end

    describe '#multiply_els' do
        it "returns multiplied values when range was given" do
          expect(multiply_els(array_test.compact)).to eql (0)
        end
    end
end