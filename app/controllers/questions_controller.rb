class QuestionsController < ApplicationController
  
  def index
    ids = $redis.sort("questions", "q:*->created_at desc")
    @questions = []
    ids.each do |id|
      user_id = $redis.hget("q:#{id}", 'user_id')

      hash = $redis.hgetall("q:#{id}")
      hash['realname'] = $redis.hget("u:#{user_id}", 'realname')
      hash['user_credit'] = $redis.hget("u:#{user_id}", 'credit')

      @questions << MultiJson.encode(hash)
    end
    respond_to do |format|
      format.html
      format.json {render :json => @questions}
    end
  end
  
  def ask_question
    questions = Question.questions_list
  end
  
  def show
    @question = MultiJson.encode($redis.hgetall("q:#{params[:id]}"))
    answer_ids = $redis.smembers("q:#{params[:id]}.as")
    answer_ids.each do |answer_id|
      @answers << MultiJson.encode($redis.hgetall("a:#{answer_id}"))
    end
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new params[:question]

    @question.id = $redis.incr 'next.question.id'
    @question.uuid = Generate_uuid.new
    @question.user_id = current_user.id
    @question.created_at = @question.updated_at = Time.now.to_i

    if @question.valid?

      @question.attributes.each do |field, value|
        $redis.hset("q:#{@question.uuid}", field, value)
      end
      # 添 加 用 户 用 户 问 题 索 引
      $redis.sadd("u:#{@question.user_id}.qs", @question.uuid)


      # 悬 赏 问 题
      if @question.not_free?
        
        user_new_credit = $redis.hget("u:#{current_user.id}", 'credit').to_i - @question.credit
        $redis.hset("u:#{current_user.id}", 'credit', user_new_credit)
        
        user_new_money = $redis.hget("u:#{current_user.id}", 'money').to_i - @question.money
        $redis.hset("u:#{current_user.id}", 'money', user_new_money)
        
      end
      # 问 题 集 合（ 供 排 序 ）
      $redis.sadd("questions", @question.uuid)

      redirect_to questions_url
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
