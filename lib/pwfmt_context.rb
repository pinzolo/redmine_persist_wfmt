module Pwfmt
  class Context
    def self.formats
      Thread.current[:pwfmt_formats]
    end

    def self.formats=(formats)
      Thread.current[:pwfmt_formats] = formats
    end

    def self.reserved_format(field)
      if Thread.current[:pwfmt_reserved_format]
        Thread.current[:pwfmt_reserved_format][field]
      end
    end

    def self.reserve_format(field, text)
      if text.try(:pwfmt)
        Thread.current[:pwfmt_reserved_format] ||= {}
        Thread.current[:pwfmt_reserved_format][field] = text.pwfmt.format
      end
    end

    def self.clear
      self.formats = nil
      Thread.current[:pwfmt_reserved_format] = nil
    end
  end
end
