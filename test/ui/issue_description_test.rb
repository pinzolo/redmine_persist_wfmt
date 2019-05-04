require_relative '../system_test_case'

class IssueDescriptionTest < Pwfmt::SystemTestCase
  setup do
    load_default_data
    sign_in_as_test_user
    create_project
  end

  test 'textile initially selected when format setting is textile' do
    Setting.text_formatting = 'textile'
    visit new_project_issue_path(project_id: project_id)
    assert textile_selected?('pwfmt-select-issue_description')
  end

  test 'markdown initially selected when format setting is markdown' do
    Setting.text_formatting = 'markdown'
    visit new_project_issue_path(project_id: project_id)
    assert markdown_selected?('pwfmt-select-issue_description')
  end

  test 'view as textile in show page when issue description is saved as textile' do
    save_issue_as('textile')
    visit issue_path(Issue.first)
    assert textile_include?('content')
  end

  test 'view as markdown in show page when issue description is saved as markdown' do
    save_issue_as('markdown')
    visit issue_path(Issue.first)
    assert markdown_include?('content')
  end

  test 'textile selected when editing issue saved as textile' do
    Setting.text_formatting = 'markdown'
    save_issue_as('textile')
    visit edit_issue_path(Issue.first)
    find('span.icon-edit').click
    assert textile_selected?('pwfmt-select-issue_description')
  end

  test 'markdown selected when editing issue saved as markdown' do
    Setting.text_formatting = 'textile'
    save_issue_as('markdown')
    visit edit_issue_path(Issue.first)
    find('span.icon-edit').click
    assert markdown_selected?('pwfmt-select-issue_description')
  end

  test 'update format to markdown from textile' do
    Setting.text_formatting = 'textile'
    save_issue_as('textile')
    iss = Issue.first
    visit edit_issue_path(iss)
    find('span.icon-edit').click
    select_markdown('pwfmt-select-issue_description')
    find_by_id('issue_description').set(markdown_text)
    find('#issue-form input[name=commit]').click
    visit issue_path(iss)
    assert markdown_include?('content')
  end

  test 'update format to textile from markdown' do
    Setting.text_formatting = 'markdown'
    save_issue_as('markdown')
    iss = Issue.first
    visit edit_issue_path(iss)
    find('span.icon-edit').click
    select_textile('pwfmt-select-issue_description')
    find_by_id('issue_description').set(textile_text)
    find('#issue-form input[name=commit]').click
    visit issue_path(iss)
    assert textile_include?('content')
  end

  test 'preview by selected format' do
    visit new_project_issue_path(project_id: project_id)
    select_markdown('pwfmt-select-issue_description')
    find_by_id('issue_description').set(markdown_text)
    find('#issue-form a.tab-preview').click
    wait_for_preview
    assert markdown_include?('preview_issue_description')
    find('#issue-form a.tab-edit').click
    select_textile('pwfmt-select-issue_description')
    find_by_id('issue_description').set(textile_text)
    find('#issue-form a.tab-preview').click
    wait_for_preview
    assert textile_include?('preview_issue_description')
  end
end
