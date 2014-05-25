require_relative '../spec_helper'

feature 'Welcome text' do
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
        visit settings_path
        expect(format_option('pwfmt-select-settings_welcome_text', format).selected?).to be_true
      end
      context 'when save as markdown' do
        background do
          visit settings_path
          select_format('#pwfmt-select-settings_welcome_text', 'markdown')
          find('#settings_welcome_text').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as markdown', js: true do
          visit home_path
          expect(html_by_id('content')).to include markdown_text
        end
        scenario 'selected item of select box is markdown', js: true do
          visit settings_path
          expect(format_option('pwfmt-select-settings_welcome_text', 'markdown').selected?).to be_true
        end
      end
      context 'when save as textile' do
        background do
          visit settings_path
          select_format('#pwfmt-select-settings_welcome_text', 'textile')
          find('#settings_welcome_text').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as textile', js: true do
          visit home_path
          expect(html_by_id('content')).to include textile_text
        end
        scenario 'selected item of select box is textile', js: true do
          visit settings_path
          expect(format_option('pwfmt-select-settings_welcome_text', 'textile').selected?).to be_true
        end
      end
    end
  end
end
