
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class RemoteAuthenticatable < Authenticatable
      def authenticate!
        if params[:user]
          user = User.authenticate_by_email email, password, remember_me
          if user
            success!(user)
          else
            fail(:invalid_login)
          end
        end
      end

      def remember_me
        params[:user][:remember_me]
      end
      def email
        params[:user][:email]
      end
      def pin
        params[:user][:pin].to_i
      end
      def password
        params[:user][:password]
      end

    end
  end
end
