module RSpec::ValidatesTimeliness
  module Matchers
    class MessageBuilder
      def initialize(base_message)
        @base_message = base_message
        @option_messages = []
      end

      def full_message
        [base_message, option_message].join(' ')
      end

      alias to_s full_message

      def <<(text)
        option_messages << text
      end

      private

      attr_reader :base_message, :option_messages

      def option_message
        option_messages.join(' and ')
      end
    end
  end
end
