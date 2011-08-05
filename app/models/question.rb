class Question < ActiveRecord::Base
  belongs_to :user
  
  has_many :answers
  has_many :credits
  
  # validates_length_of :title, :within => 10..70
  
  validate :credit_enough, :money_enough
  
  def self.questions_list
    hash_name = "questions"
    questions = $redis.hvals(hash_name)
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
  
  def is_free?
    self.credit == 0 && self.money == 0.00
  end
    
  # validations
  def credit_enough
    # 需 要 获 取 当 前 用 户 的 user_id
    current_user_credit = $redis.hget("users:#{current_user.id}", "credit")
    errors.add(:credit, "you do not have enough credit to pay.") if current_user_credit < self.credit
  end
  
  def money_enough
    # 需 要 获 取 当 前 用 户 的 user_id
    current_user_money = $redis.hget("users:#{current_user.id}", "money")
    errors.add(:money, "you do not have enough money to pay.") if current_user_money < self.money
  end
end
