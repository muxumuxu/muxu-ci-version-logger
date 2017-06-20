require 'version_logger/railtie' if defined?(Rails)

module VersionLogger
  class << self
    attr_accessor :configuration
  end

  def self.configure
    @configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :project_name,
                  :slack_channel,
                  :slack_user
  end
end
