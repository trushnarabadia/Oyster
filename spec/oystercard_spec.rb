require_relative '../lib/oystercard'

describe Oystercard do

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it { is_expected.to respond_to(:deduct) }

  it { is_expected.to respond_to(:in_journey?) }

  it { is_expected.to respond_to(:touch_in) }

  it { is_expected.to respond_to(:touch_out) }

  it "has a balance of 0 upon initialization" do
    expect(subject.balance).to eq 0
  end

  it "is initially not in a journey" do
    expect(subject).not_to be_in_journey
  end

  describe "#top_up" do

    it "tops up the balance with the argument balance provided" do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by 5
    end

    it "should fail if balance is more than £90" do
      limit = Oystercard::LIMIT
      subject.top_up(limit)
      expect { subject.top_up(1)}.to raise_error "£#{limit} limit exceeded"
    end
  end
  describe "#deduct" do

    it "deducts the balance by value amount" do
      subject.top_up(25)
      expect{ subject.deduct(10) }.to change{ subject.balance }.by -10
    end
  end
  describe "#touch_in" do

    it "shouldn't let you touch in if balance is less than £1" do
    #  minimum_balance = Oystercard::MINIMUM
      expect{ subject.touch_in }.to raise_error "Not enough balance"
    end

    it "returns true if the card has been touched in" do
      subject.top_up(20)
      expect(subject.touch_in).to eq true
    end
  end
  describe "#touch_out" do

    it "returns false if the card has been touched out" do
      expect(subject.touch_out).to eq false
    end

    it "deducts minimum fare upon touching out" do
      minimum = Oystercard::MINIMUM
      subject.top_up(25)
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by -minimum
    end
  end
end
