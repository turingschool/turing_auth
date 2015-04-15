# include this module into a rails controller
# to add current_user functionality.
module TuringAuth
  module CurrentUser
    def current_user
      return nil unless session[:current_user]
      @current_user ||= TuringAuth::User.new(session[:current_user])
    end

    def logged_in?
      !!current_user
    end

    def self.included(klass)
      klass.send(:helper_method, :current_user) if klass.respond_to?(:helper_method)
      klass.send(:helper_method, :logged_in?) if klass.respond_to?(:helper_method)
    end
  end
end
