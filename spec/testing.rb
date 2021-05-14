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
end