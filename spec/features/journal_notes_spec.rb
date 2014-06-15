require_relative '../spec_helper'

feature 'Journal notes', js: true do
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
      Redmine::WikiFormatting.format_names.each do |issue_format|
        context "when issue description is written as #{issue_format}" do
          background do
            visit new_project_issue_path(project_id: 'test')
            select_format('#pwfmt-select-issue_description', issue_format)
            find('#issue_subject').set 'test'
            find('#issue_description').set raw_text
            find('#issue-form').find('input[name=commit]').click
            @issue = Issue.all.first
          end
          scenario "selected item of select box is #{format} when first visited" do
            visit_issue(@issue)
            all("a[href='#{edit_issue_path(@issue)}']").first.click
            expect(format_option('pwfmt-select-issue_notes', format).selected?).to be_true
          end
          context 'when save as markdown' do
            background do
              visit_issue(@issue)
              all("a[href='#{edit_issue_path(@issue)}']").first.click
              select_format('#pwfmt-select-issue_notes', 'markdown')
              find('#issue_notes').set raw_text
              find('#issue-form').find('input[name=commit]').click
            end
            scenario 'view as markdown' do
              visit_issue(@issue)
              expect(html_by_id("journal-#{@issue.journals.first.id}-notes")).to include markdown_text
            end
            scenario 'selected item of select box is markdown' do
              visit_issue(@issue)
              journal_id = @issue.journals.first.id
              find("#journal-#{journal_id}-notes").find("a[href='#']").click
              expect(format_option("pwfmt-select-journal_#{journal_id}_notes", 'markdown').selected?).to be_true
            end
            context 'when change format to textile' do
              background do
                visit_issue(@issue)
                journal_id = @issue.journals.first.id
                find("#journal-#{journal_id}-notes").find("a[href='#']").click
                select_format("#pwfmt-select-journal_#{journal_id}_notes", 'textile')
                find("#journal_#{journal_id}_notes").set raw_text
                find("#journal-#{journal_id}-form").find('input[name=commit]').click
              end
              scenario 'view as textile' do
                visit_issue(@issue)
                expect(html_by_id("journal-#{@issue.journals.first.id}-notes")).to include textile_text
              end
              scenario 'selected item of select box is textile' do
                visit_issue(@issue)
                journal_id = @issue.journals.first.id
                find("#journal-#{journal_id}-notes").find("a[href='#']").click
                expect(format_option("pwfmt-select-journal_#{journal_id}_notes", 'textile').selected?).to be_true
              end
            end
          end
          context 'when save as textile' do
            background do
              visit_issue(@issue)
              all("a[href='#{edit_issue_path(@issue)}']").first.click
              select_format('#pwfmt-select-issue_notes', 'textile')
              find('#issue_notes').set raw_text
              find('#issue-form').find('input[name=commit]').click
            end
            scenario 'view as textile' do
              visit_issue(@issue)
              expect(html_by_id("journal-#{@issue.journals.first.id}-notes")).to include textile_text
            end
            scenario 'selected item of select box is textile' do
              visit_issue(@issue)
              journal_id = @issue.journals.first.id
              find("#journal-#{journal_id}-notes").find("a[href='#']").click
              expect(format_option("pwfmt-select-journal_#{journal_id}_notes", 'textile').selected?).to be_true
            end
            context 'when change format to markdown' do
              background do
                visit_issue(@issue)
                journal_id = @issue.journals.first.id
                find("#journal-#{journal_id}-notes").find("a[href='#']").click
                select_format("#pwfmt-select-journal_#{journal_id}_notes", 'markdown')
                find("#journal_#{journal_id}_notes").set raw_text
                find("#journal-#{journal_id}-form").find('input[name=commit]').click
              end
              scenario 'view as markdown' do
                visit_issue(@issue)
                expect(html_by_id("journal-#{@issue.journals.first.id}-notes")).to include markdown_text
              end
              scenario 'selected item of select box is markdown' do
                visit_issue(@issue)
                journal_id = @issue.journals.first.id
                find("#journal-#{journal_id}-notes").find("a[href='#']").click
                expect(format_option("pwfmt-select-journal_#{journal_id}_notes", 'markdown').selected?).to be_true
              end
            end
          end
          context 'when markdown and textile' do
            background do
              # markdown
              visit_issue(@issue)
              all("a[href='#{edit_issue_path(@issue)}']").first.click
              select_format('#pwfmt-select-issue_notes', 'markdown')
              find('#issue_notes').set raw_text
              find('#issue-form').find('input[name=commit]').click

              # textile
              visit_issue(@issue)
              all("a[href='#{edit_issue_path(@issue)}']").first.click
              select_format('#pwfmt-select-issue_notes', 'textile')
              find('#issue_notes').set raw_text
              find('#issue-form').find('input[name=commit]').click
            end
            scenario "view as markdown and view as textile in issue's histories" do
              visit_issue(@issue)
              @issue.journals.each do |journal|
                journal.load_wiki_format!
                if journal.notes.wiki_format == 'markdown'
                  expect(html_by_id("journal-#{journal.id}-notes")).to include markdown_text
                else
                  expect(html_by_id("journal-#{journal.id}-notes")).to include textile_text
                end
              end
            end
          end
          context 'when update issue description and register journal notes at same time' do
            background do
              visit_issue(@issue)
              open_issue_description_edit_area(@issue)
              select_format('#pwfmt-select-issue_description', issue_format == 'markdown' ? 'textile' : 'markdown')
              find('#issue_description').set raw_text
              select_format('#pwfmt-select-issue_notes', issue_format)
              find('#issue_notes').set raw_text
              find('#issue-form').find('input[name=commit]').click
            end
            scenario "issue description is formatted as #{issue_format == 'markdown' ? 'textile' : 'markdown'}" do
              visit_issue(@issue)
              if issue_format == 'markdown'
                expect(html_by_class('description')).to include textile_text
              else
                expect(html_by_class('description')).to include markdown_text
              end
            end
            scenario "journal notes is formatted as #{issue_format}" do
              visit_issue(@issue)
              if issue_format == 'markdown'
                expect(html_by_id("journal-#{@issue.journals.first.id}-notes")).to include markdown_text
              else
                expect(html_by_id("journal-#{@issue.journals.first.id}-notes")).to include textile_text
              end
            end
          end
        end
      end
    end
  end
end
