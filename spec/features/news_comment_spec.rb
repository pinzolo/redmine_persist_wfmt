require_relative '../spec_helper'

feature 'News comment' do
  background do
    load_default_data
    sign_in_as_admin
    create_project
    create_news
  end
  Redmine::WikiFormatting.format_names.each do |format|
    context "when text_formatting setting is #{format}" do
      background do
        Setting.text_formatting = format
      end
      scenario "selected item of select box is #{format} when first visited", js: true do
        visit_news
        find('a[href="#"]').click
        expect(format_option('pwfmt-select-comment_comments', format).selected?).to be_true
      end
      context 'when save as markdown' do
        background do
          visit_news
          find('a[href="#"]').click
          select_format('#pwfmt-select-comment_comments', 'markdown')
          find('#comment_comments').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as markdown', js: true do
          visit_news
          expect(html_by_id('comments')).to include markdown_text
        end
      end
      context 'when save as textile' do
        background do
          visit_news
          find('a[href="#"]').click
          select_format('#pwfmt-select-comment_comments', 'textile')
          find('#comment_comments').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as textile', js: true do
          visit_news
          expect(html_by_id('comments')).to include textile_text
        end
      end
      context 'when markdown and textile' do
        background do
          # markdown
          visit_news
          find('a[href="#"]').click
          select_format('#pwfmt-select-comment_comments', 'markdown')
          find('#comment_comments').set raw_text
          find('input[name=commit]').click

          # textile
          visit_news
          find('a[href="#"]').click
          select_format('#pwfmt-select-comment_comments', 'textile')
          find('#comment_comments').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as markdown and view as textile in news#show', js: true do
          visit_news
          expect(html_by_id('comments')).to include markdown_text
          expect(html_by_id('comments')).to include textile_text
        end
      end
    end
  end
end
