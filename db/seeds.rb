puts "Removing all users >_<\n\n"
User.delete_all

puts "Creating some test users >_<\n\n"
User.create(:email => 'vvdpzz@gmail.com', :password => 'vvdpzz', :realname => '陈振宇', :username => 'vvdpzz')
User.create(:email => 'tzzzoz@gmail.com', :password => 'tzzzoz', :realname => '喻柏程', :username => 'tzzzoz')

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

  puts "Push question and answer's user info to redis >_<\n\n"

  Question.all.each do |question|
    $redis.set("q:#{question.id}.uid", question.user_id)
  end
  
  Answer.all.each do |answer|
    $redis.set("a:#{answer.id}.uid", answer.user_id)
  end
end