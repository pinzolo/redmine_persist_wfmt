module Features
  module Macros
    def sign_in_as_admin
      create_admin

      visit signin_path
      find('#username').set 'admin'
      find('#password').set 'adminpass'
      find('input[name=login]').click
    end

    def create_project
      visit new_project_path
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

    def format_option(select_box_id, format)
      find("##{select_box_id}").find("option[value=#{format}]")
    end

    def create_project
      visit new_project_path
      select_format('#pwfmt-select-project_description', 'markdown')
      find('#project_name').set 'test'
      find('#project_identifier').set 'test'
      find('input[name=commit]').click
    end
  end
end
