# coding: utf-8
class PwfmtContext
  def self.format
    Thread.current[:pwfmt_format]
  end

  def self.format=(format)
    Thread.current[:pwfmt_format] = format
  end
end
