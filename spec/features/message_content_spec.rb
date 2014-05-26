require_relative '../spec_helper'

feature 'Message content' do
  background do
    load_default_data
    sign_in_as_admin
    create_project
    create_forum
  end
  Redmine::WikiFormatting.format_names.each do |format|
    context "when text_formatting setting is #{format}" do
      background do
        Setting.text_formatting = format
      end
      scenario "selected item of select box is #{format} when first visited", js: true do
        board = Board.all.first
        visit new_board_message_path(board)
        expect(format_option('pwfmt-select-message_content', format).selected?).to be_true
      end
      context 'when save as markdown' do
        background do
          board = Board.all.first
          visit new_board_message_path(board)
          select_format('#pwfmt-select-message_content', 'markdown')
          find('#message_subject').set 'test'
          find('#message_content').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as markdown', js: true do
          board = Board.all.first
          visit board_message_path(board.messages.first, board_id: board)
          expect(html_by_id('content')).to include markdown_text
        end
        scenario 'selected item of select box is markdown', js: true do
          board = Board.all.first
          visit "/boards/#{board.id}/topics/#{board.messages.first.id}/edit"
          expect(format_option('pwfmt-select-message_content', 'markdown').selected?).to be_true
        end
        context 'when change format to textile' do
          background do
            board = Board.all.first
            visit "/boards/#{board.id}/topics/#{board.messages.first.id}/edit"
            select_format('#pwfmt-select-message_content', 'textile')
            find('input[name=commit]').click
          end
          scenario 'view as textile', js: true do
            board = Board.all.first
            visit board_message_path(board.messages.first, board_id: board)
            expect(html_by_id('content')).to include textile_text
          end
          scenario 'selected item of select box is textile', js: true do
            board = Board.all.first
            visit "/boards/#{board.id}/topics/#{board.messages.first.id}/edit"
            expect(format_option('pwfmt-select-message_content', 'textile').selected?).to be_true
          end
        end
      end
      context 'when save as textile' do
        background do
          board = Board.all.first
          visit new_board_message_path(board)
          select_format('#pwfmt-select-message_content', 'textile')
          find('#message_subject').set 'test'
          find('#message_content').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as textile', js: true do
          board = Board.all.first
          visit board_message_path(board.messages.first, board_id: board)
          expect(html_by_id('content')).to include textile_text
        end
        scenario 'selected item of select box is textile', js: true do
          board = Board.all.first
          visit "/boards/#{board.id}/topics/#{board.messages.first.id}/edit"
          expect(format_option('pwfmt-select-message_content', 'textile').selected?).to be_true
        end
        context 'when change format to markdown' do
          background do
            board = Board.all.first
            visit "/boards/#{board.id}/topics/#{board.messages.first.id}/edit"
            select_format('#pwfmt-select-message_content', 'markdown')
            find('input[name=commit]').click
          end
          scenario 'view as markdown', js: true do
            board = Board.all.first
            visit board_message_path(board.messages.first, board_id: board)
            expect(html_by_id('content')).to include markdown_text
          end
          scenario 'selected item of select box is markdown', js: true do
            board = Board.all.first
            visit "/boards/#{board.id}/topics/#{board.messages.first.id}/edit"
            expect(format_option('pwfmt-select-message_content', 'markdown').selected?).to be_true
          end
        end
      end
      context 'when markdown and textile' do
        background do
          # root message
          board = Board.all.first
          visit new_board_message_path(board)
          find('#message_subject').set 'test'
          find('#message_content').set 'test'
          find('input[name=commit]').click

          # markdown reply
          visit board_message_path(board.messages.first, board_id: board)
          find('a[href="#"]').click
          select_format('#pwfmt-select-message_content', 'markdown')
          find('#message_subject').set 'test'
          find('#message_content').set raw_text
          find('input[name=commit]').click

          # textile reply
          visit board_message_path(board.messages.first, board_id: board)
          find('a[href="#"]').click
          select_format('#pwfmt-select-message_content', 'textile')
          find('#message_subject').set 'test'
          find('#message_content').set raw_text
          find('input[name=commit]').click
        end
        scenario 'view as markdown and view as textile in replies', js: true do
          board = Board.all.first
          visit board_message_path(board.messages.first, board_id: board)
          board.messages.first.children.each do |msg|
            msg.load_wiki_format!
            if msg.content.pwfmt.format == 'markdown'
              expect(html_by_id("message-#{msg.id}")).to include markdown_text
            elsif msg.content.pwfmt.format == 'textile'
              expect(html_by_id("message-#{msg.id}")).to include textile_text
            end
          end
        end
      end
    end
  end
end
