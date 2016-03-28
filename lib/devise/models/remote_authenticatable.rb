#=begin
#require 'devise/strategies/database_authenticatable'
#require 'httparty'

module Devise
  module Models
    module RemoteAuthenticatable
      extend ActiveSupport::Concern
#      extend DatabaseAuthenticatable

            include Devise::Models::RemoteCommon
#        REMOTE_AUTH_URL = 'https://ph4-my-vit2.c9users.io/u/remote_auth.json'

        #def self.included(klass)
        #    puts "#{self.class} has been included in class #{klass}"
        #end

        def authenticatable_salt
            #puts "!!!!!! authenticatable_salt #{encrypted_password[0,29]}"
            #encrypted_password[0,29] if encrypted_password
            self.salt
        end


#=begin
      module ClassMethods

            def authenticate_by_email email, password, remember_me
                data = remote_request( 'authenticate_by_email', {
                    email: email,
                    password: password
                })
                user_data = data['user_data']
                user_data['remember_me'] = remember_me
                save_user_data_from_auth user_data
            end

            def serialize_from_session key, salt
#                puts "!!!!!!! serialize_from_session #{key}, #{salt}"
                data = remote_request( 'serialize_from_session', {
                    key: key,
                    salt: salt
                })
                user_data = data['user_data']
                save_user_data_from_auth user_data
            end

    end
#=end

    end
  end
end

#=end
