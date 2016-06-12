require 'spec_helper'

class ValidatesDate
  include ActiveModel::Model

  attr_reader :date_of_birth, :date_of_start, :date_of_finish, :date_of_expiry

  validates_date :date_of_birth, is_at: lambda { Date.current }
  validates_date :date_of_start, after: lambda { 1.week.ago }, before: lambda { 1.week.since }
  validates_date :date_of_finish, on_or_after: lambda { 1.year.ago }, on_or_before: lambda { 1.year.since }
  validates_date :date_of_expiry, between: [3.days.ago, 3.days.since]
end

describe ValidatesDate do
  it { is_expected.to validates_date(:date_of_birth).is_at { Date.current } }
  it { is_expected.to validates_date(:date_of_start).after { 1.week.ago }.before { 1.week.since } }
  it { is_expected.to validates_date(:date_of_finish).on_or_after { 1.year.ago }.on_or_before { 1.year.since } }
  it { is_expected.to validates_date(:date_of_expiry).between([3.days.ago, 3.days.since]) }
end
