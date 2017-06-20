require 'test_helper'
require 'rake'

# Requires the presence of test/dummy/config/initializers/version_logger.rb

class VersionLogger::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, VersionLogger
  end

  context 'VersionLogger' do
    context '.configuration' do
      context '.project_name' do
        should 'returns the app project name if set' do
          assert_equal 'dummy-web', VersionLogger.configuration.project_name
        end
      end

      context '.slack_channel' do
        should 'returns a slack channel if set' do
          assert_equal '#dummy-slack', VersionLogger.configuration.slack_channel
        end
      end

      context '.slack_user' do
        should 'returns a slack user if set' do
          assert_equal 'Bamboo', VersionLogger.configuration.slack_user
        end
      end
    end
  end
end
