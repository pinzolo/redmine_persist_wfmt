require_relative '../system_test_case'

class DocumentDescriptionTest < Pwfmt::SystemTestCase
  setup do
    load_default_data
    sign_in_as_test_user
    create_project
  end

  test 'textile initially selected when format setting is textile' do
    Setting.text_formatting = 'textile'
    visit new_project_document_path(project_id: project_id)
    assert textile_selected?('pwfmt-select-document_description')
  end

  test 'markdown initially selected when format setting is markdown' do
    Setting.text_formatting = 'markdown'
    visit new_project_document_path(project_id: project_id)
    assert markdown_selected?('pwfmt-select-document_description')
  end

  test 'view as textile in index page when document is saved as textile' do
    save_document_as('textile')
    visit project_documents_path(project_id: project_id)
    assert textile_include?('content')
  end

  test 'view as markdown in index page when document is saved as markdown' do
    save_document_as('markdown')
    visit project_documents_path(project_id: project_id)
    assert markdown_include?('content')
  end

  test 'view as textile in show page when document is saved as textile' do
    save_document_as('textile')
    visit document_path(Document.first)
    assert textile_include?('content')
  end

  test 'view as markdown in show page when document is saved as markdown' do
    save_document_as('markdown')
    visit document_path(Document.first)
    assert markdown_include?('content')
  end

  test 'textile selected when editing document saved as textile' do
    Setting.text_formatting = 'markdown'
    save_document_as('textile')
    visit edit_document_path(Document.first)
    assert textile_selected?('pwfmt-select-document_description')
  end

  test 'markdown selected when editing document saved as markdown' do
    Setting.text_formatting = 'textile'
    save_document_as('markdown')
    visit edit_document_path(Document.first)
    assert markdown_selected?('pwfmt-select-document_description')
  end

  test 'update format to markdown from textile' do
    Setting.text_formatting = 'textile'
    save_document_as('markdown')
    visit edit_document_path(Document.first)
    select_markdown('pwfmt-select-document_description')
    find_by_id('document_description').set(markdown_text)
    find('input[name=commit]').click
    visit document_path(Document.first)
    assert markdown_include?('content')
  end

  test 'update format to textile from markdown' do
    Setting.text_formatting = 'markdown'
    save_document_as('textile')
    visit edit_document_path(Document.first)
    select_textile('pwfmt-select-document_description')
    find_by_id('document_description').set(textile_text)
    find('input[name=commit]').click
    visit document_path(Document.first)
    assert textile_include?('content')
  end
end
