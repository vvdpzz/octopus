class AnswersController < ApplicationController
  def create
    answer = Answer.new(params[:answer])

    if answer.valid?
      # answer question info
      answer.question_id = params[:question_id]
      # answer user info
      answer.user_id = current_user.id
      answer.username = current_user.realname
      answer.me = current_user.me
      # insert to redis
      answer.insert_to_redis
    else
      render :new
    end
  end
end
