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

  test 'view as textile when document is saved as textile' do
    save_document_as('textile')
    visit document_path(Document.first)
    assert textile_include?('content')
  end

  test 'view as markdown when document is saved as markdown' do
    save_document_as('markdown')
    visit document_path(Document.first)
    assert markdown_include?('content')
  end
end
