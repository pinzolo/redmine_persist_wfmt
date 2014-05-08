module Pwfmt
  class Context
    def self.fields
      Thread.current[:pwfmt_fields]
    end

    def self.fields=(field)
      Thread.current[:pwfmt_fields] = field
    end

    def self.formats
      Thread.current[:pwfmt_formats]
    end

    def self.formats=(formats)
      Thread.current[:pwfmt_formats] = formats
    end

    def self.reserved_format
      Thread.current[:pwfmt_reserved_format]
    end

    def self.reserved_format=(format)
      Thread.current[:pwfmt_reserved_format] = format
    end

    def self.clear
      self.fields = nil
      self.formats = nil
      self.reserved_format = nil
    end
  end
end
