require "turing_auth/version"
require "turing_auth/teams"
require "turing_auth/user"
require "turing_auth/current_user"

module TuringAuth
  def self.client_id=(client_id)
    @@client_id = client_id
  end

  def self.client_id
    @@client_id
  end

  def self.client_secret=(client_secret)
    @@client_secret = client_secret
  end

  def self.client_secret
    @@client_secret
  end

  def self.init!
    if defined?(Rails) && defined?(OmniAuth::Builder)
      Rails.application.config.middleware.use OmniAuth::Builder do
        provider :developer unless Rails.env.production?
        provider :github, TuringAuth.client_id, TuringAuth.client_secret, scope: "user"
      end
    else
      raise "TuringAuth currently only supports Rails apps; make sure you're using it in a Rails app."
    end
  end
end
