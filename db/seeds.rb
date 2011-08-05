puts "Removing all users >_<\n\n"
User.delete_all

puts "Creating some test users >_<\n\n"
User.create(:email => 'vvdpzz@gmail.com', :password => 'vvdpzz')
User.create(:email => 'tzzzoz@gmail.com', :password => 'tzzzoz')

puts "Flushing redis db >_<\n\n"
$redis.flushdb

puts "Push users to redis >_<\n"
User.all.each do |user|
  puts "\tuser #{user.id} ready"
  user.attributes.each do |attr_name, attr_value|
    $redis.hset("users:#{user.id}", attr_name, attr_value)
  end
end