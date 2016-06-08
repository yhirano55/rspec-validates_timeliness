require 'spec_helper'

class ValidatesTime
  include ActiveModel::Model

  attr_reader :started_at, :finished_at, :created_at, :updated_at

  validates_time :started_at, is_at: '9:00am'
  validates_time :finished_at, after: '11:00am', before: '1:00pm'
  validates_time :created_at, on_or_after: '6:00am', on_or_before: '8:00am'
  validates_time :updated_at, between: ['10:00am', '5:00pm']
end

describe ValidatesTime do
  it { is_expected.to validates_time(:started_at).is_at('9:00am') }
  it { is_expected.to validates_time(:finished_at).after('11:00am').before('1:00pm') }
  it { is_expected.to validates_time(:created_at).on_or_after('6:00am').on_or_before('8:00am') }
  it { is_expected.to validates_time(:updated_at).between(['10:00am', '5:00pm']) }
end
