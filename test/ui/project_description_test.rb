require_relative '../system_test_case'

class ProjectDescriptionTest < Pwfmt::SystemTestCase
  setup do
    load_default_data
    sign_in_as_test_user
    # Redmine requires having 'create project' authority in some project for creating project.
    create_project
  end

  test 'textile initially selected when format setting is textile' do
    Setting.text_formatting = 'textile'
    visit new_project_path
    assert textile_selected?('pwfmt-select-project_description')
  end

  test 'markdown initially selected when format setting is markdown' do
    Setting.text_formatting = 'markdown'
    visit new_project_path
    assert markdown_selected?('pwfmt-select-project_description')
  end

  test 'view as textile in show page when project description is saved as textile' do
    save_project_as('textile')
    visit project_path('test_textile')
    assert textile_include?('content')
  end

  test 'view as markdown in show page when project description is saved as markdown' do
    save_project_as('markdown')
    visit project_path('test_markdown')
    assert markdown_include?('content')
  end

  test 'view as own format in index page when projects are saved with different format' do
    save_project_as('textile')
    save_project_as('markdown')
    visit projects_path
    assert textile_include?('content')
    assert markdown_include?('content')
  end

  test 'textile selected when editing project saved as textile' do
    Setting.text_formatting = 'markdown'
    save_project_as('textile')
    visit settings_project_path('test_textile')
    assert textile_selected?('pwfmt-select-project_description')
  end

  test 'markdown selected when editing project saved as markdown' do
    Setting.text_formatting = 'textile'
    save_project_as('markdown')
    visit settings_project_path('test_markdown')
    assert markdown_selected?('pwfmt-select-project_description')
  end

  test 'update format to markdown from textile' do
    Setting.text_formatting = 'textile'
    save_project_as('textile')
    visit settings_project_path('test_textile')
    select_markdown('pwfmt-select-project_description')
    find_by_id('project_description').set(markdown_text)
    find("#edit_project_#{Project.find('test_textile').id} input[name=commit]").click
    visit project_path('test_textile')
    assert markdown_include?('content')
  end

  test 'update format to textile from markdown' do
    Setting.text_formatting = 'markdown'
    save_project_as('markdown')
    visit settings_project_path('test_markdown')
    select_textile('pwfmt-select-project_description')
    find_by_id('project_description').set(textile_text)
    find("#edit_project_#{Project.find('test_markdown').id} input[name=commit]").click
    visit project_path('test_markdown')
    assert textile_include?('content')
  end

  test 'preview by selected format' do
    visit new_project_path
    select_markdown('pwfmt-select-project_description')
    find_by_id('project_description').set(markdown_text)
    find('#new_project a.tab-preview').click
    wait_for_preview
    assert markdown_include?('preview_project_description')
    find('#new_project a.tab-edit').click
    select_textile('pwfmt-select-project_description')
    find_by_id('project_description').set(textile_text)
    find('#new_project a.tab-preview').click
    wait_for_preview
    assert textile_include?('preview_project_description')
  end
end
