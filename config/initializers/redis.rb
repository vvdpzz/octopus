$redis = Redis.new(:host => 'localhost', :port => 6379)

class Generate_uuid
  def self.new
    uuid = ''
    2.times do
      uuid += UUIDTools::UUID.random_create.to_i.to_s[0..7]
    end
    return uuid.to_i
  end
end