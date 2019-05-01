require_relative '../system_test_case'

class NewsDescriptionTest < Pwfmt::SystemTestCase
  setup do
    load_default_data
    sign_in_as_test_user
    create_project
  end

  test 'textile initially selected in edit page when format setting is textile' do
    Setting.text_formatting = 'textile'
    visit new_project_news_path(project_id: project_id)
    assert textile_selected?('pwfmt-select-news_description')
  end

  test 'markdown initially selected in edit page when format setting is markdown' do
    Setting.text_formatting = 'markdown'
    visit new_project_news_path(project_id: project_id)
    assert markdown_selected?('pwfmt-select-news_description')
  end

  test 'textile initially selected in index page when format setting is textile' do
    Setting.text_formatting = 'textile'
    visit project_news_index_path(project_id: project_id)
    find('a.icon-add').click
    assert textile_selected?('pwfmt-select-news_description')
  end

  test 'markdown initially selected in index page when format setting is markdown' do
    Setting.text_formatting = 'markdown'
    visit project_news_index_path(project_id: project_id)
    find('a.icon-add').click
    assert markdown_selected?('pwfmt-select-news_description')
  end

  test 'view as textile in show page when news is saved as textile' do
    save_news_as('textile')
    visit news_path(News.first)
    assert textile_include?('content')
  end

  test 'view as markdown in show page when news is saved as markdown' do
    save_news_as('markdown')
    visit news_path(News.first)
    assert markdown_include?('content')
  end

  test 'view as own format in index page when news are saved with different format' do
    save_news_as('textile')
    save_news_as('markdown')
    visit project_news_index_path(project_id: project_id)
    assert textile_include?('content')
    assert markdown_include?('content')
  end

  test 'textile selected when editing news saved as textile' do
    Setting.text_formatting = 'markdown'
    save_news_as('textile')
    visit edit_news_path(News.first)
    assert textile_selected?('pwfmt-select-news_description')
  end

  test 'markdown selected when editing news saved as markdown' do
    Setting.text_formatting = 'textile'
    save_news_as('markdown')
    visit edit_news_path(News.first)
    assert markdown_selected?('pwfmt-select-news_description')
  end

  test 'update format to markdown from textile' do
    Setting.text_formatting = 'textile'
    save_news_as('markdown')
    visit edit_news_path(News.first)
    select_markdown('pwfmt-select-news_description')
    find_by_id('news_description').set(markdown_text)
    find('#news-form input[name=commit]').click
    visit news_path(News.first)
    assert markdown_include?('content')
  end

  test 'update format to textile from markdown' do
    Setting.text_formatting = 'markdown'
    save_news_as('textile')
    visit edit_news_path(News.first)
    select_textile('pwfmt-select-news_description')
    find_by_id('news_description').set(textile_text)
    find('#news-form input[name=commit]').click
    visit news_path(News.first)
    assert textile_include?('content')
  end
end
