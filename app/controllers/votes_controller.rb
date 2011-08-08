class VotesController < ApplicationController
  before_filter :sjobs
  
  # TODO
  # answer is voted up        +10
  # question is voted up      +5
  # question is voted down    -2
  # answer is voted down      -2  (-1 to voter)
  
  def up
    puts @k
    current_user_credit = $redis.hget("users:#{current_user.id}", 'credit')
    if not current_user_credit.nil?
      current_user_credit = current_user_credit.to_i
      user_vote_per_day = $redis.hget("users:#{current_user.id}", 'vote_per_day').to_i
      if current_user_credit > 15 and user_vote_per_day > 0 and $redis.incr(@k) > 0
          # 投 票 次 数 控 制
          $redis.hset("users:#{current_user.id}", 'vote_per_day', user_vote_per_day - 1)
          user_id = $redis.get("#{@k[0..0]}:#{@v}:uid")
          
          if @k[0..0] == 'q'
            amount = $redis.hget("users:#{user_id}", "credit").to_i + APP_CONFIG['question_vote_up']
            $redis.hset("users:#{user_id}", "credit", amount)
          end
          
          if @k[0..0] == 'a'
            amount = $redis.hget("users:#{user_id}", "credit").to_i + APP_CONFIG['answer_vote_up']
            $redis.hset("users:#{user_id}", "credit", amount)
          end
      end
    end
  end
  
  def down
    current_user_credit = $redis.hget("users:#{current_user.id}", 'credit')
    if not current_user_credit.nil?
      current_user_credit = current_user_credit.to_i
      user_vote_per_day = $redis.hget("users:#{current_user.id}", 'vote_per_day').to_i
      if current_user_credit > 125 and user_vote_per_day > 0 and $redis.incr(@k) > 0
          # 投 票 次 数 控 制
          $redis.hset("users:#{current_user.id}", 'vote_per_day', user_vote_per_day - 1)
          user_id = $redis.get("#{@k[0,1]}:#{@v}:uid")
          
          if @k[0..0] == 'q'
            amount = $redis.hget("users:#{user_id}", "credit").to_i - APP_CONFIG['question_vote_down']
            $redis.hset("users:#{user_id}", "credit", amount)
          end
          
          if @k[0..0] == 'a'
            amount = $redis.hget("users:#{user_id}", "credit").to_i - APP_CONFIG['answer_vote_down']
            $redis.hset("users:#{user_id}", "credit", amount)
            current_user_credit -= APP_CONFIG['answer_vote_down_to_voter']
            $redis.hset("users:#{current_user.id}", "credit", current_user_credit)
          end
      end
    end
  end
  
    def sjobs
      params.each do |name, value|
        if name =~ /(.+)_id$/
          puts "#{$1}s:#{value}:vote"
          @k, @v = "#{$1}s:#{value}:vote", value
          puts @k
          break
        end
      end
    end
end
