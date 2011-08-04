class QuestionsController < ApplicationController
  
  def index
    #followers lastest status
    
    #groups lastest status
  end
  
  def ask_question
    questions = Question.questions_list
  end
  
  def show
    value = $redis.hget('questions', params[:id])
    @question = JSON.parse value
    hash_name = "questions:#{params[:id]}"
    @answers = $redis.hvals(hash_name)
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new params[:question]
    
    # asker info
    @question.user_id = current_user.id
    @question.username = current_user.realname
    
    if @question.valid?
      @question.insert_to_redis
      redirect_to @question
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
