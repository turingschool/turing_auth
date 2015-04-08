require "turing_auth/version"
require "turing_auth/teams"
require "turing_auth/user"
require "turing_auth/current_user"
require "turing_auth/controller_methods"

module TuringAuth
  def self.init!
    if defined?(Rails) && defined?(OmniAuth::Builder)
      Rails.application.config.middleware.use OmniAuth::Builder do
        provider :developer unless Rails.env.production?
        provider :github, ENV['NAMER_GITHUB_ID'], ENV['NAMER_GITHUB_SECRET'], scope: "user"
      end
    else
      raise "TuringAuth currently only supports Rails apps; make sure you're using it in a Rails app."
    end
  end
end
