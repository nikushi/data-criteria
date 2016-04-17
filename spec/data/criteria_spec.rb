require 'spec_helper'

describe Data::Criteria do
  describe "#match_all?" do
    subject { described_class.new(opts).match_all?(resource) }
    let(:resource) {
      {
        id: 1,
        name: "taro",
        city: 'Tokyo',
        age: 18,
        student: true,
        car: nil,
        last_loggined_at: Time.at(1460000005),
        money: 15_000,
        doing: "fooo",
        father: {
          id: 10,
          name: "gansaku",
          age: 41,
        }
      }
    }
    context 'multi condition matching' do
      let(:opts) {
        {
          name: ["taro", "sae"], # find user whose name is taro or sae, AND
          city: "Tokyo",         # find user who lives in Tokyo, AND
          age: "<= 18",          # find user whose age is eq or lt 18
          student: true,         # find user is a student, AND
          last_loggined_at: Time.at(1460000000)..Time.at(1460000010), # find user who loggined within the time range, AND
          money: proc{|actual| actual > 10_000 or actual < 500 }, # find user who has over 10,000 or less than 500, AND
          doing: /foo/,          # find user who does like /foo/
        }
      }
      it "matches" do
        should eq true
      end
    end

    context 'match with values within nested hash' do
      let(:opts) {
        {
          name: ["taro", "sae"], # find user whose name is taro or sae, AND
          city: "Tokyo",         # find user who lives in Tokyo, AND
          father: {              # find user whose father's name is gansaku and agen is eq or gt 40
            name: 'gansaku',
            age: '>= 40',
          }
        }
      }
      it "matches" do
        should eq true
      end
    end
  end
end
