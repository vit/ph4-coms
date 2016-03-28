#=begin
#require 'devise/strategies/database_authenticatable'
#require 'httparty'

require 'devise/strategies/remote_rememberable'
require 'devise/hooks/rememberable'
require 'devise/hooks/forgetable'

=begin
Warden::Manager.after_set_user except: :fetch do |record, warden, options|
  scope = options[:scope]
#    puts "Conditions: #{record.respond_to?(:remember_me)} | #{options[:store]} | #{record.remember_me} | #{warden.authenticated?(scope)}"
  if record.respond_to?(:remember_me) && options[:store] != false &&
     record.remember_me && warden.authenticated?(scope)
    Devise::Hooks::Proxy.new(warden).remember_me(record)
#    puts "true"
  end
#    puts "Record: #{record.inspect}"
#    puts "Scope: #{scope}"
    #puts ""
#    raise "Warden::Manager.after_set_user"
end
=end


module Devise
  module Models
    module RemoteRememberable
      extend ActiveSupport::Concern
#      extend DatabaseAuthenticatable

        attr_accessor :remember_me, :extend_remember_period

#        included do
            attr_accessor :remember_token, :remember_created_at
#        end


      def self.required_fields(klass)
        raise "self.required_fields"
        [:remember_created_at]
      end

        def remember_me!(*)
#            data = RemoteCommon.remote_request( 'remember_me!', {
            data = self.class.remote_request( 'remember_me!', {
                id: self.id
            })
            remember_data = data['remember_data']

            self.remember_token = remember_data['remember_token']
            self.remember_created_at = remember_data['remember_created_at']
            save(validate: false) if self.changed?
        end


      # If the record is persisted, remove the remember token (but only if
      # it exists), and save the record without validations.
      def forget_me!
            data = self.class.remote_request( 'forget_me!', {
                id: self.id
            })
            remember_data = data['remember_data']
#        return unless persisted?
#        self.remember_token = nil if respond_to?(:remember_token)
#        self.remember_created_at = nil if self.class.expire_all_remember_me_on_sign_out
#        save(validate: false)
#        raise "forget_me!"
      end

      def remember_expires_at
        self.class.remember_for.from_now
#        raise "remember_expires_at"
      end

      def rememberable_value
          raise "rememberable_value"
#        if respond_to?(:remember_token)
#          remember_token
#        elsif respond_to?(:authenticatable_salt) && (salt = authenticatable_salt.presence)
#          salt
#        else
#          raise "authenticable_salt returned nil for the #{self.class.name} model. " \
#            "In order to use rememberable, you must ensure a password is always set " \
#            "or have a remember_token column in your model or implement your own " \
#            "rememberable_value in the model with custom logic."
#        end
      end

      def remember_me?(token, generated_at)
        raise "remember_me?"
#        # TODO: Normalize the JSON type coercion along with the Timeoutable hook
#        # in a single place https://github.com/plataformatec/devise/blob/ffe9d6d406e79108cf32a2c6a1d0b3828849c40b/lib/devise/hooks/timeoutable.rb#L14-L18
#        if generated_at.is_a?(String)
#          generated_at = time_from_json(generated_at)
#        end

        # The token is only valid if:
        # 1. we have a date
        # 2. the current time does not pass the expiry period
        # 3. the record has a remember_created_at date
        # 4. the token date is bigger than the remember_created_at
        # 5. the token matches
#        generated_at.is_a?(Time) &&
#         (self.class.remember_for.ago < generated_at) &&
#         (generated_at > (remember_created_at || Time.now).utc) &&
#         Devise.secure_compare(rememberable_value, token)
      end

        def rememberable_options
            self.class.rememberable_options
        end
        def after_remembered
        end

            include Devise::Models::RemoteCommon


#            def rememberable_options
#                self.class.rememberable_options
#            end
#            def after_remembered
#            end

        module ClassMethods
            
            def remember_token #:nodoc:
                raise "remember_token"
#               loop do
#                   token = Devise.friendly_token
#                   break token unless to_adapter.find_first({ remember_token: token })
#                end
            end
            

            # Create the cookie key using the record id and remember_token
            def serialize_into_cookie(record)
            #    [record.to_key, record.rememberable_value, Time.now.utc.to_f.to_s]
                data = remote_request( 'serialize_into_cookie', {
                    id: record.id
                })
                data['result_array']
                #user_data = data['user_data']
                #save_user_data_from_auth user_data
            end

            # Recreate the user based on the stored cookie
            def serialize_from_cookie(*args)
                data = remote_request( 'serialize_from_cookie', {
                    args: args
                })
                user_data = data['user_data']
                save_user_data_from_auth user_data
            end

            private
            
            # TODO: extend_remember_period is no longer used
            Devise::Models.config(self, :remember_for, :extend_remember_period, :rememberable_options, :expire_all_remember_me_on_sign_out)


        end


    end
  end
end

#=end
