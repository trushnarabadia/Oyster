require_relative '../lib/oystercard'

describe Oystercard do

  let(:station){ double :station }

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it { is_expected.to respond_to(:in_journey?) }

  it { is_expected.to respond_to(:touch_in).with(1).argument }

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
      subject.top_up(Oystercard::LIMIT)
      expect { subject.top_up(1)}.to raise_error "£#{Oystercard::LIMIT} limit exceeded"
    end
  end

  describe "#touch_in" do
    it "shouldn't let you touch in if balance is less than £1" do
    #  minimum_balance = Oystercard::MINIMUM
      expect{ subject.touch_in(station) }.to raise_error "Not enough balance"
    end

    it "saves the entry station when we touch in" do
      subject.top_up(Oystercard::LIMIT)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
      
  end
  describe "#touch_out" do

    it "deducts minimum fare upon touching out" do
      minimum = Oystercard::MINIMUM
      subject.top_up(25)
      subject.touch_in(station)
      expect { subject.touch_out }.to change { subject.balance }.by -minimum
    end

    it "changes the entry station to nil upon touching out" do
      subject.top_up(Oystercard::LIMIT)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end

  end
end
