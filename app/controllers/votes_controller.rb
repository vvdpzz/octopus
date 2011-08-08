class VotesController < ApplicationController
  before_filter :sjobs
  
  # TODO
  # answer is voted up        +10
  # question is voted up      +5
  # question is voted down    -2
  # answer is voted down      -2  (-1 to voter)
  
  def up
    $redis.multi do
      current_user_credit = $redis.hget("u:#{current_user.id}", 'credit').to_i
      user_vote_per_day = $redis.hget("u:#{current_user.id}", 'vote_per_day').to_i
      if current_user_credit > 15 and user_vote_per_day > 0 and $redis.incr(@key) > 0
        # 投 票 次 数 控 制
        $redis.hset("u:#{current_user.id}", 'vote_per_day', user_vote_per_day - 1)
        user_id = $redis.get("#{@key[0].chr}:#{@id}.uid")

        if @key[0].chr == 'q'
          credit = $redis.hget("u:#{user_id}", 'credit').to_i + APP_CONFIG['question_vote_up']
        elsif @key[0].chr == 'a'
          credit = $redis.hget("u:#{user_id}", 'credit').to_i + APP_CONFIG['answer_vote_up']
        end
        $redis.hset("u:#{user_id}", 'credit', credit)
      end
    end
  end
  
  def down
    $redis.multi do
      current_user_credit = current_user_credit.to_i
      user_vote_per_day = $redis.hget("u:#{current_user.id}", 'vote_per_day').to_i
      if current_user_credit > 125 and user_vote_per_day > 0 and $redis.incr(@key) > 0
        # 投 票 次 数 控 制
        $redis.hset("u:#{current_user.id}", 'vote_per_day', user_vote_per_day - 1)
        user_id = $redis.get("#{@key[0].chr}:#{@id}.uid")
        
        if @key[0].chr == 'q'
          credit = $redis.hget("u:#{user_id}", "credit").to_i - APP_CONFIG['question_vote_down']
        elsif @key[0].chr == 'a'
          credit = $redis.hget("u:#{user_id}", "credit").to_i - APP_CONFIG['answer_vote_down']
          
          # answer is voted down      -2  (-1 to voter)
          current_user_credit -= APP_CONFIG['answer_vote_down_to_voter']
          $redis.hset("u:#{current_user.id}", 'credit', current_user_credit)
        end
        
        $redis.hset("u:#{user_id}", 'credit', credit)
      end
    end
  end
  
  protected
    def sjobs
      params.each do |name, value|
        if name =~ /(.+)_id$/
          @key, @id = "#{$1}s:#{value}:vote", value
          break
        end
      end
    end
end
