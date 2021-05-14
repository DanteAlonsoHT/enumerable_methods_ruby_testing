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
        it "returns when array was given" do
            expect(array_test.my_select(&:odd?)).to eql (array_test.select(&:odd?))
        end
        it "returns when range was given" do
          expect(range_test.my_select(&:even?)).to eql (range_test.select(&:even?)) 
        end
        it "returns when symbol was given" do
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
end