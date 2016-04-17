describe Data::Criteria do
  describe "opts' keys can be either string or symbol" do
    subject { described_class.new(opts).match_all?(resource) }
    let(:resource) {
      {
        id: 1,
        name: "taro",
      }
    }
    let(:opts) {
      { "name" => "taro" }
    }
    it { should eq true }
  end

  describe "resource's key can be either string or symbol" do
    subject { described_class.new(opts).match_all?(resource) }
    let(:resource) {
      {
        "id" => 1,
        "name" => "taro",
      }
    }
    let(:opts) {
      { name: "taro" }
    }
    it { should eq true }
  end
end
 
