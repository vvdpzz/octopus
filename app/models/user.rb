class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :uuid, :email, :password, :password_confirmation, :remember_me,
                  :me, :realname, :username, :me, :subscribe_count, :following_count,
                  :follower_count, :publish_q_count, :publish_a_count, :credit, :money
  
  has_one :profile
  has_many :credits
  
  has_many :questions
  has_many :answers
  
  has_many :messages
  has_many :notifications
  
  has_many :transactions

end
