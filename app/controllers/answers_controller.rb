class AnswersController < ApplicationController
  def create
    @answer = Answer.new params[:answer]
    
    @answer.id = $redis.incr 'next.answer.id'
    @answer.uuid = Generate_uuid.new
    @answer.question_id = params[:question_id]
    @answer.user_id = current_user.id
    @answer.created_at = @answer.updated_at = Time.now.to_i
    question = $redis.hgetall("q:#{params[:question_id]}")
    @answer.quid = question['user_id']
    

    if @answer.valid?
      @answer.attributes.each do |field, value|
        $redis.hset("a:#{@answer.uuid}", field, value)
      end
      # 添 加 用 户 和 答 案 的 索 引
      $redis.sadd("u:#{@answer.user_id}.as", @answer.uuid)
      
      # 添 加 问 题 和 答 案 的 索 引
      $redis.sadd("q:#{@answer.question_id}.as", @answer.uuid)
      
      # 判 断 问 题 是 否 有 悬 赏
      if question['credit'].to_i != 0 || question['money'].to_f != 0.0
        user_new_credit = $redis.hget("u:#{current_user.id}", "credit").to_i - APP_CONFIG['answer_charge']
        $redis.hset("u:#{current_user.id}", "credit", user_new_credit)
      end
      
      redirect_to "/questions/#{params[:question_id]}"
    else
      render :new
    end
  end
end