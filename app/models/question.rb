class Question < ActiveRecord::Base
  belongs_to :user
  
  has_many :answers
  has_many :credits
  
  validates_length_of :title, :within => 10..70
  validates_presence_of :content
  
  def self.questions_list
    # wait for the storage of questions
  end
  
  def get_all_answers_from_redis
    hash_name = "questions:#{self.id}"
    $redis.hvals(hash_name)
  end
  
  def insert_to_redis
    # UNIX Timestamp
    question.created_at = question.updated_at = Time.now.to_i
    
    # use redcarpet to render context
    question.markdown = Helper.markdown(question.content)
    
    # TODO: wait to use real UUID
    uuid = $redis.incr 'next.question.id'
    
    # serialize it into json
    serialized_data = MultiJson.encode(question.serializable_hash)
    
    # write into redis
    $redis.set("questions:#{uuid}", serialized_data)
  end
end
