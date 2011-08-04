class Question < ActiveRecord::Base
  belongs_to :user
  
  has_many :answers
  has_many :credits
  
  validates_length_of :title, :within => 10..70
  validates_presence_of :content
  
  validate :credit_enough, :money_enough
  
  def self.questions_list
    # wait for the storage of questions
  end
  
  def get_all_answers_from_redis
    hash_name = "questions:#{self.id}"
    $redis.hvals(hash_name)
  end
  
  def insert_to_redis
    # UNIX Timestamp
    self.created_at = self.updated_at = Time.now.to_i
    
    # redis hash name
    hash_name = "questions"
    
    # hash key name
    key = $redis.incr 'next.question.id'
    
    self.id = key
    
    # serialize it into json
    value = MultiJson.encode(self.serializable_hash)

    # write into redis
    $redis.hset(hash_name, key, value)
  end
  
  # validations
  def credit_enough
    errors.add(:credit, "you do not have enough credit to pay.") if self.user.credit < self.credit
  end
  
  def money_enough
    errors.add(:money, "you do not have enough money to pay.") if self.user.money < self.money
  end
end
