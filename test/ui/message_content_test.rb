require_relative '../system_test_case'

# This class tests that user can select wiki format of message's content.
class MessageContentTest < Pwfmt::Testing::SystemTestCase
  setup do
    load_default_data
    sign_in_as_test_user
    create_project
    create_forum
  end

  test 'textile initially selected when format setting is textile' do
    Setting.text_formatting = 'textile'
    visit new_board_message_path(Board.first)
    assert textile_selected?('pwfmt-select-message_content')
  end

  test 'markdown initially selected when format setting is markdown' do
    Setting.text_formatting = 'markdown'
    visit new_board_message_path(Board.first)
    assert markdown_selected?('pwfmt-select-message_content')
  end

  test 'textile initially selected in index page when format setting is textile' do
    Setting.text_formatting = 'textile'
    visit project_board_path(Board.first, project_id: project_id)
    find('a.icon-add').click
    assert textile_selected?('pwfmt-select-message_content')
  end

  test 'markdown initially selected in index page when format setting is markdown' do
    Setting.text_formatting = 'markdown'
    visit project_board_path(Board.first, project_id: project_id)
    find('a.icon-add').click
    assert markdown_selected?('pwfmt-select-message_content')
  end

  test 'view as textile in show page when message is saved as textile' do
    save_message_as('textile')
    visit board_message_path(Board.first, Message.first)
    assert textile_include?('content')
  end

  test 'view as markdown in show page when message is saved as markdown' do
    save_message_as('markdown')
    visit board_message_path(Board.first, Message.first)
    assert markdown_include?('content')
  end

  test 'textile selected when editing message saved as textile' do
    Setting.text_formatting = 'markdown'
    save_message_as('textile')
    visit "boards/#{Board.first.id}/topics/#{Message.first.id}/edit"
    assert textile_selected?('pwfmt-select-message_content')
  end

  test 'markdown selected when editing message saved as markdown' do
    Setting.text_formatting = 'textile'
    save_message_as('markdown')
    visit "boards/#{Board.first.id}/topics/#{Message.first.id}/edit"
    assert markdown_selected?('pwfmt-select-message_content')
  end

  test 'update format to markdown from textile' do
    Setting.text_formatting = 'textile'
    save_message_as('textile')
    msg = Message.first
    visit "boards/#{Board.first.id}/topics/#{msg.id}/edit"
    select_markdown('pwfmt-select-message_content')
    find_by_id('message_content').set(markdown_text)
    find('#message-form input[name=commit]').click
    visit board_message_path(Board.first, msg)
    assert markdown_include?('content')
  end

  test 'update format to textile from markdown' do
    Setting.text_formatting = 'markdown'
    save_message_as('markdown')
    msg = Message.first
    visit "boards/#{Board.first.id}/topics/#{msg.id}/edit"
    select_textile('pwfmt-select-message_content')
    find_by_id('message_content').set(textile_text)
    find('#message-form input[name=commit]').click
    visit board_message_path(Board.first, msg)
    assert textile_include?('content')
  end

  test 'preview by selected format' do
    visit new_board_message_path(Board.first)
    select_markdown('pwfmt-select-message_content')
    find_by_id('message_content').set(markdown_text)
    find('#message-form a.tab-preview').click
    wait_for_preview
    assert markdown_include?('preview_message_content')
    find('#message-form a.tab-edit').click
    select_textile('pwfmt-select-message_content')
    find_by_id('message_content').set(textile_text)
    find('#message-form a.tab-preview').click
    wait_for_preview
    assert textile_include?('preview_message_content')
  end
end
