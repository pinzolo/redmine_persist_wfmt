require_relative '../system_test_case'

# This class tests that user can select wiki format of news' comment.
class NewsCommentTest < Pwfmt::SystemTestCase
  setup do
    load_default_data
    sign_in_as_test_user
    create_project
    save_news_as('markdown')
  end

  test 'textile initially selected in news show page when format setting is textile' do
    Setting.text_formatting = 'textile'
    visit news_path(News.first)
    find('a', text: 'Add a comment').click
    assert textile_selected?('pwfmt-select-comment_comments')
  end

  test 'markdown initially selected in news show page when format setting is markdown' do
    Setting.text_formatting = 'markdown'
    visit news_path(News.first)
    find('a', text: 'Add a comment').click
    assert markdown_selected?('pwfmt-select-comment_comments')
  end

  test 'view as own format in news show page when news comments are saved with different format' do
    save_news_comment_as('textile')
    save_news_comment_as('markdown')
    visit news_path(News.first)
    assert textile_include?('comments')
    assert markdown_include?('comments')
  end

  test 'preview by selected format' do
    visit news_path(News.first)
    find('a', text: 'Add a comment').click
    select_markdown('pwfmt-select-comment_comments')
    find_by_id('comment_comments').set(markdown_text)
    find('#add_comment_form a.tab-preview').click
    wait_for_preview
    assert markdown_include?('preview_comment_comments')
    find('#add_comment_form a.tab-edit').click
    select_textile('pwfmt-select-comment_comments')
    find_by_id('comment_comments').set(textile_text)
    find('#add_comment_form a.tab-preview').click
    wait_for_preview
    assert textile_include?('preview_comment_comments')
  end
end
