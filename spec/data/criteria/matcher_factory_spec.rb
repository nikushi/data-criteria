require 'spec_helper'

describe Data::Criteria::MatcherFactory do
  describe '.create' do
    subject { described_class.create(expected) }
    let(:expected) { 'taro' }
    it "creates a matcher" do
      should be_a Data::Criteria::EqMatcher
    end
  end
end
