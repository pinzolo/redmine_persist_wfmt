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
  end
end
