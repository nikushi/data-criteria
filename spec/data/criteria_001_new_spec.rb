require 'spec_helper'

describe Data::Criteria do
  describe '.new' do
    subject { described_class.new(opts) }
    let(:opts) { { name: 'taro' } }
    it "build hash filter parameter to filter objects and return a criteria" do
      should be_a described_class
    end
  end
end
