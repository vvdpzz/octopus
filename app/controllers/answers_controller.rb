class AnswersController < ApplicationController
  def create
    @answer = Answer.new(params[:answer])
    
    # answer question info
    @answer.question_id = params[:question_id]
    # answer user info
    @answer.user_id = current_user.id
    @answer.username = current_user.realname
    @answer.me = current_user.me

    if @answer.valid?
      @answer.insert_to_redis
      #***************
      $redis.set("a:#{@answer.id}:uid", current_user.id)
      
      redirect_to "/questions/#{params[:question_id]}"
    else
      render :new
    end
  end
end
