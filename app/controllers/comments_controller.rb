class CommentsController < ApplicationController
  before_filter :sjobs
  def create
    @comment = Comment.new params[:comment]
    @comment.user_id = current_user.id
    @comment.id = $redis.incr 'next.comment.id'
    @comment.uuid = Generate_uuid.new
    @comment.parent_id = @parent_id
    parent = $redis.hgetall("#{@parent_key[0].chr}:#{@parent_id}")
    @comment.parent_uid = parent["user_id"]
    
    @comment.created_at = @comment.updated_at = Time.now.to_i
    
    
    if @comment.valid?
      # 保存comment       c:123456789
      @comment.attributes.each do |field, value|
        $redis.hset("c:#{@comment.uuid}", field, value)
      end
      # 建 立 comment 和 user 和 question 或 answer 的 索 引
      $redis.sadd("u:#{@comment.user_id}.cs", @comment.uuid)
      $redis.sadd("#{@parent_key}", @comment.uuid)
    end
  end
  
  
  protected
    def sjobs
      params.each do |name, value|
        if name =~ /(.+)_id$/
          @parent_key, @parent_id = "#{$1[0].chr}:#{value}.cs", value
          break
        end
      end
    end
end
