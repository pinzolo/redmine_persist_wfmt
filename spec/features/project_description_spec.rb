require_relative '../spec_helper'

feature 'Project description' do
  background do
    load_default_data
    sign_in_as_admin
  end

  Redmine::WikiFormatting.format_names.each do |format|
    context "when text_formatting setting is #{format}" do
      background do
        Setting.text_formatting = format
      end
      scenario "selected item of select box is #{format} when first visited", js: true do
        visit new_project_path
        expect(format_option('pwfmt-select-project_description', format).selected?).to be_true
      end
      context 'when save as markdown' do
        background do
          visit new_project_path
          select_format('#pwfmt-select-project_description', 'markdown')
          find('#project_name').set 'test'
          find('#project_description').set raw_text
          find('#project_identifier').set 'test'
          find('input[name=commit]').click
        end
        scenario 'view as markdown', js: true do
          visit project_path('test')
          expect(html_by_id('content')).to include markdown_text
        end
        scenario 'selected item of select box is markdown', js: true do
          visit settings_project_path('test')
          expect(format_option('pwfmt-select-project_description', 'markdown').selected?).to be_true
        end
        context 'when change format to textile' do
          background do
            visit settings_project_path('test')
            select_format('#pwfmt-select-project_description', 'textile')
            find('input[name=commit]').click
          end
          scenario 'view as textile', js: true do
            visit project_path('test')
            expect(html_by_id('content')).to include textile_text
          end
          scenario 'selected item of select box is textile', js: true do
            visit settings_project_path('test')
            expect(format_option('pwfmt-select-project_description', 'textile').selected?).to be_true
          end
        end
      end
      context 'when save as textile' do
        background do
          visit new_project_path
          select_format('#pwfmt-select-project_description', 'textile')
          find('#project_name').set 'test'
          find('#project_description').set raw_text
          find('#project_identifier').set 'test'
          find('input[name=commit]').click
        end
        scenario 'view as textile', js: true do
          visit project_path('test')
          expect(html_by_id('content')).to include textile_text
        end
        scenario 'selected item of select box is textile', js: true do
          visit settings_project_path('test')
          expect(format_option('pwfmt-select-project_description', 'textile').selected?).to be_true
        end
        context 'when change format to markdown' do
          background do
            visit settings_project_path('test')
            select_format('#pwfmt-select-project_description', 'markdown')
            find('input[name=commit]').click
          end
          scenario 'view as markdown', js: true do
            visit project_path('test')
            expect(html_by_id('content')).to include markdown_text
          end
          scenario 'selected item of select box is markdown', js: true do
            visit settings_project_path('test')
            expect(format_option('pwfmt-select-project_description', 'markdown').selected?).to be_true
          end
        end
      end
    end
  end
end
