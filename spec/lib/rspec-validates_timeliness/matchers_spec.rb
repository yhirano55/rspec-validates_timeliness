require 'spec_helper'

describe RSpec::ValidatesTimeliness::Matchers do
  describe '#validates_timeliness_of' do
    before do
      class DummyModel
        include RSpec::ValidatesTimeliness::Matchers
      end
    end

    let(:model) { DummyModel.new }
    let(:attr_name) { :one }

    subject { model.validates_timeliness_of(attr_name) }

    it { is_expected.to be_kind_of(RSpec::ValidatesTimeliness::Matchers::ValidationMatcher) }
  end
end
