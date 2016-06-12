module RSpec::ValidatesTimeliness
  module Matchers
    class ValidationMatcher
      attr_reader :description

      def initialize(attr_name)
        @attr_name = attr_name
        @options = {}
        @description = MessageBuilder.new(base_description)
      end

      def is_at(value = nil, &block)
        options[__method__] = block_given? ? block : value
        self
      end

      def after(value = nil, &block)
        options[__method__] = block_given? ? block : value
        self
      end

      def on_or_after(value = nil, &block)
        options[__method__] = block_given? ? block : value
        self
      end

      def before(value = nil, &block)
        options[__method__] = block_given? ? block : value
        self
      end

      def on_or_before(value = nil, &block)
        options[__method__] = block_given? ? block : value
        self
      end

      def between(value)
        case value
        when Array, Range
          options[:on_or_after] = value.first
          options[value.is_a?(Range) && value.exclude_end? ? :before : :on_or_before] = value.last
        end

        self
      end

      def matches?(subject)
        @subject = subject

        attribute_exist? && all_options_correct?
      end

      def failure_message
        "Expected #{description}"
      end

      def failure_message_when_negated
        "Did not expect #{description}"
      end

      private

      attr_reader :attr_name, :options, :subject, :type

      def base_description
        "validate that :#{attr_name} must be"
      end

      def attribute_exist?
        subject.respond_to?(attr_name)
      end

      def all_options_correct?
        options.compact.keys.all? do |option_name|
          send(:"#{option_name}_correct?")
        end
      end

      def run_correct
        Timecop.freeze
        yield
      ensure
        Timecop.return
      end

      def is_at_correct?
        run_correct do
          value = ExpectedValue.new(options[:is_at], type)
          description << "at #{value.equal}"
          valid?(value.equal) && invalid?(value.over) && invalid?(value.under)
        end
      end

      def after_correct?
        run_correct do
          value = ExpectedValue.new(options[:after], type)
          description << "after #{value.equal}"
          valid?(value.over) && invalid?(value.equal) && invalid?(value.under)
        end
      end

      def on_or_after_correct?
        run_correct do
          value = ExpectedValue.new(options[:on_or_after], type)
          description << "on or after #{value.equal}"
          valid?(value.equal) && valid?(value.over) && invalid?(value.under)
        end
      end

      def before_correct?
        run_correct do
          value = ExpectedValue.new(options[:before], type)
          description << "before #{value.equal}"
          valid?(value.under) && invalid?(value.equal) && invalid?(value.over)
        end
      end

      def on_or_before_correct?
        run_correct do
          value = ExpectedValue.new(options[:on_or_before], type)
          description << "on or before #{value.equal}"
          valid?(value.equal) && valid?(value.under) && invalid?(value.over)
        end
      end

      def validator_proxy
        @validator_proxy ||= ValidatorProxy.new(subject, attr_name)
      end

      def type
        fail NotImplementedError
      end

      delegate :valid?, to: :validator_proxy
      delegate :invalid?, to: :validator_proxy
    end
  end
end

