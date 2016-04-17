require 'spec_helper'

describe Data::Criteria do
  describe '#add' do
    it '#add addes rules and can be chained' do
      criteria = described_class.new(name: 'taro').add(location: 'Tokyo').add(nickname: 'tabo')
      actual = {
        name: 'taro',
        location: 'Tokyo',
        nickname: 'tabo',
        status: 'sleeping',
      }
      expect(criteria.match_all?(actual)).to eq true
    end
  end
end


