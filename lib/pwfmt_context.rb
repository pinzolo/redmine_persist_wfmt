class PwfmtContext
  def self.field
    Thread.current[:pwfmt_field]
  end

  def self.field=(field)
    Thread.current[:pwfmt_field] = field
  end

  def self.format
    Thread.current[:pwfmt_format]
  end

  def self.format=(format)
    Thread.current[:pwfmt_format] = format
  end
end
