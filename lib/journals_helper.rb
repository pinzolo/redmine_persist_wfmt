module JournalsHelper
  def render_notes_with_pwfmt(issue, journal, options={})
    journal.load_wiki_format!
    render_notes_without_pwfmt(issue, journal, options)
  end
  alias_method_chain :render_notes, :pwfmt
end
