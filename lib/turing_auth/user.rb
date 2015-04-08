module TuringAuth
  class User
    attr_reader :github_id, :github_name, :email, :github_token, :authed_at

    def initialize(attributes)
      attributes.symbolize_keys!
      @github_id = attributes[:github_id].to_i
      @github_name = attributes[:github_name]
      @email = attributes[:email]
      @github_token = attributes[:github_token]
      @authed_at = attributes[:authed_at] || Time.now
    end

    def valid?
      github_id && github_name && email && github_token
    end

    def as_json(options={})
      {github_id: github_id, github_name: github_name,
       email: email, github_token: github_token, authed_at: authed_at}
    end

    def to_json
      as_json.to_json
    end

    def inspect
      "Turing GH User: #{github_name}, gh id: #{github_id}, email #{email}, token: #{github_token}"
    end

    def gh_client
      Octokit::Client.new(:access_token => github_token)
    end

    def gh_teams
      @gh_teams ||= begin
                      gh_client.user_teams.map(&:id)
                    rescue Octokit::NotFound
                      []
                    end
    end

    def turing_member?
      (gh_teams & TURING_GH_TEAMS).any?
    end
  end
end
