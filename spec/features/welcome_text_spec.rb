require_relative '../spec_helper'

feature 'Welcome text' do
  background do
    load_default_data
    sign_in_as_admin
  end

  context 'when text_formatting setting is textile' do
    background do
      Setting.text_formatting = 'textile'
    end
    scenario 'selected item of select box is textile when first visited', js: true do
      visit settings_path
      textile_option = find('#pwfmt-select-settings_welcome_text').find("option[value=textile]")
      expect(textile_option.selected?).to be_true
    end
    scenario 'save as markdown, view as markdown', js: true do
      visit settings_path
      select_format('#pwfmt-select-settings_welcome_text', 'markdown')
      find('#settings_welcome_text').set raw_text
      find('input[name=commit]').click
      visit home_path
      expect(html_by_id('content')).to include markdown_text
    end
    scenario 'save as textile, view as textile', js: true do
      visit settings_path
      select_format('#pwfmt-select-settings_welcome_text', 'textile')
      find('#settings_welcome_text').set raw_text
      find('input[name=commit]').click
      visit home_path
      expect(html_by_id('content')).to include textile_text
    end
  end
end
