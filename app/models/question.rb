class Question < ActiveRecord::Base
  belongs_to :user
  
  has_many :answers
  has_many :scores
  
  validates_length_of :title, :within => 10..70
  validates_presence_of :content
  
  def find_all_answers
    hash_name = "question:#{self.id}"
    $redis.hvals(hash_name)
  end
end
