class QuestionsController < ApplicationController
  
  def index
    @questions = Question.all
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = current_user.questions.build(params[:question])
    if @question.save
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
