class QuestionsController < ApplicationController
  
  def index
    #followers lastest status
    
    #groups lastest status
  end
  
  def ask_question
    questions = Question.questions_list
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new params([:question])
    
    if answer.valid?
      # asker info
      question.user_id = current_user.id
      question.username = current_user.realname
      question.me = current_user.me
      # insert to redis
      question.insert_to_redis
    else
      render :new
    end
  end
  
  def edit
    @question = current_user.questions.find params[:id]
  end
  
  def update
    if @questions.update_attributes(params[:question])
      redirect_to @question
    else
      render :edit
    end
  end
  
  def destroy
    @question.destroy
    redirect_to questions_url
  end
end
