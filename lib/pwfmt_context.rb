module Pwfmt
  # Context is thread local storage for this plugin
  class Context
    class << self
      def formats
        Thread.current[:pwfmt_formats]
      end

      def formats=(formats)
        Thread.current[:pwfmt_formats] = formats
      end

      def reserved_format_for(field)
        Thread.current[:pwfmt_reserved_format][field] if Thread.current[:pwfmt_reserved_format]
      end

      def reserve_format(field, text)
        return unless text.respond_to?(:wiki_format)

        Thread.current[:pwfmt_reserved_format] ||= {}
        Thread.current[:pwfmt_reserved_format][field] = text.wiki_format
      end

      def clear
        self.formats = nil
        Thread.current[:pwfmt_reserved_format] = nil
      end

      def format_for?(key)
        formats.present? && formats.key?(key)
      end

      def format_for(key)
        formats[key] if format_for?(key)
      end
    end
  end
end
