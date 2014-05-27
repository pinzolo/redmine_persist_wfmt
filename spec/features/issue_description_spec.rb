require_relative '../spec_helper'

feature 'Issue description', js: true do
  background do
    load_default_data
    sign_in_as_admin
    create_project
  end

  Redmine::WikiFormatting.format_names.each do |format|
    context "when text_formatting setting is #{format}" do
      background do
        Setting.text_formatting = format
      end
      scenario "selected item of select box is #{format} when first visited" do
        visit new_project_issue_path(project_id: 'test')
        expect(format_option('pwfmt-select-issue_description', format).selected?).to be_true
      end
      context 'when save as markdown' do
        background do
          visit new_project_issue_path(project_id: 'test')
          select_format('#pwfmt-select-issue_description', 'markdown')
          find('#issue_subject').set 'test'
          find('#issue_description').set raw_text
          find('#issue-form').find('input[name=commit]').click
        end
        scenario 'view as markdown' do
          issue = Issue.all.first
          visit_issue(issue)
          expect(html_by_class('description')).to include markdown_text
        end
        scenario 'selected item of select box is markdown' do
          issue = Issue.all.first
          visit_issue(issue)
          open_issue_description_edit_area(issue)
          expect(format_option('pwfmt-select-issue_description', 'markdown').selected?).to be_true
        end
        context 'when change format to textile' do
          background do
            issue = Issue.all.first
            visit_issue(issue)
            open_issue_description_edit_area(issue)
            select_format('#pwfmt-select-issue_description', 'textile')
            find('#issue_description').set raw_text
            find('#issue-form').find('input[name=commit]').click
          end
          scenario 'view as textile' do
            issue = Issue.all.first
            visit_issue(issue)
            expect(html_by_class('description')).to include textile_text
          end
          scenario 'selected item of select box is textile' do
            issue = Issue.all.first
            visit_issue(issue)
            open_issue_description_edit_area(issue)
            expect(format_option('pwfmt-select-issue_description', 'textile').selected?).to be_true
          end
        end
      end
      context 'when save as textile' do
        background do
          visit new_project_issue_path(project_id: 'test')
          select_format('#pwfmt-select-issue_description', 'textile')
          find('#issue_subject').set 'test'
          find('#issue_description').set raw_text
          find('#issue-form').find('input[name=commit]').click
        end
        scenario 'view as textile' do
          issue = Issue.all.first
          visit_issue(issue)
          expect(html_by_class('description')).to include textile_text
        end
        scenario 'selected item of select box is textile' do
          issue = Issue.all.first
          visit_issue(issue)
          open_issue_description_edit_area(issue)
          expect(format_option('pwfmt-select-issue_description', 'textile').selected?).to be_true
        end
        context 'when change format to markdown' do
          background do
            issue = Issue.all.first
            visit_issue(issue)
            open_issue_description_edit_area(issue)
            select_format('#pwfmt-select-issue_description', 'markdown')
            find('#issue_description').set raw_text
            find('#issue-form').find('input[name=commit]').click
          end
          scenario 'view as markdown' do
            issue = Issue.all.first
            visit_issue(issue)
            expect(html_by_class('description')).to include markdown_text
          end
          scenario 'selected item of select box is markdown' do
            issue = Issue.all.first
            visit_issue(issue)
            open_issue_description_edit_area(issue)
            expect(format_option('pwfmt-select-issue_description', 'markdown').selected?).to be_true
          end
        end
      end
    end
  end
end
