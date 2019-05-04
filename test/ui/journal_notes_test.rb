require_relative '../system_test_case'

class JournalNotesTest < Pwfmt::SystemTestCase
  setup do
    load_default_data
    sign_in_as_test_user
    create_project
    save_issue_as('textile')
  end

  test 'textile initially selected when format setting is textile' do
    Setting.text_formatting = 'textile'
    visit issue_path(Issue.first)
    find('a.icon-edit[accesskey=e]').click
    assert textile_selected?('pwfmt-select-issue_notes')
  end

  test 'markdown initially selected when format setting is markdown' do
    Setting.text_formatting = 'markdown'
    visit issue_path(Issue.first)
    find('a.icon-edit[accesskey=e]').click
    assert markdown_selected?('pwfmt-select-issue_notes')
  end

  test 'view as own format in issue show page when journals are saved with different format' do
    save_journal_as('textile')
    save_journal_as('markdown')
    visit issue_path(Issue.first)
    assert textile_include?("journal-#{Journal.order(:created_on).first.id}-notes")
    assert markdown_include?("journal-#{Journal.order(:created_on).last.id}-notes")
  end

  test 'textile selected when editing journal saved as textile' do
    Setting.text_formatting = 'markdown'
    save_journal_as('textile')
    visit issue_path(Issue.first)
    journal = Journal.first
    find("#change-#{journal.id} a.icon-edit").click
    assert textile_selected?("pwfmt-select-journal_#{journal.id}_notes")
  end

  test 'markdown selected when editing journal saved as markdown' do
    Setting.text_formatting = 'textile'
    save_journal_as('markdown')
    visit issue_path(Issue.first)
    journal = Journal.first
    find("#change-#{journal.id} a.icon-edit").click
    assert markdown_selected?("pwfmt-select-journal_#{journal.id}_notes")
  end

  test 'update format to markdown from textile' do
    Setting.text_formatting = 'textile'
    save_journal_as('textile')
    journal = Journal.first
    visit issue_path(Issue.first)
    find("#change-#{journal.id} a.icon-edit").click
    select_markdown("pwfmt-select-journal_#{journal.id}_notes")
    find_by_id("journal_#{journal.id}_notes").set(markdown_text)
    find("#journal-#{journal.id}-form input[name=commit]").click
    assert markdown_include?("journal-#{journal.id}-notes")
  end

  test 'update format to textile from markdown' do
    Setting.text_formatting = 'markdown'
    save_journal_as('markdown')
    journal = Journal.first
    visit issue_path(Issue.first)
    find("#change-#{journal.id} a.icon-edit").click
    select_textile("pwfmt-select-journal_#{journal.id}_notes")
    find_by_id("journal_#{journal.id}_notes").set(textile_text)
    find("#journal-#{journal.id}-form input[name=commit]").click
    assert textile_include?("journal-#{journal.id}-notes")
  end

  test 'preview by selected format' do
    visit edit_issue_path(Issue.first)
    select_markdown('pwfmt-select-issue_notes')
    find_by_id('issue_notes').set(markdown_text)
    find('#issue-form a.tab-preview').click
    wait_for_preview
    assert markdown_include?('preview_issue_notes')
    find('#issue-form a.tab-edit').click
    select_textile('pwfmt-select-issue_notes')
    find_by_id('issue_notes').set(textile_text)
    find('#issue-form a.tab-preview').click
    wait_for_preview
    assert textile_include?('preview_issue_notes')
  end
end
