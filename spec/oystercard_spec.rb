require_relative '../lib/oystercard'

describe Oystercard do

  it "has a balance of 0 upon initialization" do
    expect(subject.balance).to eq 0
  end
  describe "#top_up" do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "tops up the balance with the argument balance provided" do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it "should fail if balance is more than £90" do
      limit = Oystercard::LIMIT
      subject.top_up(limit)
      expect { subject.top_up(1)}.to raise_error "£#{limit} limit exceeded"
    end
  end
  describe "#deduct" do
    it { is_expected.to respond_to(:deduct) }
    it "deducts the balance by value amount" do
      card = subject.top_up(25)
      card.deduct(10)
      expect(card.balance).to eq 15
    end
  end
end
