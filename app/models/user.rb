class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :me, :realname, :username, :me, :subscribe_count, :following_count,
                  :follower_count, :publish_q_count, :publish_a_count, :credit, :money
  
  has_one :profile
  has_many :credits
  
  has_many :questions
  has_many :answers
  
  has_many :messages
  has_many :notifications
  
  has_many :transactions
  
  def pay_for_q_or_a(payment, amount)
    amount = $redis.hget("users:#{self.id}", payment).to_i - amount
    $redis.hset("users:#{self.id}", payment, amount)
  end
  
  def pay_for_q_and_a
    
  end
end
