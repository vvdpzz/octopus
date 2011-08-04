class Question < ActiveRecord::Base
  belongs_to :user
  
  has_many :answers
  has_many :scores
  
  validates_length_of :title, :within => 10..70
  validates_presence_of :content
  
  def get_all_answers_from_redis
    hash_name = "questions:#{self.id}"
    $redis.hvals(hash_name)
  end
end
