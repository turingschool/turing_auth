require "octokit"

module TuringAuth
  class User
    attr_reader :github_id, :github_name, :email, :github_token, :authed_at

    def initialize(attributes)
      attributes.symbolize_keys!
      @github_id    = attributes[:github_id].to_i if attributes[:github_id]
      @github_name  = attributes[:github_name]
      @email        = attributes[:email]
      @github_token = attributes[:github_token]
      @authed_at    = attributes[:authed_at] || Time.now
    end

    def valid?
      [github_id, github_name, github_token].none?(&:nil?)
    end

    def as_json(options = {})
      {
        github_id:    github_id,
        github_name:  github_name,
        email:        email,
        github_token: github_token,
        authed_at:    authed_at
      }
    end

    def to_json
      as_json.to_json
    end

    def inspect
      "Turing User: github_name: #{github_name}, github_id: #{github_id}, email: #{email}, token: #{github_token}"
    end

    def turing_member?
      TuringAuth::Teams.new.authorized_member_ids.include?(github_id.to_i)
    end

    def admin?
      TuringAuth::Teams.new.authorized_admins.include?(github_name)
    end
  end
end
