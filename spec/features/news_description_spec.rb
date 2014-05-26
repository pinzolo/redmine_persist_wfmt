require_relative '../spec_helper'

feature 'News description' do
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
      scenario "selected item of select box is #{format} when first visited", js: true do
        visit new_project_news_path(project_id: 'test')
        expect(format_option('pwfmt-select-news_description', format).selected?).to be_true
      end
      context 'when save as markdown' do
        background do
          visit new_project_news_path(project_id: 'test')
          select_format('#pwfmt-select-news_description', 'markdown')
          find('#news_title').set 'test'
          find('#news_description').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as markdown', js: true do
          news = News.all.first
          visit news_path(news)
          expect(html_by_id('content')).to include markdown_text
        end
        scenario 'selected item of select box is markdown', js: true do
          news = News.all.first
          visit edit_news_path(news)
          expect(format_option('pwfmt-select-news_description', 'markdown').selected?).to be_true
        end
        context 'when change format to textile' do
          background do
            news = News.all.first
            visit edit_news_path(news)
            select_format('#pwfmt-select-news_description', 'textile')
            find('input[name=commit]').click
          end
          scenario 'view as textile', js: true do
            news = News.all.first
            visit news_path(news)
            expect(html_by_id('content')).to include textile_text
          end
          scenario 'selected item of select box is textile', js: true do
            news = News.all.first
            visit edit_news_path(news)
            expect(format_option('pwfmt-select-news_description', 'textile').selected?).to be_true
          end
        end
      end
      context 'when save as textile' do
        background do
          visit new_project_news_path(project_id: 'test')
          select_format('#pwfmt-select-news_description', 'textile')
          find('#news_title').set 'test'
          find('#news_description').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as textile', js: true do
          news = News.all.first
          visit news_path(news)
          expect(html_by_id('content')).to include textile_text
        end
        scenario 'selected item of select box is textile', js: true do
          news = News.all.first
          visit edit_news_path(news)
          expect(format_option('pwfmt-select-news_description', 'textile').selected?).to be_true
        end
        context 'when change format to markdown' do
          background do
            news = News.all.first
            visit edit_news_path(news)
            select_format('#pwfmt-select-news_description', 'markdown')
            find('input[name=commit]').click
          end
          scenario 'view as markdown', js: true do
            news = News.all.first
            visit news_path(news)
            expect(html_by_id('content')).to include markdown_text
          end
          scenario 'selected item of select box is markdown', js: true do
            news = News.all.first
            visit edit_news_path(news)
            expect(format_option('pwfmt-select-news_description', 'markdown').selected?).to be_true
          end
        end
      end
      context 'when markdown and textile' do
        background do
          # markdown
          visit new_project_news_path(project_id: 'test')
          select_format('#pwfmt-select-news_description', 'markdown')
          find('#news_title').set 'test'
          find('#news_description').set raw_text
          find('input[name=commit]').click

          # textile
          visit new_project_news_path(project_id: 'test')
          select_format('#pwfmt-select-news_description', 'textile')
          find('#news_title').set 'test'
          find('#news_description').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as markdown and view as textile in news list', js: true do
          visit project_news_index_path('test')
          expect(html_by_id('content')).to include markdown_text
          expect(html_by_id('content')).to include textile_text
        end
      end
    end
  end
end
