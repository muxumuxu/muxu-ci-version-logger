# VersionLogger 1.2.0

Handles project version number and changelog.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'version_logger', git: 'git@github.com:muxumuxu/muxu-ci-version-logger.git'
```

And then execute:
```shell
bundle
```

Then use the generator as follow:

```shell
rails generate version_logger:setup
```

The following files will be affected :

- `config/initializers/version.rb`: Will contain the app version number.
- `config/initializers/version_logger.rb`: Will contain the config defined during the setup (`slack_channel`, `slack_user`, `project_name`). `project_name` is the name used when pushing a message to Slack.
- `CHANGELOG.md`: A skeleton changelog will be created if the file is missing.
- `Gemfile`: The `vandamme` gem will be installed for dev and test.

## Usage

### Get the app version

```shell
rails version_logger:version

#=> 0.0.1
```

### Increment the version

```shell
rails version_logger:increment_patch
```

Version is now `0.0.2`

### Update changelog

```shell
rails version_logger:update_changelog
```

All `Unreleased` items are now in `### v0.0.2 / 2016-01-01`

## Tests

Run the tests with `bin/test`.

The rake tasks and generators _are not tested yet_.
