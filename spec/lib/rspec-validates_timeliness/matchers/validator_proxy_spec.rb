require 'spec_helper'

describe RSpec::ValidatesTimeliness::Matchers::ValidatorProxy do
  before do
    class DummyModel
      include ActiveModel::Model
      attr_reader :one
      validates :one, presence: true
    end
  end

  let(:model) { DummyModel.new }
  let(:attr_name) { :one }
  let(:proxy) { described_class.new(model, attr_name) }

  describe '#valid?' do
    subject { proxy.valid?(value) }

    context 'with valid' do
      let(:value) { true }

      it { is_expected.to be_truthy }
    end

    context 'with invalid' do
      let(:value) { nil }

      it { is_expected.to be_falsey }
    end
  end

  describe '#invalid?' do
    subject { proxy.invalid?(value) }

    context 'with invalid' do
      let(:value) { nil }

      it { is_expected.to be_truthy }
    end

    context 'with valid' do
      let(:value) { true }

      it { is_expected.to be_falsey }
    end
  end
end
