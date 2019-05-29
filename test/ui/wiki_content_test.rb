require_relative '../system_test_case'

# This class tests that user can select wiki format of wiki's content.
class WikiContentTest < Pwfmt::Testing::SystemTestCase
  setup do
    load_default_data
    sign_in_as_test_user
    create_project
  end

  test 'textile initially selected when format setting is textile' do
    Setting.text_formatting = 'textile'
    visit "projects/#{project_id}/wiki"
    assert textile_selected?('pwfmt-select-content_text')
  end

  test 'markdown initially selected when format setting is markdown' do
    Setting.text_formatting = 'markdown'
    visit "projects/#{project_id}/wiki"
    assert markdown_selected?('pwfmt-select-content_text')
  end

  test 'view as textile in show page when wiki page is saved as textile' do
    save_wiki_page_as('textile')
    visit "projects/#{project_id}/wiki"
    assert textile_include?('content')
  end

  test 'view as markdown in show page when wiki page is saved as markdown' do
    save_wiki_page_as('markdown')
    visit "projects/#{project_id}/wiki"
    assert markdown_include?('content')
  end

  test 'textile selected when editing wiki page saved as textile' do
    Setting.text_formatting = 'markdown'
    save_wiki_page_as('textile')
    visit "projects/#{project_id}/wiki"
    find('a.icon-edit').click
    assert textile_selected?('pwfmt-select-content_text')
  end

  test 'markdown selected when editing wiki page saved as markdown' do
    Setting.text_formatting = 'textile'
    save_wiki_page_as('markdown')
    visit "projects/#{project_id}/wiki"
    find('a.icon-edit').click
    assert markdown_selected?('pwfmt-select-content_text')
  end

  test 'update format to markdown from textile' do
    Setting.text_formatting = 'textile'
    save_wiki_page_as('textile')
    visit "projects/#{project_id}/wiki"
    find('a.icon-edit').click
    select_markdown('pwfmt-select-content_text')
    find_by_id('content_text').set(markdown_text)
    find('#wiki_form input[name=commit]').click
    visit "projects/#{project_id}/wiki"
    assert markdown_include?('content')
  end

  test 'update format to textile from markdown' do
    Setting.text_formatting = 'markdown'
    save_wiki_page_as('markdown')
    visit "projects/#{project_id}/wiki"
    find('a.icon-edit').click
    select_textile('pwfmt-select-content_text')
    find_by_id('content_text').set(textile_text)
    find('#wiki_form input[name=commit]').click
    visit "projects/#{project_id}/wiki"
    assert textile_include?('content')
  end

  test 'preview by selected format' do
    visit "projects/#{project_id}/wiki"
    select_markdown('pwfmt-select-content_text')
    find_by_id('content_text').set(markdown_text)
    find('#wiki_form a.tab-preview').click
    wait_for_preview
    assert markdown_include?('preview_content_text')
    find('#wiki_form a.tab-edit').click
    select_textile('pwfmt-select-content_text')
    find_by_id('content_text').set(textile_text)
    find('#wiki_form a.tab-preview').click
    wait_for_preview
    assert textile_include?('preview_content_text')
  end
end
