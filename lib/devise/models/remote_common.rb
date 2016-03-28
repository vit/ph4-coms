require 'httparty'

module Devise
module Models
    module RemoteCommon
        extend ActiveSupport::Concern
        REMOTE_AUTH_URL = 'https://ph4-my-vit2.c9users.io/u/remote_auth.json'

#        attr_accessor :remember_me, :extend_remember_period

        module ClassMethods

            # Common Methods

            def remote_request op, data
                HTTParty.post(REMOTE_AUTH_URL,
                    body: {
                        op: op,
                        data: data
                    }.to_json,
                    :headers => { 'Content-Type' => 'application/json' }
                )
            end

            def save_user_data_from_auth user_data
                if user_data
#                    puts "!!!!!! save_user_data_from_auth"
                    user = User.find_by(id: user_data['id'])
#                    puts user.inspect
                    user = User.create(
                        sid: user_data['sid'],
                        id: user_data['id'],
                        email: user_data['email'],
                        fname: user_data['fname'],
                        mname: user_data['mname'],
                        lname: user_data['lname']
                    ) unless user
#                    puts user.full_name
                    user.salt = user_data['salt']
                    user.remember_me = user_data['remember_me']
                    user
                else
                    nil
                end
            end

            # Authenticatable Methods

            # Rememberable Methods


        end
    end
end
end

