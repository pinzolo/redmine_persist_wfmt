require_relative '../spec_helper'

feature 'Document description', js: true do
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
        visit new_project_document_path(project_id: 'test')
        expect(format_option('pwfmt-select-document_description', format).selected?).to be_true
      end
      context 'when save as markdown' do
        background do
          visit new_project_document_path(project_id: 'test')
          select_format('#pwfmt-select-document_description', 'markdown')
          find('#document_title').set 'test'
          find('#document_description').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as markdown' do
          document = Document.all.first
          visit document_path(document)
          expect(html_by_id('content')).to include markdown_text
        end
        scenario 'selected item of select box is markdown' do
          document = Document.all.first
          visit edit_document_path(document)
          expect(format_option('pwfmt-select-document_description', 'markdown').selected?).to be_true
        end
        context 'when change format to textile' do
          background do
            document = Document.all.first
            visit edit_document_path(document)
            select_format('#pwfmt-select-document_description', 'textile')
            find('input[name=commit]').click
          end
          scenario 'view as textile' do
            document = Document.all.first
            visit document_path(document)
            expect(html_by_id('content')).to include textile_text
          end
          scenario 'selected item of select box is textile' do
            document = Document.all.first
            visit edit_document_path(document)
            expect(format_option('pwfmt-select-document_description', 'textile').selected?).to be_true
          end
        end
      end
      context 'when save as textile' do
        background do
          visit new_project_document_path(project_id: 'test')
          select_format('#pwfmt-select-document_description', 'textile')
          find('#document_title').set 'test'
          find('#document_description').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as textile' do
          document = Document.all.first
          visit document_path(document)
          expect(html_by_id('content')).to include textile_text
        end
        scenario 'selected item of select box is textile' do
          document = Document.all.first
          visit edit_document_path(document)
          expect(format_option('pwfmt-select-document_description', 'textile').selected?).to be_true
        end
        context 'when change format to markdown' do
          background do
            document = Document.all.first
            visit edit_document_path(document)
            select_format('#pwfmt-select-document_description', 'markdown')
            find('input[name=commit]').click
          end
          scenario 'view as markdown' do
            document = Document.all.first
            visit document_path(document)
            expect(html_by_id('content')).to include markdown_text
          end
          scenario 'selected item of select box is markdown' do
            document = Document.all.first
            visit edit_document_path(document)
            expect(format_option('pwfmt-select-document_description', 'markdown').selected?).to be_true
          end
        end
      end
      context 'when markdown and textile' do
        background do
          # markdown
          visit new_project_document_path(project_id: 'test')
          select_format('#pwfmt-select-document_description', 'markdown')
          find('#document_title').set 'test'
          find('#document_description').set raw_text
          find('input[name=commit]').click

          # textile
          visit new_project_document_path(project_id: 'test')
          select_format('#pwfmt-select-document_description', 'textile')
          find('#document_title').set 'test'
          find('#document_description').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as markdown and view as textile in document list' do
          visit project_documents_path('test')
          expect(html_by_id('content')).to include markdown_text
          expect(html_by_id('content')).to include textile_text
        end
      end
    end
  end
end
