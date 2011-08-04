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
      redirect_to @answer.question
    else
      render :new
    end
  end
end
