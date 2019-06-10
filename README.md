# redmine_persist_wfmt
[![Build Status](https://secure.travis-ci.org/pinzolo/redmine_persist_wfmt.png)](http://travis-ci.org/pinzolo/redmine_persist_wfmt)

**redmine_persist_wfmt** is a plugin for Redmine that enables to select and save wiki format of various documents. (issue, document, wiki ...)

## Feature senario

1. Write document as Textile
1. Change wiki formatting setting to Markdown
1. Write document as Markdown
1. Users can view new documents as translated into Markdown
1. Users also can view old documents as translated into Textile

## Installation

Execute follow commands at your Redmine directory.

1. Clone to your Redmine's plugins directory
    ```sh
    $ git clone https://github.com/pinzolo/redmine_persist_wfmt.git plugins/redmine_persist_wfmt
    ```

1. Install dependency gems

    If you are already using Redmine, you probably only call `bundle`.

    ```sh
    $ bundle install --without test development
    ```

1. Execute migration

    ```sh
    $ bundle exec rake redmine:plugins:migrate NAME=redmine_persist_wfmt RAILS_ENV=production
    ```

1. Execute `persist_all` task

    This task saves all wiki formats that already exist.

    ```sh
    # FORMAT is required and must be 'textile' or 'markdown'
    $ bundle exec rake pwfmt:persist_all FORMAT=textile RAILS_ENV=production
    ```

1. Restart your Redmine

## Try this

This plugin contains `docker-compose.yml`, so you can try this by `docker-compose up`.

## Supported versions

* Ruby: 2.3.x, 2.4.x, 2.5.x, 2.6.x
* Redmine: 4.0.x

If you want to use this plugin with Redmine2 or 3, use **ver1** branch.

## Contributing

To check tests and rubocop, you need to merge `Gemfile.local` in this plugin to `Gemfile.local` of your Redmine.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Check pass all tests (`RAILS_ENV=test bundle exec rake redmine:plugins:test:ui`)
5. Check pass rubocop (`bundle exec rubocop plugins/redmine_persist_wfmt`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

## Changelog

* v0.5.0 (2014-05-13 JST): Pre release
* v1.0.0 (2014-05-28 JST): First major release
* v1.1.0 (2014-06-23 JST): Enable preview and refactoring
* v2.0.0 (2019-05-04 JST): Compatible with Redmine4
* v2.0.1 (2019-05-28 JST): Safely toolbar scripts update
