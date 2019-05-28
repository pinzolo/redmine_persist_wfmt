# This implements redmine hook for rendring script.
class Pwfmt::Hooks < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(_context = {})
    html = ''
    html << javascript_include_tag('pwfmt', plugin: 'redmine_persist_wfmt')
    html.html_safe
  end
end
