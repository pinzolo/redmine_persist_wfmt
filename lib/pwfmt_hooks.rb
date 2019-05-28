# This implements redmine hook for rendring script.
class Pwfmt::Hooks < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(_context = {})
    javascript_include_tag('pwfmt', plugin: 'redmine_persist_wfmt')
  end
end
