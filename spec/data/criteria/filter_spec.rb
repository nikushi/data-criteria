require 'spec_helper'

describe Data::Criteria::Filter do
  describe '.new' do
    subject { described_class.new(expected) }
    let(:expected) { 'taro' }
    it { should be_a described_class }
  end
end
