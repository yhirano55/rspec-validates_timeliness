require 'spec_helper'

describe RSpec::ValidatesTimeliness::Matchers do
  before do
    class DummyModel
      include RSpec::ValidatesTimeliness::Matchers
    end
  end

  let(:model) { DummyModel.new }
  let(:attr_name) { :one }

  %i(validates_date validates_datetime validates_time).each do |matcher_name|
    describe "##{matcher_name}" do
      let(:type) { "RSpec::ValidatesTimeliness::Matchers::#{matcher_name.to_s.classify}Matcher".constantize }

      subject { model.try(matcher_name, attr_name) }

      it { is_expected.to be_kind_of(type) }
    end
  end
end
