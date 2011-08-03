class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  belongs_to :answer
  
  validates_presence_of :content
  validates_length_of :content, :maximum => 140
end
