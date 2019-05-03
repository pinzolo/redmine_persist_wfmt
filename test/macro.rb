module Pwfmt::Testing::Macro
  def select_box_selected?(id, value)
    find_by_id(id).find("option[value=#{value}]").selected?
  end

  def markdown_selected?(select_box_id)
    select_box_selected?(select_box_id, 'markdown')
  end

  def textile_selected?(select_box_id)
    select_box_selected?(select_box_id, 'textile')
  end

  def select_format(select_box_id, format)
    find_by_id(select_box_id).select(select_text_for(format))
  end

  def select_textile(select_box_id)
    select_format(select_box_id, 'textile')
  end

  def select_markdown(select_box_id)
    select_format(select_box_id, 'markdown')
  end

  def html_include?(id, html)
    find_by_id(id)['innerHTML'].include?(html)
  end

  def markdown_include?(id)
    html_include?(id, html_for('markdown'))
  end

  def textile_include?(id)
    html_include?(id, html_for('textile'))
  end

  def wait_for_preview
    sleep(2)
  end

  def sign_in_as_test_user
    create_test_user

    visit signin_path
    find_by_id('username').set('test')
    find_by_id('password').set('foobarbaztest')
    find('input[name=login]').click
  end

  def save_document_as(format)
    visit new_project_document_path(project_id: project_id)
    select_format('pwfmt-select-document_description', format)
    find_by_id('document_title').set('test')
    find_by_id('document_description').set(text_for(format))
    find('#new_document input[name=commit]').click
  end

  def save_news_as(format)
    visit new_project_news_path(project_id: project_id)
    select_format('pwfmt-select-news_description', format)
    find_by_id('news_title').set('test')
    find_by_id('news_description').set(text_for(format))
    find('#news-form input[name=commit]').click
  end

  def save_news_comment_as(format)
    visit news_path(News.first)
    find('a', text: 'Add a comment').click
    select_format('pwfmt-select-comment_comments', format)
    find_by_id('comment_comments').set(text_for(format))
    find('#add_comment_form input[name=commit]').click
  end

  def save_project_as(format)
    visit new_project_path
    prj_id = "test_#{format}"
    select_format('pwfmt-select-project_description', format)
    find_by_id('project_name').set(prj_id)
    find_by_id('project_description').set(text_for(format))
    find_by_id('project_identifier').set(prj_id)
    find('#new_project input[name=commit]').click
  end

  def save_message_as(format)
    visit new_board_message_path(Board.first)
    find_by_id('message_subject').set('test')
    find_by_id('message_content').set(text_for(format))
    select_format('pwfmt-select-message_content', format)
    find('#message-form input[name=commit]').click
  end

  def save_wiki_page_as(format)
    visit "projects/#{project_id}/wiki"
    find_by_id('content_text').set(text_for(format))
    select_format('pwfmt-select-content_text', format)
    find('#wiki_form input[name=commit]').click
  end
end
