puts "Removing all users >_<\n\n"
User.delete_all

puts "Creating some test users >_<\n\n"
User.create(:uuid => Generate_uuid.new, :email => 'vvdpzz@gmail.com', :password => 'vvdpzz', :realname => '陈振宇', :username => 'vvdpzz')
User.create(:uuid => Generate_uuid.new, :email => 'tzzzoz@gmail.com', :password => 'tzzzoz', :realname => '喻柏程', :username => 'tzzzoz')

$redis.multi do
  puts "Flushing redis db >_<\n\n"
  $redis.flushdb

  puts "Push users to redis >_<\n"
  User.all.each do |user|
    puts "\tuser #{user.id} ready"
    user.attributes.each do |attr_name, attr_value|
      $redis.hset("u:#{user.id}", attr_name, attr_value)
    end
  end

end