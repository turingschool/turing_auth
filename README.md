# TuringAuth

Shared authentication library for authenticating with turing platform
applications using GitHub Oauth and GitHub teams.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'turing_auth'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install turing_auth

## Usage

### Provided controller filters (Rails)

### Old user id mapping

### ENV keys -- github secret and github key

To use the Oauth portions of the gem, you need to
provide an oauth Client ID and Client Secret. This looks like:

```
TuringAuth.client_id = "my client id"
TuringAuth.client_secret = "my client secret"
```

Additionally, an admin token for the Turing org is need in
order to access Turing github team data and determine whether
a user is a member of an authorized team:

```
TuringAuth.admin_token = "my admin token"
```

Finally, you need to call `TuringAuth.init!` to take the provided
keys and activate the Github omniauth provider. All together this looks like:

```
TuringAuth.client_id = "my client id"
TuringAuth.client_secret = "my client secret"
TuringAuth.admin_token = "my admin token"
TuringAuth.init!
```

An application initializer is usually a good place to do this configuration.

### Authorizing New Teams

Authorized teams are stored in `TuringAuth::Teams.authorized_teams`
as a mapping of team name to github team id. To authorize a new
team it needs to be added to this mapping.

To see the list of available Turing teams that you can add,
use the `TuringAuth::Teams#list_teams` method. Note that you'll need
to configure the Turing admin token as mentioned above
in order to make this api query.

Once you have a list of teams, find the one you want to authorize,
and add its name/id mapping to the list.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/turing_auth/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
