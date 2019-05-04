module Pwfmt::Testing::Value
  def markdown_text
    '*This is markdown text.*'
  end

  def textile_text
    '*This is textile text.*'
  end

  def text_for(format)
    format == 'markdown' ? markdown_text : textile_text
  end

  def markdown_html
    '<em>This is markdown text.</em>'
  end

  def textile_html
    '<strong>This is textile text.</strong>'
  end

  def html_for(format)
    format == 'markdown' ? markdown_html : textile_html
  end

  def project_id
    'test'
  end
end
