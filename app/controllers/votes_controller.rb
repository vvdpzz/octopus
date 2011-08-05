class VotesController < ApplicationController
  before_filter :sjobs
  
  # TODO
  # answer is voted up        +10
  # question is voted up      +5
  # question is voted down    -2
  # answer is voted down      -2  (-1 to voter)
  
  def up
    $redis.incr(key) if current_user.credit > 15
  end
  
  def down
    $redis.decr(key) if current_user.credit > 125
  end
  
  protected
    def sjobs
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return key = "#{$1}s:#{value}:vote"
        end
      end
    end
end
