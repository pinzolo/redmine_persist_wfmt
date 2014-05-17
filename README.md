# redmine_persist_wfmt

redmine_persist_wfmt is a plugin for Redmine that keep and valid viewing wiki format of various documents. (issue, document, wiki ...)

## Feature senario

1. Write document as Textile
1. Change wiki formatting setting to Markdown
1. Write document as Markdown
1. Users can view new documents as translated into Markdown
1. Users also can view old documents as translated into Textile

## Installation

Execute follow commands at your Redmine directory.

### 1. Clone to your Redmine's plugins directory:

```shell
$ git clone https://gihub.com/pinzolo/redmine_persist_wfmt.git plugins/redmine_persist_wfmt
```

### 2. Execute migration:

```shell
$ bundle exec rake redmine:plugins:migrate NAME=redmine_persist_wfmt RAILS_ENV=production
```

### 3. Execute persist_all task:

```shell
# FORMAT is required and must be 'textile' or 'markdown'
$ bundle exec rake pwfmt:persist_all FORMAT=textile RAILS_ENV=production
```

### 4. Restart your Redmine:

```shell
# In case of using passenger
$ touch tmp/restart.txt
```

## Caution

Preview and wiki toolbar are not changed by this plugin.
