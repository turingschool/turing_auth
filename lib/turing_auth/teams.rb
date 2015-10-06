module TuringAuth
  class Teams
    def self.authorized_teams
      {
        "1406"   => 1109782,
        "1407"   => 1171200,
        "1409"   => 1427798,
        "1410"   => 1427761,
        "1412"   => 1469133,
        "1502"   => 1469166,
        "1503"   => 1469162,
        "1505"   => 1805558,
        "owners" => 879375
      }
    end

    def gh_client
      @gh_client ||= Octokit::Client.new(:access_token => TuringAuth.admin_token)
    end

    def list_teams
      gh_client.organization_teams("turingschool")
    end

    def authorized_team_ids
      self.class.authorized_teams.values
    end

    def authorized_member_ids
      # fetch an array of github user ids for all members of
      # the authorized teams; if a user's GH id appears in this list
      # then they are authed for the turing "member" platform
      @authorized_member_ids ||= authorized_team_ids.flat_map do |team_id|
        gh_client.team_members(team_id)
      end.map(&:id).map(&:to_i).uniq
    end
  end
end
