class VotesController < ApplicationController
  before_filter :sjobs
  
  # TODO
  # answer is voted up        +10
  # question is voted up      +5
  # question is voted down    -2
  # answer is voted down      -2  (-1 to voter)
  
  def up
    current_user_credit = $redis.hget("users:#{current_user.id}", 'credit')
    if not current_user_credit.nil?
      current_user_credit = current_user_credit.to_i
      user_vote_per_day = $redis.hget("users:#{current_user.id}", 'vote_per_day').to_i
      if current_user_credit > 15 and user_vote_per_day > 0
        if $redis.incr(key) > 0
          $redis.hset("users:#{current_user.id}", 'vote_per_day', user_vote_per_day - 1)
          if params[:answer_id].presence?
            
            
          end
        end
      end
    end
  end
  
  def down
    $redis.decr(key) if current_user.credit > 125
  end
  
  protected
    def sjobs
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return key, obj = "#{$1}s:#{value}:vote", $1
        end
      end
    end
end
