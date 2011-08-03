class Message < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :content
  validates_length_of :content, :maximum => 140
  
  validates_presence_of :sender_id
  validates_presence_of :receiver_id
end