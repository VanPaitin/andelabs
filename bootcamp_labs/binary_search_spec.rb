# frozen_string_literal: true

require_relative 'binary_search'

RSpec.describe 'Binary Search Tests' do
  context 'Binary Search to traverse an ordered list, effectively' do
    one_to_twenty = [].to_twenty
    two_to_forty = [].to_forty
    ten_to_one_thousand = [].to_one_thousand

    context 'Populate the arrays with valid content' do
      it 'should create an array from 1 to 20, with intervals of 1' do
        length = one_to_twenty.length
        expect(one_to_twenty[0]).to eq 1
        expect(one_to_twenty[19]).to eq 20
        expect(length).to eq 20

        (length - 1).times do |i|
          expect(one_to_twenty[i + 1] - one_to_twenty[i]).to eq 1
        end
      end

      it 'should create an array from 2 to 40, with intervals of 2' do
        length = two_to_forty.length
        expect(two_to_forty[0]).to eq 2
        expect(two_to_forty[19]).to eq 40
        expect(length).to eq 20

        (length - 1).times do |i|
          expect(two_to_forty[i + 1] - two_to_forty[i]).to eq 2
        end
      end

      it 'should create an array from 10 to 1000, with intervals of 10' do
        length = ten_to_one_thousand.length
        expect(ten_to_one_thousand[0]).to eq 10
        expect(ten_to_one_thousand[99]).to eq 1000
        expect(length).to eq 100

        (length - 1).times do |i|
          expect(ten_to_one_thousand[i + 1] - ten_to_one_thousand[i]).to eq 10
        end
      end
    end

    context 'Get the index of the item with an expected number of loops in array [1, 2 . . . 20]' do
      it 'should return {count: /* <= 4 */, index: 15} for 16' do
        result = one_to_twenty.search(16)
        expect(result[:count]).to be < 5
        expect(result[:index]).to eq 15
      end

      it 'should return {count: 1, index: 18} for 19' do
        result = one_to_twenty.search(19)
        expect(result[:count]).to be < 2
        expect(result[:index]).to eq 18
      end

      it 'should return {count: 0, index: 19} for 20' do
        result = one_to_twenty.search(20)
        expect(result[:count]).to eq 0
        expect(result[:index]).to eq 19
      end

      it 'should return {count: < /* array length */, index: -1} for 33' do
        result = one_to_twenty.search(33)
        expect(result[:count]).to be < result[:length]
        expect(result[:index]).to eq(-1)
      end
    end

    context 'Get the index of the item with an expected number of loops in array [2, 4 . . . 40]' do
      it 'should return {count: /* <= 4 */, index: 15} for 16' do
        result = two_to_forty.search(16)
        expect(result[:count]).to be < 5
        expect(result[:index]).to eq 7
      end

      it 'should return {count: 0, index: 9} for 20' do
        result = two_to_forty.search(20)
        expect(result[:count]).to eq 0
        expect(result[:index]).to eq 9
      end

      it 'should return {count: 0, index: 19} for 40' do
        result = two_to_forty.search(40)
        expect(result[:count]).to eq 0
        expect(result[:index]).to eq 19
      end

      it 'should return {count: < /* array length */, index: -1} for 33' do
        result = two_to_forty.search(33)
        expect(result[:count]).to be < result[:length]
        expect(result[:index]).to eq(-1)
      end
    end

    context 'Get the index of the item with an expected number of loops in array [10, 20 . . . 1000]' do
      it 'should return {count: /* <= 3 */, index: 3} for 40' do
        result = ten_to_one_thousand.search(40)
        expect(result[:count]).to be < 4
        expect(result[:index]).to eq 3
      end

      it 'should return {count: /* <= 5*/, index: 87} for 800' do
        result = ten_to_one_thousand.search(880)
        expect(result[:count]).to be < 6
        expect(result[:index]).to eq 87
      end

      it 'should return {count: < /* array length */, index: -1} for 10000' do
        result = ten_to_one_thousand.search(10_000)
        expect(result[:count]).to be < result[:length]
        expect(result[:index]).to eq(-1)
      end
    end
  end
end
