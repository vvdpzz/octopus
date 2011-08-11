class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :comments
  has_many :credits
  
  # validations
  validates_presence_of :content
end