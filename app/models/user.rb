class User < ActiveRecord::Base
  require 'httparty'

#        REMOTE_URL_BASE = 'https://ph4-my-vit2.c9users.io/'
        REMOTE_URL_BASE = Rails.configuration.x.sites.my
        USER_RPC_URL = REMOTE_URL_BASE + '/u/api.json'

  has_many :contexts
  has_many :submissions


#    extend Devise::Models

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
#  devise :remote_authenticatable, :registerable, :rememberable
  devise :remote_authenticatable, :remote_rememberable
#  devise :database_authenticatable
#  devise :database_authenticatable, :registerable,
#  devise :remote_authenticatable, :registerable,
#         :recoverable, :rememberable, :trackable, :validatable
#    devise :external_authenticatable, :rememberable #, :trackable#, :validatable

    attr_accessor :salt, :avatar_url

    validates :fname, presence: true
    validates :lname, presence: true

    def full_name
        "#{fname} #{mname} #{lname}".strip # <#{email}>"
    end

    def self.r_find id
      rez = User.remote_api_request('get', {user_id: id})
      #puts rez
      u = User.find(id) rescue nil
      if u
        u.update(rez)
      else
        u = self.new rez
      end
      u
    end
    def get_followed
      User.remote_api_request 'get_followed', {user_id: self.id}
    end

            def self.remote_api_request op, data
                HTTParty.post(USER_RPC_URL,
                    body: {
                        op: op,
                        data: data
                    }.to_json,
                    :headers => { 'Content-Type' => 'application/json' }
                )['result'] rescue nil
            end


end
