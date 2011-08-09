class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :comments
  has_many :credits
  
  # validations
  validates_presence_of :content
  
  def insert_to_redis
    # UNIX Timestamp
    self.created_at = self.updated_at = Time.now.to_i

    # redis hash name
    hash_name = "q:#{self.question_id}.as"
    
    # hash key name
    key = $redis.incr 'next.answer.id'
    
    # serialize it into json
    value = MultiJson.encode(self.serializable_hash)

    # write into redis
    $redis.hset(hash_name, key, value)
    
    # answer user info
    $redis.set("a:#{key}.uid", self.user_id)
  end
end