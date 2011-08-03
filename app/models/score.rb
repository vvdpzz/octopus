class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  belongs_to :answer
  
  validates_numericality_of :value, :only_integer => true
end
