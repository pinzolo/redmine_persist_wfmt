class Pwfmt::Context
  def self.formats
    Thread.current[:pwfmt_formats]
  end

  def self.formats=(formats)
    Thread.current[:pwfmt_formats] = formats
  end

  def self.reserved_format_for(field)
    if Thread.current[:pwfmt_reserved_format]
      Thread.current[:pwfmt_reserved_format][field]
    end
  end

  def self.reserve_format(field, text)
    if text.respond_to?(:wiki_format)
      Thread.current[:pwfmt_reserved_format] ||= {}
      Thread.current[:pwfmt_reserved_format][field] = text.wiki_format
    end
  end

  def self.clear
    self.formats = nil
    Thread.current[:pwfmt_reserved_format] = nil
  end

  def self.has_format_for?(key)
    self.formats.present? && self.formats.key?(key)
  end

  def self.format_for(key)
    self.formats[key] if has_format_for?(key)
  end
end
