class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :comments
  has_many :scores

  def insert_to_redis
    # UNIX Timestamp
    self.created_at = self.updated_at = Time.now.to_i

    # redis hash name
    hash_name = "questions:#{self.question_id}"
    
    # hash key name
    key = $redis.incr 'next.answer.id'
    
    # serialize it into json
    value = MultiJson.encode(self.serializable_hash)

    # write into redis
    $redis.hset(hash_name, key, value)
  end
end
