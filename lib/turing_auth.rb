require "turing_auth/version"
require "turing_auth/teams"
require "turing_auth/user"
require "turing_auth/current_user"
require "omniauth"
require "omniauth/builder"
require "omniauth-github"

module TuringAuth
  def self.admin_token=(token)
    @@admin_token = token
  end

  def self.admin_token
    @@admin_token
  end

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

  def self.verify_configuration!
    if [admin_token, client_id, client_secret].any?(&:nil?)
      raise "Oops, looks like some config is missing. Need to set: TuringAuth.admin_token, TuringAuth.client_id, TuringAuth.client_secret"
    end
  end

  def self.verify_env_dependencies!
    unless defined?(Rails) && defined?(OmniAuth::Builder)
      raise "TuringAuth missing required dependencies Rails and Omniauth::Builder"
    end
  end

  def self.init_omniauth!
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :developer unless Rails.env.production?
      provider :github, TuringAuth.client_id, TuringAuth.client_secret
    end
  end

  def self.init!
    verify_configuration!
    verify_env_dependencies!
    init_omniauth!
  end
end
