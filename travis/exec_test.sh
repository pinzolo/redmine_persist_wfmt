#! /bin/sh

export REDMINE_LANG=en
export RAILS_ENV=test

# Initialize redmine
bundle exec rake generate_secret_token
bundle exec rake db:migrate
bundle exec rake redmine:load_default_data

# Copy assets & execute plugin's migration
bundle exec rake redmine:plugins NAME=redmine_persist_wfmt

# Initialize RSpec
bundle exec rails g rspec:install

if [ $TARGET = "redmine" ]; then
  # Execute redmine tests
  bundle exec rake ci
else
  # Execute plugin test by RSpec
  bundle exec rspec plugins/redmine_bx/spec -c
fi

