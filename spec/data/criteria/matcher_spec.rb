require 'spec_helper'

describe Data::Criteria::EqMatcher do
  subject { described_class.new(expected).call(actual) }
  let(:expected) { 'taro' }
  context 'match' do
    let(:actual) { 'taro' }
    it { should eq true }
  end
  context 'does not match' do
    let(:actual) { 'masa' }
    it { should eq false }
  end
end

describe Data::Criteria::InMatcher do
  subject { described_class.new(expected).call(actual) }
  context 'actual is one of expected' do
    let(:expected) { ['taro', 'masa'] }
    context 'match' do
      let(:actual) { 'masa' }
      it { should eq true }
    end
    context 'does not match' do
      let(:actual) { 'mami' }
      it { should eq false }
    end
  end
  context 'actual is included in expected range' do
    let(:expected) { 1..100 }
    context 'match' do
      let(:actual) { 50 }
      it { should eq true }
    end
    context 'does not match' do
      let(:actual) { -1 }
      it { should eq false }
    end
  end
end

describe Data::Criteria::RegexpMatcher do
  subject { described_class.new(expected).call(actual) }
  let(:expected) { /abc/ }
  context 'match' do
    let(:actual) { 'XabcDx' }
    it { should eq true }
  end
  context 'does not match' do
    let(:actual) { 'XYz' }
    it { should eq false }
  end
end

describe Data::Criteria::NumericComparisonMatcher do
  subject { described_class.new(expected).call(actual) }
  describe 'numeric comparison operator (>)' do
    let(:expected) { "> 0" }
    context 'match' do
      let(:actual) { 1 }
      it { should eq true }
    end
    context 'does not match' do
      let(:actual) { 0 }
      it { should eq false }
    end
    context 'does not match' do
      let(:actual) { -1.2 }
      it { should eq false }
    end
    context 'match(eval as string matcher)' do
      let(:actual) { "> 0" }
      it { should eq true }
    end
    context 'does not match(eval as string matcher)' do
      let(:actual) { "1 > 1" }
      it { should eq false }
    end
  end
  describe 'numeric comparison operator (>=)' do
    let(:expected) { ">=  0 " }
    context 'match' do
      let(:actual) { 1 }
      it { should eq true }
    end
    context 'does not match' do
      let(:actual) { 0 }
      it { should eq true }
    end
    context 'does not match' do
      let(:actual) { -1.2 }
      it { should eq false }
    end
  end
  describe 'numeric comparison operator (<)' do
    let(:expected) { " <  0" }
    context 'match' do
      let(:actual) { 1 }
      it { should eq false }
    end
    context 'does not match' do
      let(:actual) { 0 }
      it { should eq false }
    end
    context 'does not match' do
      let(:actual) { -1.2 }
      it { should eq true }
    end
  end
  describe 'numeric comparison operator (<=)' do
    let(:expected) { " <= 0" }
    context 'match' do
      let(:actual) { 1 }
      it { should eq false }
    end
    context 'does not match' do
      let(:actual) { 0 }
      it { should eq true }
    end
    context 'does not match' do
      let(:actual) { -1.2 }
      it { should eq true }
    end
  end
end
