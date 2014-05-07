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
  end
end
