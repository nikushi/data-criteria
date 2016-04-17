require 'spec_helper'

describe Data::Criteria do
  describe 'add custom matcher from .new' do
    it 'can add proc as a custom filter' do
      criteria = described_class.new(
        age: proc{|actual| actual.odd? && actual >= 20},
      )
      actual = {
        name: 'taro',
        age: 19,
      }
      expect(criteria.match_all?(actual)).to eq false
    end
  end

  describe 'add custom matcher from #add' do
    it 'can add proc as a custom filter' do
      criteria = described_class.new.add(
        age: proc{|actual| actual.odd? && actual >= 20},
      )
      actual = {
        name: 'taro',
        age: 21,
      }
      expect(criteria.match_all?(actual)).to eq true
    end
  end
end
