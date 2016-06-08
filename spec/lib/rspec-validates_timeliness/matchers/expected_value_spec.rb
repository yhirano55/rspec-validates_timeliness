require 'spec_helper'

describe RSpec::ValidatesTimeliness::Matchers::ExpectedValue do
  describe '#equal' do
    let(:result) { Date.current }
    let(:model) { described_class.new(result) }

    subject { model.equal }

    it { is_expected.to eq result }
  end

  describe '#over' do
    let(:model) { described_class.new(value) }

    subject { model.over }

    context 'value is kind of Date' do
      let(:value) { Date.current }
      let(:result) { value + 1.day }

      it 'returns value + 1.day (tomorrow)' do
        is_expected.to eq result
      end
    end

    context 'value is not kind of Date' do
      let(:value) { DateTime.current }
      let(:result) { value + 1.second }

      it 'returns value + 1.second' do
        is_expected.to eq result
      end
    end
  end

  describe '#under' do
    let(:model) { described_class.new(value) }

    subject { model.under }

    context 'value is kind of Date' do
      let(:value) { Date.current }
      let(:result) { value - 1.day }

      it 'returns value - 1.day (yesterday)' do
        is_expected.to eq result
      end
    end

    context 'value is not kind of Date' do
      let(:value) { DateTime.current }
      let(:result) { value - 1.second }

      it 'returns value - 1.second' do
        is_expected.to eq result
      end
    end
  end

  describe '#evaluate' do
    let(:model) { described_class.new(nil) }

    subject { model.send(:evaluate, value) }

    context 'velue is kind of Proc' do
      let(:value) { proc { Date.today } }

      it { is_expected.to eq value.call }
    end

    context 'value is kind of Time' do
      let(:value) { Time.now }

      it { is_expected.to eq value }
    end

    context 'value is kind of DateTime' do
      let(:value) { DateTime.current }

      it { is_expected.to eq value }
    end

    context 'value is kind of Date' do
      let(:value) { Date.current }

      it { is_expected.to eq value }
    end

    context 'value is kind of String' do
      let(:value) { '9:00am' }
      let(:result) { value.to_time }

      it { is_expected.to eq result }
    end

    context 'value is not kind of Proc, Time, DateTime, Date' do
      let(:value) { 12345 }

      it { is_expected.to be_nil }
    end
  end
end
