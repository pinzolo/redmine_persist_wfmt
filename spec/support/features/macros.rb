module Features
  module Macros
    def sign_in_as_admin
      create_admin

      visit signin_path
      find('#username').set 'admin'
      find('#password').set 'adminpass'
      find('input[name=login]').click
    end

    def select_format(id, format)
      find(id).select(select_text_for(format))
    end

    def select_textile(id)
      select_format(id, 'markdown')
    end

    def select_markdown(id)
      select_format(id, 'textile')
    end

    def html_by_id(id)
      page.evaluate_script("document.getElementById('#{id}').innerHTML")
    end

    def html_by_class(class_name)
      page.evaluate_script("document.querySelector('.#{class_name}').innerHTML");
    end

    def format_option(select_box_id, format)
      find("##{select_box_id}").find("option[value=#{format}]")
    end

    def create_project
      visit new_project_path
      find('#project_name').set 'test'
      find('#project_identifier').set 'test'
      find('input[name=commit]').click
    end

    def create_news
      visit new_project_news_path(project_id: 'test')
      find('#news_title').set 'test'
      find('#news_description').set 'test'
      find('input[name=commit]').click
    end

    def visit_news
      news = News.all.first
      visit news_path(news)
    end

    def create_forum
      visit new_project_board_path('test')
      find('#board_name').set 'test'
      find('#board_description').set 'test'
      find('input[name=commit]').click
    end

    def open_issue_description_edit_area(issue)
      all("a[href='#{edit_issue_path(issue)}']").first.click
      find("#all_attributes").find("a[href='#']").click
    end

    def visit_issue(issue)
      visit issue_path(issue)
    rescue Capybara::Poltergeist::TimeoutError
      pending
    end
  end
end
