require 'spec_helper'

class ValidatesDatetime
  include ActiveModel::Model

  attr_reader :started_at, :finished_at, :created_at, :updated_at

  validates_datetime :started_at, is_at: lambda { DateTime.current }
  validates_datetime :finished_at, after: lambda { 1.week.ago }, before: lambda { 1.week.since }
  validates_datetime :created_at, on_or_after: lambda { 1.year.ago }, on_or_before: lambda { 1.year.since }
  validates_datetime :updated_at, between: [DateTime.new(2008, 9, 1, 10, 5, 0), DateTime.new(2009, 4, 1, 0, 30, 0)]
end

describe ValidatesDatetime do
  it { is_expected.to validates_datetime(:started_at).is_at { DateTime.current } }
  it { is_expected.to validates_datetime(:finished_at).after { 1.week.ago }.before { 1.week.since } }
  it { is_expected.to validates_datetime(:created_at).on_or_after { 1.year.ago }.on_or_before { 1.year.since } }
  it { is_expected.to validates_datetime(:updated_at).between([DateTime.new(2008, 9, 1, 10, 5, 0), DateTime.new(2009, 4, 1, 0, 30, 0)]) }
end
