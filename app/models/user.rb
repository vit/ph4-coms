class User < ActiveRecord::Base

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


end
