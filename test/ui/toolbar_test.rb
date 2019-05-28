require_relative '../system_test_case'

# This class tests that toolbar assign helper value to textarea with considering selected format.
class ToolbarTest < Pwfmt::SystemTestCase
  setup do
    load_default_data
    sign_in_as_test_user
    # Redmine requires having 'create project' authority in some project for creating project.
    create_project
  end

  TEXTILE_DATA = [
    { key: 'strong',  before: '', after: '**' },
    { key: 'em',      before: '', after: '__' },
    { key: 'ins',     before: '', after: '++' },
    { key: 'del',     before: '', after: '--' },
    { key: 'code',    before: '', after: '@@' },
    { key: 'h1',      before: '', after: 'h1. ' },
    { key: 'h2',      before: '', after: 'h2. ' },
    { key: 'h3',      before: '', after: 'h3. ' },
    { key: 'ul',      before: '', after: '* ' },
    { key: 'ol',      before: '', after: '# ' },
    { key: 'bq',      before: '', after: '> ' },
    { key: 'unbq',    before: '>', after: '' },
    { key: 'pre',     before: '', after: "<pre>\n\n</pre>" },
    # { key: 'precode', before: '', after: '' },
    { key: 'link',    before: '', after: '[[]]' },
    { key: 'img',     before: '', after: '!!' }
  ].freeze
  MARKDOWN_DATA = [
    { key: 'strong',  before: '', after: '****' },
    { key: 'em',      before: '', after: '**' },
    { key: 'ins',     before: '', after: '__' },
    { key: 'del',     before: '', after: '~~~~' },
    { key: 'code',    before: '', after: '``' },
    { key: 'h1',      before: '', after: '# ' },
    { key: 'h2',      before: '', after: '## ' },
    { key: 'h3',      before: '', after: '### ' },
    { key: 'ul',      before: '', after: '* ' },
    { key: 'ol',      before: '', after: '1. ' },
    { key: 'bq',      before: '', after: '> ' },
    { key: 'unbq',    before: '>', after: '' },
    { key: 'pre',     before: '', after: "```\n\n```" },
    # { key: 'precode', before: '', after: '' },
    { key: 'link',    before: '', after: '[[]]' },
    { key: 'img',     before: '', after: '![]()' }
  ].freeze

  test 'insert support string to textarea by selected format' do
    Setting.text_formatting = 'textile'
    visit new_project_path
    textarea = find_by_id('project_description')
    [['textile', TEXTILE_DATA], ['markdown', MARKDOWN_DATA]].each do |format, dataset|
      select_format('pwfmt-select-project_description', format)
      dataset.each do |data|
        textarea.set(data[:before])
        find("button.jstb_#{data[:key]}").click
        assert textarea.value == data[:after], "[#{format}][#{data[:key]}] expected: #{data[:after]}, but got #{textarea.value}"
      end
    end
  end

  test 'insert support string for code highlight to textarea by selected format' do
    visit new_project_path
    textarea = find_by_id('project_description')
    textarea.set('')
    select_textile('pwfmt-select-project_description')
    find('button.jstb_precode').click
    find('li', text: 'cpp').click
    assert_equal textarea.value, "<pre><code class=\"cpp\">\n\n</code></pre>\n"

    textarea.set('')
    select_markdown('pwfmt-select-project_description')
    find('button.jstb_precode').click
    find('li', text: 'cpp').click
    assert_equal textarea.value, "``` cpp\n\n```\n"
  end

  test 'open help windiw by selected format' do
    visit new_project_path
    select_textile('pwfmt-select-project_description')
    find('button.jstb_help').click
    within_window(windows.last) do
      assert current_url.ends_with?('wiki_syntax_textile.html')
      page.driver.browser.close
    end

    select_markdown('pwfmt-select-project_description')
    find('button.jstb_help').click
    within_window(windows.last) do
      assert current_url.ends_with?('wiki_syntax_markdown.html')
      page.driver.browser.close
    end
  end
end
